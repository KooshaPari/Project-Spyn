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
    end
end
