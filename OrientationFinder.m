%Used to find the coordinate axis with motiv
%Test first does rotation around X axis, then Z axis, then Y axis
%This corresponds to roll, then yaw, then pitch

file = csvread("C:\Users\mitch\Documents\ResearchSummer19\Rotations.csv");
headings = [file(:,3) file(:,4) file(:,5) file(:,6)];
x = file(:,3);
y = file(:,4);
z = file(:,5);
w = file(:,6);
RPY = zeros(10000, 3)

for i=1:size(file)
    roll  = atan2(2*y(i)*w(i) + 2*x(i)*z(i), 1 - 2*y(i)*y(i) - 2*z(i)*z(i));
    pitch = atan2(2*x(i)*w(i) + 2*y(i)*z(i), 1 - 2*x(i)*x(i) - 2*z(i)*z(i));
    yaw   = asin(2*x(i)*y(i) + 2*z(i)*w(i));
    
    RPY(i,1) = roll*180/pi;
    RPY(i,2) = pitch*180/pi;
    RPY(i,3) = yaw*180/pi;
end