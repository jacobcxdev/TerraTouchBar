using Newtonsoft.Json;
using Terraria;

namespace TerraTouchBar {
    public struct ManaStats {
        public int max;
        public int current;

        public ManaStats(Player player) {
            max = player.statManaMax2;
            current = player.statMana;
        }

        public override string ToString() {
            return JsonConvert.SerializeObject(this);
        }
    }
}
