function test(obj)
% Start moving forward to the center of the lane
mobility.forwards(obj);
pause(2);  % Move forward for 2 seconds

% Intentionally put it off-center by turning left
mobility.PID_turn(obj, 30);  % Turn left by 15 degrees
pause(1);  % Pause for 1 second

% Resume moving forward to test lane centering
mobility.forwards(obj);
pause(2);  % Move forward for 2 seconds

% Now, let the PID_lane_centering function take over to bring it back to center
mobility.PID_lanecenter(obj);
end