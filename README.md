# TerraTouchBar
A tModLoader Terraria mod to add Touch Bar functionality to Terraria for supported MacBook Pros, with the app written in Swift and the mod written in C#.

## Notes
There are currently a few issues with the project, the main one being that there are memory leaks when receiving updates to the inventory. Since the mod isn't included in this repository *(yet)*, I've taken the liberty of adding a `Send mockup update` button to the `ContentView`, so that "mockup" updates can be sent. This allows anyone to debug these memory leaks!

To create the memory leaks (for debugging):
1) Launch the Xcode project
2) Build and run
3) Spam the `Send mockup update` button
4) Switch back to Xcode and begin debugging!

Any feedback would be greatly appreciated.

## Mockup
![Mockup](https://github.com/jacobcxdev/TerraTouchBar/blob/master/Mockup.png?raw=true)
