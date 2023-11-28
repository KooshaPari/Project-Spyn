function autonomy(obj)
    global brick;
    brick = obj.brick;
    brick.SetColorMode(3, 1);

    while true
        % Data Collection; Distance & Color
        pause(0.05);
        color = brick.ColorCode(3);
        distance1 = brick.UltrasonicDist(1);
        pause(0.1);
        distance2 = brick.UltrasonicDist(1);
        pause(0.1);
        distance3 = brick.UltrasonicDist(1);
        dist = (distance1+distance2+distance3)/3
        disp("Current Distance: " +dist);

        % Object Avoidance Process
        if (dist < 30)
            disp('Obstacle Detected, Beginning Turn Sequence...');
            if (dist < 10)
                disp("Risk of Collision on Turn, Backing Up...");
                mobility.backwards(obj);
                pause(0.5);
                brick.StopAllMotors();
                disp("Backing Completed.");
            end
            mobility.turn(obj);
            %mobility.forwards(obj);
            disp("Turn Sequence Completed, Moving Forward.");
            brick.StopAllMotors();
            distance1 = brick.UltrasonicDist(1);
            pause(0.1);
             distance2 = brick.UltrasonicDist(1);
             pause(0.1);
                distance3 = brick.UltrasonicDist(1);
                dist = (distance1+distance2+distance3)/3
        end

        % Zone Detection Process    
        if color == 5
            disp("Red Light Detected, Stopping Vehicle...");
            brick.StopAllMotors();
            pause(1);
            disp("Moving Forwards.");
            mobility.forwards(obj);
            pause(1);
        elseif color == 2 || color == 3 || color == 4
            if color == 2
                disp("Blue Zone Detected, Switching to Remote Control...");
                brick.StopAllMotors();
                brick.playTone(100, 800, 500);
                pause(1.5);
                brick.playTone(100, 800, 500);
                run(ControlModule(obj));
                disp("Passenger Picked Up.");
            end
            if color == 4
                disp("Yellow Zone Detected, Switching to Remote Control...");
                brick.StopAllMotors();
                run(ControlModule(obj));
            end
            if color == 3
                disp("Green Zone Detected, Switching to Remote Control...");
                brick.playTone(100, 800, 500);
                pause(1.5);
                brick.playTone(100, 800, 500);
                pause(1.5);
                brick.playTone(100, 800, 500);
                brick.StopAllMotors();
                run(ControlModule(obj));
                disp("Passenger Dropped Off");
            end

            disp("Autopilot Mode Re-Engaged.");
        end

        mobility.forwards(obj);
    end
end
