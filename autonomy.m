i =3;

brick.GyroCalibrate(2);
brick.SetColorMode(3, 1); 
while i==3
    pause(0.05);

    color = brick.ColorCode(3); 

    distance1 = brick.UltrasonicDist(1);
    disp(distance1);
    if (distance1 <3u0)
       angle = 0;
       cur = brick.GyroAngle(2);
       if(distance1<10)
           disp("Backing because distance less than 10");
           backwards();
           pause(0.5);
       end
       %z=-90-cur;
       %j=90+cur;
       %disp("turning left");
         %  disp("Pos Cur: " + j);
        %   disp("Neg Cur: " + z);
        %   disp("angle: "+angle);
       while angle <=80 && angle>=-80
        %  angle = brick.GyroAngle(2)-cur;
          % z=-90-cur;
        %   disp("turning left");
         %  disp("Pos Cur: " + 90+cur);
         %  disp("Neg Cur: " + z);
         %  disp("angle: "+angle);
         %  color =brick.ColorCode(3);
          % if(color==2)
           %    brick.StopAllMotors();
           %    break;
          % end
       turnLeft();
       angle = brick.GyroAngle(2)-cur;
       
       end


       brick.StopAllMotors();
        distance1 = brick.UltrasonicDist(1);
    end

    if color ==5
        brick.StopAllMotors();
        pause(5);
        forward();
        pause(1);
    elseif color == 2 || color == 4
        brick.StopAllMotors();
        break;
    ControlModule();
    end
    
    brick.MoveMotor('B',50);
    brick.MoveMotor('C',50);
    
end
% Keep Log of amount of angular left turns, skip 180deg then if all turns
% from 0 to 270 sans 180 are closed, turn back to 180deg and exit, making a
% right turn.