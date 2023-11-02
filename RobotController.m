classdef RobotController
    properties
        brick;
    end
    properties (Constant)
        FORWARD_SENSOR_PORT = 1;
        GYRO_SENSOR_PORT = 2;
        COLOR_SENSOR_PORT = 3;
        MOTOR_B = 'C'; % Left front motor
        MOTOR_C = 'B'; % Right front motor
    end
methods
        function obj = RobotController()
            % Connect to Brick.
            obj.brick = ConnectBrick('EPIKS');
            % Play tone with frequency 800Hz and duration of 500ms.
            %brick.playTone(100, 800, 500);
            disp('RobotController initialized.');
        end
        
        function start(obj)
            obj.brick.GyroCalibrate(obj.GYRO_SENSOR_PORT);
            obj.brick.SetColorMode(obj.COLOR_SENSOR_PORT, 1); 
            ControlModule(obj);
            autonomy(obj);
        end
        end
end


