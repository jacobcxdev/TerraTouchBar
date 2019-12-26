using System.Threading;
using Terraria;
using Terraria.ModLoader;

namespace TerraTouchBar {
    public class TerraTouchBar : Mod {
        private Thread thread;

        public override void Load() {
            base.Load();
            thread = new Thread(() => TCP.Listen("127.0.0.1", 1718));
            thread.Start();
        }

        public override void Unload() {
            base.Unload();
            thread.Abort();
        }

        public override void PreSaveAndQuit() {
            base.PreSaveAndQuit();
            foreach (Player player in Main.player) {
                if (player.active) {
                    TTBPlayer modPlayer = player.GetModPlayer<TTBPlayer>();
                    modPlayer.inventory.Clear();
                    modPlayer.life = new LifeStats();
                    modPlayer.mana = new ManaStats();
                    modPlayer.inventoryShouldUpdate = true;
                    modPlayer.lifeShouldUpdate = true;
                    modPlayer.manaShouldUpdate = true;
                    modPlayer.SendUpdate();
                }
            }
        }
    }
}
