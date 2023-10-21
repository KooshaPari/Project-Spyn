global key;
InitKeyboard();
ended = false;
while 1
    pause(0.1);
     switch key 
         case 'leftarrow'
            mobility.turnLeft();
        case 'uparrow' 
            mobility.forwards();
        case 'downarrow'
            backwards();
        case 'rightarrow'
            mobility.turnRight();
        case 'a'
            mobility.turnLeft();
        case 'w' 
            mobility.forwards();
        case 's'
            backwards();
        case 'd'
            mobility.turnRight();
        case 'space'
            brick.StopAllMotors('Coast');
        case '1'
            brick.MoveMotor('D',10);
            pause(0.2);
            brick.StopAllMotors('Coast');
        case '2'
            brick.MoveMotor('D',-15);
            pause(0.2);
            brick.StopAllMotors('Coast');
        case 'q'
            break;
            
            
    end
end
CloseKeyboard();

