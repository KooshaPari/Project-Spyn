function autonomy(obj)
    global brick;
    brick = obj.brick;
    brick.SetColorMode(3, 1);

    % ControlModule(obj);

    % Initialize variables for path tracking
    angularLeftTurns = 0;
    hasTurned180 = false;

    while true
        % Data Collection; Distance & Color
        pause(0.05);
        color = brick.ColorCode(3);
        distance1 = brick.UltrasonicDist(1);
        disp("Current Distance: " +distance1);

        % Object Avoidance Process
        if (distance1 < 30)
            disp('Obstacle Detected, Beginning Turn Sequence...');
            if (distance1 < 10)
                disp("Risk of Collision on Turn, Backing Up...");
                mobility.backwards(obj);
                disp("Backing Completed.");
                pause(0.5);
            end
            mobility.turnLeftA(obj);
            disp("Turn Sequence Completed, Moving Forward.");

            brick.StopAllMotors();
            distance1 = brick.UltrasonicDist(1);
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
                brick.playTone(100, 800, 500);
                ControlModule(obj);
                disp("Passenger Picked Up.");
            end
            if color == 4
                disp("Yellow Zone Detected, Switching to Remote Control...");
                brick.StopAllMotors();
                ControlModule(obj);
            end
            if color == 3
                disp("Green Zone Detected, Switching to Remote Control...");
                brick.playTone(100, 800, 500);
                brick.playTone(100, 800, 500);
                brick.playTone(100, 800, 500);
                brick.StopAllMotors();
                ControlModule(obj);
                disp("Passenger Dropped Off");
            end

            disp("Autopilot Mode Re-Engaged.");
        end

        mobility.forwards(obj);

        % Track angular left turns
        if abs(brick.GyroAngle(2)) > 10 % Assuming 10 degrees is a significant left turn
            angularLeftTurns = angularLeftTurns + 1;
        end

        % Check if all paths from 0 to 270 degrees (except 180) are closed
        if angularLeftTurns >= 9 && ~hasTurned180
            disp("All paths from 0 to 270 degrees are closed. Turning back to 180 degrees.");
            mobility.PID_turnAtAngle(obj, 180);
            hasTurned180 = true;
        end

        % Check if we've turned 180 degrees and exit
        if hasTurned180 && angularLeftTurns == 0
            disp("Exiting the maze by making a right turn.");
            mobility.PID_turnAtAngle(obj, -90);
            brick.StopAllMotors();
            break;
        end
    end
end
