classdef RobotController
    properties
        brick;
    end
    properties (Constant)
        FORWARD_SENSOR_PORT = 1;
        GYRO_SENSOR_PORT = 2;
        MOTOR_B = 'C'; % Left front motor
        MOTOR_C = 'B'; % Right front motor
    end
methods
        function obj = RobotController()
            % Connect to Brick.
            brick = ConnectBrick('EPIKS');
            % Play tone with frequency 800Hz and duration of 500ms.
            brick.playTone(100, 800, 500);
            obj.isMobilityActive = true;
            obj.exitFlag = false;
            disp('RobotController initialized.');
        end
        
        function start(obj)
            obj.brick.GyroCalibrate(GYRO_SENSOR_PORT);
            while ~obj.exitFlag
                if obj.isMobilityActive
                    obj.PID_lane_centering(obj.brick);
                else
                    pause(0.1);  % Small delay to prevent busy-waiting
                end
            end
        end
end
end

