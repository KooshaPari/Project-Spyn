function ControlModule(obj)
global key;
InitKeyboard();

% Create a parallel pool with one worker
%    pool = parpool(1);

while 1
    pause(0.1);
     switch key 
        case 'leftarrow'
            mobility.turnLeft(obj);
        case 'uparrow' 
            mobility.forwards(obj);
        case 'downarrow'
            mobility.backwards(obj);
        case 'rightarrow'
            mobility.turnRight(obj);
        case 'a'
            mobility.turnLeft(obj);
        case 'w' 
            mobility.forwards(obj);
        case 's'
            mobility.backwards(obj);
        case 'd'
            mobility.turnRight(obj);
        case 'space'
            obj.brick.StopAllMotors('Coast');
        case '1'
            % Raise Forklift
            obj.brick.MoveMotor('D',10);
            pause(0.2);
            obj.brick.StopAllMotors('Coast');
        case '2'
            % Lower Forklift
            obj.brick.MoveMotor('D',-15);
            pause(0.2);
            obj.brick.StopAllMotors('Coast');
        case '3'
            disp(obj.brick.GyroAngle(2));
        case '4'
            disp(obj.brick.UltrasonicDist(1));
        case '5'
            mobility.PID_turn(obj,90);
        case '6'
            disp("Scanning...");
            mobility.scan(obj);
        case '7'
            disp("Lane Centering...");
            mobility.PID_lanecenter(obj);
        case '8'
                    robot.start();
                    disp('Robot started.');u/vv
        case 'c'
             robot = RobotController();
             obj = robot;
        case 'q'
            obj.brick.StopAllMotors('Coast');
                break;

    end
end
CloseKeyboard();
end
