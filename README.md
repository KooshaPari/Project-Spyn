# Project-Spyn
ASU FSE100 Project

Creating a Semi-Autonomous Vehicle capable of "picking up" (in the most literal sense) passengers and navigating a maze; avoiding obstacles/walls and detecting color zones on the floor for stops/changes to remote control.

## Capabilities, Assumptions, & Limitations

### Capabilites
Navigate a semi-linear simplistic maze, detect "stop-signs", pick-up/drop-off zones, and pick-up/drop-off passengers while avoiding obstacles along the way.

### Assumptions

Simple Semi-Linear Maze Pattern that does not have false roads straying too far.
Each Maze Block is equal in radius and dimensions. 
Walls are perfectly perpindicular to the floor and all angles present on the walls, turns, and floor are 90 degrees or multiples of such.

### Limitations

There is no current way to handle T-Shaped Dead-ends, as in a Maze pattern that is a road that ends with both the left and right turn resulting in another dead-end, but still being a new-road such that the ultrasonic sensor reads its distance as greater than the radius of each maze-block. This requires a different sensor array configuration and hte current array will simply keep traversing from one end to the other.


