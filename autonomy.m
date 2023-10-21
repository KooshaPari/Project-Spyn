brick.SetColorMode(3, 1); 
ControlModule();
while true
    % Data Collection; Distance & Color
    pause(0.05);
    color = brick.ColorCode(3); 
    distance1 = brick.UltrasonicDist(1);
    disp("Current Distance: " +distance1);
    
    % Object Avoidance Process
    if (distance1 <30)
        disp('Obstacle Detected, Beginning Turn Sequence...');
       if(distance1<10)
           disp("Risk of Collision on Turn, Backing Up...");
           backwards();
           disp("Backing Completed.");
           pause(0.5);
       end
       mobility.turnLeftA();
       disp("Turn Sequence Completed, Moving Forward.");
    end
        brick.StopAllMotors();
        distance1 = brick.UltrasonicDist(1);

    % Zone Detection Process    
    if color ==5
        disp("Red Light Detected, Stopping Vehicle...");
        brick.StopAllMotors();
        pause(2);
        disp("Moving Forwards.");
         mobility.forwards();
        pause(1);
    elseif color == 2 || color || 
        if color == 2
            Disp("Blue Zone Detected, Switching to Remote Control...");
            brick.StopAllMotors();
            ControlModule();
            disp("Passenger Picked Up.");
        end
        if color == 4
            Disp("Yellow Zone Detected, Switching to Remote Control...");
            brick.StopAllMotors();
    `       ControlModule();
        end
        if color == 3
            Disp("Green Zone Detected, Switching to Remote Control...");
            brick.StopAllMotors();
    `       ControlModule();
            Disp("Passenger Dropped Off");
        end
        
        Disp("Autopilot Mode Re-Engaged.");
    end

    mobility.forwards();   
end
% Keep Log of amount of angular left turns, skip 180deg then if all turns
% from 0 to 270 sans 180 are closed, turn back to 180deg and exit, making a
% right turn.