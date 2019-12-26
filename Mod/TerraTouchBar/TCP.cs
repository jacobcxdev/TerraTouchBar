using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using Microsoft.Xna.Framework.Input;
using Newtonsoft.Json;
using Terraria;
using Terraria.ModLoader;

namespace TerraTouchBar {
    public static class TCP {
        public static void Listen(string address, int port) {
            TcpListener server = new TcpListener(IPAddress.Parse(address), port);
            try {
                server.Start();
                while (true) {
                    ModContent.GetInstance<TerraTouchBar>().Logger.Debug("Listening...");
                    TcpClient client = server.AcceptTcpClient();
                    ModContent.GetInstance<TerraTouchBar>().Logger.Debug("Connected");
                    new Thread(() => HandleDeivce(client)).Start();
                }
            } catch (ArgumentNullException e) {
                ModContent.GetInstance<TerraTouchBar>().Logger.Debug(string.Format("ArgumentNullException: {0}", e));
            } catch (SocketException e2) {
                ModContent.GetInstance<TerraTouchBar>().Logger.Debug(string.Format("SocketException: {0}", e2));
                server.Stop();
            }
        }

        private static void HandleDeivce(TcpClient client) {
            NetworkStream stream = client.GetStream();
            byte[] bytes = new byte[256];
            try {
                int i;
                while ((i = stream.Read(bytes, 0, bytes.Length)) != 0) {
                    bytes.ToString();
                    string data = Encoding.UTF8.GetString(bytes, 0, i);
                    switch (data) {
                    case "player_info":
                        foreach (Player player in Main.player) {
                            if (player.active) {
                                TTBPlayer modPlayer = player.GetModPlayer<TTBPlayer>();
                                modPlayer.inventoryShouldUpdate = true;
                                modPlayer.lifeShouldUpdate = true;
                                modPlayer.manaShouldUpdate = true;
                                modPlayer.SendUpdate();
                            }
                        }
                        break;
                    case "escape":
                        Main.keyState = new KeyboardState(new Keys[] { Keys.Escape });
                        break;
                    case "hotbar1":
                        Main.keyState = new KeyboardState(new Keys[] { Keys.D1 });
                        break;
                    case "hotbar2":
                        Main.keyState = new KeyboardState(new Keys[] { Keys.D2 });
                        break;
                    case "hotbar3":
                        Main.keyState = new KeyboardState(new Keys[] { Keys.D3 });
                        break;
                    case "hotbar4":
                        Main.keyState = new KeyboardState(new Keys[] { Keys.D4 });
                        break;
                    case "hotbar5":
                        Main.keyState = new KeyboardState(new Keys[] { Keys.D5 });
                        break;
                    case "hotbar6":
                        Main.keyState = new KeyboardState(new Keys[] { Keys.D6 });
                        break;
                    case "hotbar7":
                        Main.keyState = new KeyboardState(new Keys[] { Keys.D7 });
                        break;
                    case "hotbar8":
                        Main.keyState = new KeyboardState(new Keys[] { Keys.D8 });
                        break;
                    case "hotbar9":
                        Main.keyState = new KeyboardState(new Keys[] { Keys.D9 });
                        break;
                    case "hotbar0":
                        Main.keyState = new KeyboardState(new Keys[] { Keys.D0 });
                        break;
                    }
                }  
            } catch (Exception e) {
                ModContent.GetInstance<TerraTouchBar>().Logger.Debug(string.Format("Exception: {0}", e));
                client.Close();
            }
        }

        public static void Send(string message, string address, int port) {
            try {
                TcpClient tcpClient = new TcpClient(address, port);
                byte[] data = Encoding.UTF8.GetBytes(string.Format("{0}<EOF>", message));
                NetworkStream stream = tcpClient.GetStream();
                stream.Write(data, 0, data.Length);
                ModContent.GetInstance<TerraTouchBar>().Logger.Debug(string.Format("Sent: {0}", message));
                stream.Close();
                tcpClient.Close();
            } catch (ArgumentNullException e) {
                ModContent.GetInstance<TerraTouchBar>().Logger.Debug(string.Format("ArgumentNullException: {0}", e));
            } catch (SocketException e2) {
                ModContent.GetInstance<TerraTouchBar>().Logger.Debug(string.Format("SocketException: {0}", e2));
            }
        }

        public struct PlayerInfoPackage {
            public List<TTBItem> inventory;
            public Stats stats;

            public PlayerInfoPackage(List<TTBItem> inventory, LifeStats? life, ManaStats? mana) {
                this.inventory = inventory;
                stats = new Stats(life, mana);
            }

            public override string ToString() {
                return JsonConvert.SerializeObject(this);
            }

            public struct Stats {
                public LifeStats? life;
                public ManaStats? mana;

                public Stats(LifeStats? life, ManaStats? mana) {
                    this.life = life;
                    this.mana = mana;
                }
            }
        }
    }
}
