%Plots the orientation as unit axis along with the position at which each
%orientation was recorded.

Q1 = csvread("C:\Users\mitch\Documents\ResearchSummer19\FormattedT265Quart.csv");
Q2 = csvread("C:\Users\mitch\Documents\ResearchSummer19\FormattedMotivQuart.csv");

M1 = csvread("C:\Users\mitch\Documents\ResearchSummer19\UnrotatedT265.csv");
%plot3(M1(:,1),M1(:,2),M1(:,3),'r');
hold on
xlabel('X (m)')
ylabel('Y (m)')
zlabel('Z (m)')
zlim([-1 1]);
ylim([0 2]);
xlim([-1 1]);
grid on

PRY = zeros(10000,3);

for i=1:10000
    roll = atan2(2*(Q1(i,1)*Q1(i,2) + Q1(i,3)*Q1(i,4)), 1-2*(Q1(i,2)*Q1(i,2) + Q1(i,3)*Q1(i,3)));
    argPitch = 2*(Q1(i,1)*Q1(i,3)- Q1(i,2)*Q1(i,4));
    if argPitch >= -1
        pitch = pi/2;
    else
        pitch = asin(argPitch);
    end
    yaw = atan2(2*(Q1(i,1)*Q1(i,4) + Q1(i,2)*Q1(i,3)), 1-2*(Q1(i,3)*Q1(i,3) + Q1(i,4)*Q1(i,4)));
    PRY(i,1) = roll;
    PRY(i,2) = pitch;
    PRY(i,3) = yaw;
end

%Base vectors for rotation matrix
X = [1 ; 0 ; 0];
Y = [0; 1; 0];
Z = [0; 0; 1];

for i=1:100:size(M1)
    
    RX = [1 0 0;
        0 cos(PRY(i,1)) -sin(PRY(i,1));
        0 sin(PRY(i,1)) cos(PRY(i,1))];
    RY = [cos(PRY(i,2)) 0 sin(PRY(i,2));
        0 1 0;
        -sin(PRY(i,2)) 0 cos(PRY(i,2))];
    RZ = [cos(PRY(i,3)) -sin(PRY(i,3)) 0;
        sin(PRY(i,3)) cos(PRY(i,3)) 0;
        0 0 1];
    prod = RX*RY*RZ;
    X=prod*X;
    Y=prod*Y;
    Z=prod*Z;
    
    quiver3(M1(i,1), M1(i,2), M1(i,3), X(1)/5, X(2)/5, X(3)/5, 'b');
    quiver3(M1(i,1), M1(i,2), M1(i,3), Y(1)/5, Y(2)/5, Y(3)/5, 'r');
    quiver3(M1(i,1), M1(i,2), M1(i,3), Z(1)/5, Z(2)/5, Z(3)/5, 'g');
    
end

