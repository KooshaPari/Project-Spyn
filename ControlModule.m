global key;
InitKeyboard();
ended = false;
while 1
    pause(0.1);
     switch key 
        case 'uparrow' 
        brick.MoveMotor('B',50);
        brick.MoveMotor('C',50);
        case 'downarrow'
        brick.MoveMotor('B',-50);
        brick.MoveMotor('C',-50);
        case 'rightarrow'
        brick.StopMotor('B');
            brick.MoveMotor('C',50);
             brick.MoveMotor('B',-50);
     
         case 'a'
        brick.StopMotor('C');
        brick.MoveMotor('B',50);
        brick.MoveMotor('C',-50);
        case 'w' 
        brick.MoveMotor('B',50);
        brick.MoveMotor('C',50);
        case 's'
        brick.MoveMotor('B',-50);
        brick.MoveMotor('C',-50);
        case 'd'
        brick.StopMotor('B');
            brick.MoveMotor('C',50);
             brick.MoveMotor('B',-50);
     
        case 'leftarrow'
        brick.StopMotor('C');
        brick.MoveMotor('B',50);
        brick.MoveMotor('C',-50);
        case 'space'
            brick.StopAllMotors('Coast');
        case '1'
            %brick.MoveMotorAngleRel('D',5,25,'Coast');
            brick.MoveMotor('D',10);
            pause(0.2);
            brick.StopAllMotors('Coast');
        case '2'
            %brick.MoveMotorAngleRel('D',-5,25,'Coast');
            brick.MoveMotor('D',-15);
            pause(0.2);
            brick.StopAllMotors('Coast');
        case 'q'
            break;
            
            
    end
end
CloseKeyboard();

