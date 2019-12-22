# TerraTouchBar
A tModLoader Terraria mod to add Touch Bar functionality to Terraria for supported MacBook Pros, with the app written in Swift and the mod written in C#.

## Notes
There are currently a few **major** issues with the project, the main one being that there are *vast* memory leaks when receiving updates to the inventory. Since the mod isn't included in this repository *(yet)*, I've taken the liberty of adding a `Send mockup update` button to the `ContentView`, so that "mockup" updates can be sent. This allows anyone to debug these memory leaks!

Any feedback would be greatly appreciated.
