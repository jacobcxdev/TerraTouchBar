using System.IO;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using Newtonsoft.Json;
using Terraria;
using Terraria.ID;

namespace TerraTouchBar {
    public struct TTBItem {
        public string name;
        public int stack;
        public bool canUseItem;
        public bool isSelected;
        public bool isAir;
        public Texture texture;

        public TTBItem(Item item, Player player) {
            name = item.Name;
            stack = item.stack;
            canUseItem = (!player.HasBuff(21) || item.healLife <= 0) && (!player.HasBuff(94) || item.healMana <= 0);
            isSelected = player.HeldItem.Equals(item);
            isAir = item.IsAir;
            texture = new Texture(item);
        }

        public override string ToString() {
            return JsonConvert.SerializeObject(this);
        }

        public struct Texture {
            public byte[] data;
            public float width;
            public float height;
            public bool isAnimated;
            public bool pulsates;
            public int frameCount;
            public int ticksPerFrame;

            public Texture(Item item) {
                Texture2D texture2D = Main.itemTexture[item.type];
                MemoryStream s = new MemoryStream();
                texture2D.SaveAsPng(s, texture2D.Width, texture2D.Height);
                data = s.ToArray();
                isAnimated = Main.itemAnimations[item.type] != null;
                pulsates = ItemID.Sets.ItemIconPulse[item.type];
                Rectangle frame = (!item.IsAir && isAnimated) ? Main.itemAnimations[item.type].GetFrame(texture2D) : texture2D.Frame(1, 1, 0, 0);
                width = frame.Width;
                height = frame.Height;
                frameCount = isAnimated ? Main.itemAnimations[item.type].FrameCount : 1;
                ticksPerFrame = isAnimated ? Main.itemAnimations[item.type].TicksPerFrame : 0;
            }
        }
    }
}
