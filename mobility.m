classdef mobility
    methods(Static)
        function forwards(obj)
            obj.brick.MoveMotor('B',50);
            obj.brick.MoveMotor('C',50);
            %pause(0.1);
            %obj.brick.StopAllMotors();
        end
        function backwards(obj)
            obj.brick.MoveMotor('B',-50);
            obj.brick.MoveMotor('C',-50);
            %pause(0.1);
            %obj.brick.StopAllMotors();
        end
        function turnRight(obj)
            obj.brick.MoveMotor('C',50);
            obj.brick.MoveMotor('B',-50);
            %pause(0.1);
            %obj.brick.StopAllMotors();
        end
        function turnLeft(obj)
            obj.brick.MoveMotor('B',50);
            obj.brick.MoveMotor('C',-50);
            %pause(0.1);
            %obj.brick.StopAllMotors();
        end
        function turnRightA(obj)
            angle = 0;
            %obj.brick.GyroCalibrate(2);
            cur = obj.brick.GyroAngle(2); 
            while angle <=80
                   obj.brick.MoveMotor('B',-50);
                   obj.brick.MoveMotor('C',50);
                   angle = obj.brick.GyroAngle(2)-cur;
            end
            obj.brick.StopAllMotors();
        end
        function turnLeftA(obj)
        angle = 0;
        %obj.brick.GyroCalibrate(2);
        cur = obj.brick.GyroAngle(2); 
        while angle >=-80
               obj.brick.MoveMotor('B',50);
               obj.brick.MoveMotor('C',-50);
               angle = obj.brick.GyroAngle(2)-cur;
        end
        obj.brick.StopAllMotors();
        end
        function PID_turnAtAngle(obj, angle)
    % PID Controller Parameters for the turn
    Kp_turn = 0.5;   % Proportional gain for turn
    Ki_turn = 0.05;  % Integral gain for turn
    Kd_turn = 0.1;   % Derivative gain for turn
    turn_tolerance = 5; % Tolerance for considering the turn complete

    % Initialize PID variables for the turn
    integral_turn = 0;
    previous_error_turn = 0;

    % Calculate the target angle based on the current gyro reading
    target_angle = obj.brick.GyroAngle(obj.GYRO_SENSOR_PORT) + angle;

    % Define the maximum motor speed for turning
    max_turn_speed = 50;

    while true
        % Calculate the error between the target angle and the current angle
        current_angle = obj.brick.GyroAngle(obj.GYRO_SENSOR_PORT);
        error_turn = target_angle - current_angle;

        % Check if the turn is within the specified tolerance
        if abs(error_turn) < turn_tolerance
            break;  % Turn is complete
        end

        % Apply PID control to adjust the motor speeds for turning
        P_turn = Kp_turn * error_turn;
        integral_turn = integral_turn + error_turn;
        I_turn = Ki_turn * integral_turn;
        derivative_turn = error_turn - previous_error_turn;
        D_turn = Kd_turn * derivative_turn;

        % Calculate the motor speed adjustment
        motor_speed_turn = P_turn + I_turn + D_turn;

        % Limit the motor speed to avoid excessive speed
        if motor_speed_turn > max_turn_speed
            motor_speed_turn = max_turn_speed;
        elseif motor_speed_turn < -max_turn_speed
            motor_speed_turn = -max_turn_speed;
        end

        % Set the motor speeds for turning
        obj.brick.MoveMotor(obj.MOTOR_B, motor_speed_turn);
        obj.brick.MoveMotor(obj.MOTOR_C, -motor_speed_turn);  % Inverted for turning

        % Update previous error for the next iteration
        previous_error_turn = error_turn;

        % Add a small delay to control the PID loop frequency
        pause(0.01);
    end

    % Stop all motors after completing the turn
    obj.brick.StopAllMotors;
end

    end
end
