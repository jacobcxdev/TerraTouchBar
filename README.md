# TerraTouchBar
A tModLoader Terraria mod to add Touch Bar functionality to Terraria for supported MacBook Pros, with the app written in Swift and the mod written in C#.

## Installation
1) Purchase and install [Terraria](https://terraria.org/) and [tModLoader](https://github.com/tModLoader/tModLoader).
2) Download and extract `TerraTouchBar.zip` from the [releases](https://github.com/jacobcxdev/TerraTouchBar/releases) page.
3) Copy the extracted application to your desired location (e.g: `/Applications`).
4) Either download `TerraTouchBar` from tModLoader's Mod Browser, or download `TerraTouchBar.tmod` from the [releases](https://github.com/jacobcxdev/TerraTouchBar/releases) page and copy it to `~/Library/Application Support/Terraria/ModLoader/Mods`.

## Usage
Simply launch Terraria and the TerraTouchBar application. The mod and the application will communicate automatically.

## Notes
There are currently a few **major** issues with the project, the main one being that there are *vast* memory leaks when receiving updates to the inventory. I've taken the liberty of adding a `Preview` button to the `ContentView`, so that "mockup" updates can be sent. This allows anyone to debug these memory leaks, regardless of whether they own Terraria.

To create the memory leaks (for debugging):
1) Launch the Xcode project
2) Build and run
3) Click the `Preview` button
4) Leave the application for a few minutes.

## Mockup
![Mockup](https://github.com/jacobcxdev/TerraTouchBar/blob/master/Mockup.png?raw=true)
