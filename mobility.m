classdef mobility
    methods(Static)
        function forwards
            brick.MoveMotor('B',50);
            brick.MoveMotor('C',50);
            pause(1);
            brick.StopAllMotors();
        end
        function backwards
            brick.MoveMotor('B',-50);
            brick.MoveMotor('C',-50);
            pause(1);
            brick.StopAllMotors();
        end
        function turnRight
            brick.MoveMotor('C',50);
            brick.MoveMotor('B',-50);
            pause(1);
            brick.StopAllMotors();
        end
        function turnLeft
            brick.MoveMotor('B',50);
            brick.MoveMotor('C',-50);
            pause(1);
            brick.StopAllMotors();
        end
        function turnRightA
            angle = 0;
            brick.GyroCalibrate(2);
            cur = brick.GyroAngle(2); 
            while angle <=80
                   brick.MoveMotor('B',-50);
                   brick.MoveMotor('C',50);
                   angle = brick.GyroAngle(2)-cur;
            end
            brick.StopAllMotors();
        end
        function turnLeftA
        angle = 0;
        brick.GyroCalibrate(2);
        cur = brick.GyroAngle(2); 
        while angle >=-80
               brick.MoveMotor('B',50);
               brick.MoveMotor('C',-50);
               angle = brick.GyroAngle(2)-cur;
        end
        brick.StopAllMotors();
        end
        % Goals: Rotate Sensor in 90deg intervals checking each possible
        % direction for open routes. 
        % Each open route should be noted in an array then chosen with
        % backwards always being lowest prio.
        % New Goals: Scan 360deg 24/7 and use a mathematical modal to only
        % take the scans at 90deg intervals, using that to then self adjust
        % the car through slight speed changes in each motor.
        function scan
            % Basic Setup - Gyro Calibration, Angle Data Collection,
            brick.GyroCalibrate(2);
            curr = brick.GyroAngle(2); 
            paths = [];

            % Loop until 360 degree turn
            while abs(curr-brick.GyroAngle(2)) ~= 359
                %Relative Angle initialization and take current angle
                angle = 0;
                cur = brick.GyroAngle(2); 

                %Scan in 90 degree intervals
                while angle >=-80
                       brick.MoveMotor('D',50);
                       angle = brick.GyroAngle(2)-cur;
                end
                brick.StopAllMotors();
                %Take distance and check if open, if open add to array
                distance1 = brick.UltrasonicDist(1);
                if(distance1>30)
                    paths(end+1) = cur;
                end
            end
                % Choose route
                i=0;
                route = 0;
                len = size(paths);
                while i<len
                    if paths(i) ~= 180
                        route = paths(i);
                    end
                    if i == len-1 && route == 0
                        route = 180;
                    end
                    i = i+1;
                end
                % Turn to set route
                while angle>=route
                    brick.MoveMotor('D',50);
                    angle = brick.GyroAngle(2);
                end
        end
    end
end