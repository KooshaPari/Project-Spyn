function ControlModule(obj)
global key;
InitKeyboard();
ended = false;

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
        case 'q'
            break;
    end
end
CloseKeyboard();
end
