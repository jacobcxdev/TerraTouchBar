using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using Terraria;
using Terraria.ModLoader;

namespace TerraTouchBar {
    public class TTBPlayer : ModPlayer {
        public bool inventoryShouldUpdate;
        public bool lifeShouldUpdate;
        public bool manaShouldUpdate;
        public List<TTBItem> inventory;
        public LifeStats? life;
        public ManaStats? mana;

        public override void PostUpdate() {
            base.PreUpdate();
            UpdateInventory();
            UpdateLife();
            UpdateMana();
            if (inventoryShouldUpdate || lifeShouldUpdate || manaShouldUpdate) {
                SendUpdate();
            }
        }

        private void UpdateInventory() {
            List<TTBItem> currentInventory = Utilities.Map((ValueTuple<int, Item> tuple) => new TTBItem(tuple.Item2, player), player.inventory).ToList();
            if (inventory == null) {
                inventoryShouldUpdate = true;
            }
            if (!inventoryShouldUpdate) {
                bool inventoryIsEqual = true;
                for (int i = 0; i < inventory.Count; i++) {
                    inventoryIsEqual &= (inventory[i].ToString() == currentInventory[i].ToString());
                }
                inventoryShouldUpdate = !inventoryIsEqual;
            }
            if (inventoryShouldUpdate) {
                inventory = currentInventory;
            }
        }

        private void UpdateLife() {
            LifeStats currentLifeStats = new LifeStats(player);
            if (life == null) {
                lifeShouldUpdate = true;
            }
            if (!lifeShouldUpdate) {
                lifeShouldUpdate = (life.ToString() != currentLifeStats.ToString());
            }
            if (lifeShouldUpdate) {
                life = currentLifeStats;
            }
        }

        private void UpdateMana() {
            ManaStats currentManaStats = new ManaStats(player);
            if (mana == null) {
                manaShouldUpdate = true;
            }
            if (!manaShouldUpdate) {
                manaShouldUpdate = (mana.ToString() != currentManaStats.ToString());
            }
            if (manaShouldUpdate) {
                mana = currentManaStats;
            }
        }

        public void SendUpdate() {
            mod.Logger.Debug(string.Format("Sending update — Inventory: {0}, Life: {1}, Mana: {2}", inventoryShouldUpdate, lifeShouldUpdate, manaShouldUpdate));
            string json = new TCP.PlayerInfoPackage(inventoryShouldUpdate ? inventory : null, lifeShouldUpdate ? life : null, manaShouldUpdate ? mana : null).ToString();
            inventoryShouldUpdate = false;
            lifeShouldUpdate = false;
            manaShouldUpdate = false;

            new Thread(() => TCP.Send(json, "127.0.0.1", 1717)).Start();

            mod.Logger.Debug("Sent update");
        }
    }
}
