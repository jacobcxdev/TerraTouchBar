using Newtonsoft.Json;
using Terraria;

namespace TerraTouchBar {
    public struct LifeStats {
        public int max;
        public int current;

        public LifeStats(Player player) {
            max = player.statLifeMax2;
            current = player.statLife;
        }

        public override string ToString() {
            return JsonConvert.SerializeObject(this);
        }
    }
}
