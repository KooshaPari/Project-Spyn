# Project-Spyn
ASU FSE100 Project

Creating a Semi-Autonomous Vehicle capable of "picking up" (in the most literal sense) passengers and navigating a maze; avoiding obstacles/walls and detecting color zones on the floor for stops/changes to remote control.

## Branch Info
A variation with a second ultrasonic sensor mounted on a module that's rotated by a medium motor. 
### Intended Effects
Continuously Scan 180deg in front of the vehicle, utilizing a software PID controller, the front ultrasonic, and gyroscope to center the car in its "lane" and do smooth quarter-circle turns without stops, as well as automatic u-turns. The goal is to have the logic done before the vehicle even reaches an intersection, using trigonometry and odd angles to approximate open pathways. Threading will also be utilized to better handle all the processing. 

This is a COMPLEX implementation and one that requires a lot of research into the MATLAB/EV3 docs with a ton of debugging and tuning after. If this is successful however, we'll have implemented a much more ideal self-driving system with minimal errors in this environment.
