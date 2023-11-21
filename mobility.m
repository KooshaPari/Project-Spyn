classdef mobility
    methods(Static)
        function forwards(obj)
            disp("Moving Forwards...");
            obj.brick.MoveMotor('B',50);
            obj.brick.MoveMotor('C',50);
            %pause(0.1);
            %obj.brick.StopAllMotors();
        end
        function backwards(obj)
            disp("Moving Backwards...");
            obj.brick.MoveMotor('B',-50);
            obj.brick.MoveMotor('C',-50);
            %pause(0.1);
            %obj.brick.StopAllMotors();
        end
        function turnRight(obj)
            disp("Turning...");
            obj.brick.MoveMotor('C',50);
            obj.brick.MoveMotor('B',-50);
            %pause(0.1);
            %obj.brick.StopAllMotors();
        end
        function turnLeft(obj)
            disp("Turning...");
            obj.brick.MoveMotor('B',50);
            obj.brick.MoveMotor('C',-50);
            %pause(0.1);
            %obj.brick.StopAllMotors();
        end
        function turnRightA(obj)
            disp("Turning...");
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
        disp("Turning...");
        angle = 0;
        %obj.brick.GyroCalibrate(2);
        cur = obj.brick.GyroAngle(2); 
        while angle<=88 || angle >= 92
        if abs(angle) <=90
               obj.brick.MoveMotor('B',70);
               obj.brick.MoveMotor('C',-70);
               angle = obj.brick.GyroAngle(2)-cur;
               %disp(angle);
        end
        if abs(angle) >=90
               obj.brick.MoveMotor('B'-70);
               obj.brick.MoveMotor('C',70);
               angle = obj.brick.GyroAngle(2)-cur;
               %disp(angle);
        end
        
        obj.brick.StopAllMotors();
        end
        end

        function scan(obj)
            % Stores three booleans, each representing a possible pathway (left turn, right turn, u-turn)
            routes = [false, false, false];
            
            % Perform three scans, one for each route
            for n = 1:3
                disp("Scan " + n);
                mobility.PID_turn(obj, -90); % Adjust angle for each scan
                distanc = obj.brick.UltrasonicDist(obj.FORWARD_SENSOR_PORT);
                disp("Distance at Route " + n + ": " + distanc);
                pause(0.5);
                if distanc >= 30
                    routes(n) = true;
                    disp("Route " + n + " Open.");
                end 
            end
            
            % Decide which route to take
            chosen_route = find(routes, 1);
            if ~isempty(chosen_route)
                disp("Trying Route #" + chosen_route);
                if chosen_route == 1
                    disp("Left Route Chosen");
                    mobility.PID_turn(obj, -90);
                elseif chosen_route == 2
                    disp("Right Route Chosen");
                    mobility.PID_turn(obj, 90);
                elseif chosen_route == 3
                    disp("U-Turn Route Chosen");
                    mobility.PID_turn(obj, 180);
                end
            end
            
            % Continue with lane centering
            mobility.forwards(obj);
            %mobility.PID_lanecenter(obj);
        end
        function PID_turn(obj, angle)
            disp("Turning " + angle + "degrees...");
            % PID Controller Parameters for the turn
            Kp_turn = 0.5;   % Proportional gain for turn
            Ki_turn = 0.05;  % Integral gain for turn
            Kd_turn = 0.1;   % Derivative gain for turn
            turn_tolerance = 10; % Tolerance for considering the turn complete

            % Initialize PID variables for the turn
            integral_turn = 0;
            previous_error_turn = 0;

            % Calculate the target angle based on the current gyro reading
            current_angle = mod(obj.brick.GyroAngle(obj.GYRO_SENSOR_PORT),360);
            target_angle = current_angle+angle;
            original_angle = current_angle;
            disp(current_angle + " " + target_angle);

            % Define the maximum motor speed for turning
            max_turn_speed = 50;
            while true
                % Calculate the error between the target angle and the current angle
                current_angle = mod(obj.brick.GyroAngle(obj.GYRO_SENSOR_PORT),360);
                error_turn = target_angle - current_angle;
                %if mod(current_angle, 2) == 0
                    %disp(current_angle);
                %end
                % Check if the turn is within the specified tolerance
                if abs(error_turn) < turn_tolerance
                    obj.brick.StopAllMotors(obj.MOTOR_B);
                    obj.brick.StopAllMotors(obj.MOTOR_C);
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
                obj.brick.MoveMotor(obj.MOTOR_C, -motor_speed_turn);

                % Update previous error for the next iteration
                previous_error_turn = error_turn;
                % Add a small delay to control the PID loop frequency
                pause(0.05);
            end
            change = current_angle-original_angle;
            disp(original_angle + " " +current_angle+" "+change);
            % Stop all motors after completing the turn
            obj.brick.StopAllMotors(obj.MOTOR_B);
            obj.brick.StopAllMotors(obj.MOTOR_C);
        end

        function PID_lanecenter(obj)
            mobility.forwards(obj);
            disp("Lane Centering.");
            % PID Controller Parameters for lane centering
            Kp_lane = 0.5;   % Proportional gain for lane centering
            Ki_lane = 0.05;  % Integral gain for lane centering
            Kd_lane = 0.1;   % Derivative gain for lane centering
        
            % Initialize PID variables for lane centering
            integral_lane = 0;
            previous_error_lane = 0;
        
            % Define the maximum motor speed for lane centering
            max_lane_speed = 50;
        
            while true
                % Calculate the error based on the gyro reading (keeping the car straight)
                current_angle = obj.brick.GyroAngle(obj.GYRO_SENSOR_PORT);
                error_lane = 0 - current_angle;  % Target angle is 0 for straight motion
        
                % Apply PID control to adjust the motor speeds for lane centering
                P_lane = Kp_lane * error_lane;
                integral_lane = integral_lane + error_lane;
                I_lane = Ki_lane * integral_lane;
                derivative_lane = error_lane - previous_error_lane;
                D_lane = Kd_lane * derivative_lane;
        
                % Calculate the motor speed adjustment for each motor
                motor_speed_left = max_lane_speed + P_lane + I_lane + D_lane;
                motor_speed_right = max_lane_speed - P_lane - I_lane - D_lane;
        
                % Limit the motor speeds to avoid excessive speed
                if motor_speed_left > max_lane_speed
                    motor_speed_left = max_lane_speed;
                elseif motor_speed_left < -max_lane_speed
                    motor_speed_left = -max_lane_speed;
                end
        
                if motor_speed_right > max_lane_speed
                    motor_speed_right = max_lane_speed;
                elseif motor_speed_right < -max_lane_speed
                    motor_speed_right = -max_lane_speed;
                end
        
                % Set the motor speeds for lane centering
                obj.brick.MoveMotor(obj.MOTOR_B, motor_speed_left);
                obj.brick.MoveMotor(obj.MOTOR_C, motor_speed_right);
        
                % Update previous error for the next iteration
                previous_error_lane = error_lane;
        
                % Add a small delay to control the PID loop frequency
                pause(0.01);
                
                % Distance Scan Hook
                distance = obj.brick.UltrasonicDist(obj.FORWARD_SENSOR_PORT);
                if distance < 30
                    mobility.scan(obj);
                end
                pause(0.01);
            end
        
            % Stop all motors after completing the lane centering
            obj.brick.StopAllMotors(obj.MOTOR_B);
            obj.brick.StopAllMotors(obj.MOTOR_C);
end

function turn(obj)
            disp("Trying Left");
            obj.brick.MoveMotor('B',50);
            obj.brick.MoveMotor('C',-50);
            pause(1);
            obj.brick.StopAllMotors();
            disp(obj.brick.UltrasonicDist(1));
            if obj.brick.UltrasonicDist(1) < 30
                disp("Trying Right");
                obj.brick.MoveMotor('B',-50);
                obj.brick.MoveMotor('C',50);
                pause(2.5);
                obj.brick.StopAllMotors();
                disp(obj.brick.UltrasonicDist(1));
                if obj.brick.UltrasonicDist(1) < 30
                disp("Trying Rear");
                obj.brick.MoveMotor('B',-50);
                obj.brick.MoveMotor('C',50);
                pause(1);
                obj.brick.StopAllMotors();
                disp(obj.brick.UltrasonicDist(1));
                if obj.brick.UltrasonicDist(1) < 30
                    turn(obj);
                else
                    mobility.forwards(obj);
                    return;
                end
                else
                    mobility.forwards(obj);
                    return;
                end
                else
                    mobility.forwards(obj);
                    return;
            end
            

        end
    end
end

