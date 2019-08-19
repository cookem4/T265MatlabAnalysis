%Plots quaternion as unit axis in time to see how the T265 device is
%rotated troughout a trajectory

%Q1 = csvread("C:\Users\mitch\Documents\ResearchSummer19\FormattedT265Quart.csv");
%Q2 = csvread("C:\Users\mitch\Documents\ResearchSummer19\FormattedMotivQuart.csv");
%Q1 = csvread("C:\Users\mitch\Documents\ResearchSummer19\XAxisSquareNvidia.csv");
%Q2 = csvread("C:\Users\mitch\Documents\ResearchSummer19\XAxisSquareMotiv.csv");
%Q1 = csvread("C:\Users\mitch\Documents\ResearchSummer19\ZRotTest3.csv");
%Q2 = csvread("C:\Users\mitch\Documents\ResearchSummer19\ZRotTest3.csv");

Q1 = csvread("C:\Users\mitch\Documents\ResearchSummer19\DroneData\coordinateData.csv");
Q2 = csvread("C:\Users\mitch\Documents\ResearchSummer19\DroneData\RealSenseFlight.csv");

PRY = zeros(20000,3);
PRY2 = zeros(20000,3);
x = Q1(:,3);
y = Q1(:,4);
z = Q1(:,5);
w = Q1(:,6);

x2 = Q2(:,11);
y2 = Q2(:,12);
z2 = Q2(:,13);
w2 = Q2(:,14);

q1 = [x y z w];
q2 = [x2 y2 z2 w2];

%{
%Attempting to use quatrotate, will need aerospace package for Matlab
for i=1:size(Q1)
    xF = quatrotate(q1(i),X);
    yF = quatrotate(q1(i), Y);
    zF = quatrotate(q1(i), Z);
    
    plot3([0;xF(1)], [0;xF(2)], [0;xF(3)], 'b');
    hold on
    plot3([0;yF(1)], [0;yF(2)], [0;yF(3)], 'r');
    plot3([0;zF(1)], [0;zF(2)], [0;zF(3)], 'g');
    hold off;
    
    title("T265 Frame: " + (i));
    zlim([-1 1]);
    ylim([-1 1]);
    xlim([-1 1]);
    grid on
    pause(0.0001);
    
end
%}

%Below is the method of plotting by changing the quarternion to pitch,
%roll, and yaw, forming rotation matrices, then transforming the standard
%axis by those rotation matrices


for i=1:size(Q1)
    roll  = atan2(2*y(i)*w(i) + 2*x(i)*z(i), 1 - 2*y(i)*y(i) - 2*z(i)*z(i));
    pitch = atan2(2*x(i)*w(i) + 2*y(i)*z(i), 1 - 2*x(i)*x(i) - 2*z(i)*z(i));
    yaw   = asin(2*x(i)*y(i) + 2*z(i)*w(i));
 
    %roll = atan2(2*(Q1(i,3)*Q1(i,4) + Q1(i,5)*Q1(i,6)), 1-2*(Q1(i,4)*Q1(i,4) + Q1(i,5)*Q1(i,5)));
    %argPitch = 2*(Q1(i,3)*Q1(i,5)- Q1(i,4)*Q1(i,6));
    %if argPitch >= -1
    %    pitch = pi/2;
    %else
    %    pitch = asin(argPitch);
    %end
    %yaw = atan2(2*(Q1(i,3)*Q1(i,6) + Q1(i,4)*Q1(i,5)), 1-2*(Q1(i,5)*Q1(i,5) + Q1(i,6)*Q1(i,6)));
    PRY(i,1) = roll;
    PRY(i,2) = pitch;
    PRY(i,3) = yaw;
end
for i=1:size(Q2)
    
    roll  = atan2(2*y2(i)*w2(i) + 2*x2(i)*z2(i), 1 - 2*y2(i)*y2(i) - 2*z2(i)*z2(i));
    pitch = atan2(2*x2(i)*w2(i) + 2*y2(i)*z2(i), 1 - 2*x2(i)*x2(i) - 2*z2(i)*z2(i));
    yaw   = asin(2*x2(i)*y2(i) + 2*z2(i)*w2(i));
    
    %roll = atan2(2*(Q2(i,3)*Q2(i,4) + Q2(i,5)*Q2(i,6)), 1-2*(Q2(i,4)*Q2(i,4) + Q2(i,5)*Q2(i,5)));
    %argPitch = 2*(Q2(i,3)*Q2(i,5)- Q2(i,4)*Q2(i,6));
    %if argPitch >= -1
    %    pitch = pi/2;
    %else
    %    pitch = asin(argPitch);
    %end
    %yaw = atan2(2*(Q2(i,3)*Q2(i,6) + Q2(i,4)*Q2(i,5)), 1-2*(Q2(i,5)*Q2(i,5) + Q2(i,6)*Q2(i,6)));
    PRY2(i,1) = roll;
    PRY2(i,2) = pitch;
    PRY2(i,3) = yaw;
end
%Base vectors for rotation matrix
X = [1 ; 0 ; 0];
Y = [0; 1; 0];
Z = [0; 0; 1];

%Q1 is 200FPS
%Q2 is 120FPS
%Can run at 10FPS by taking every 20th frame of Q1 and every 12th frame of
%Q2

showInitialHeading(PRY, PRY2)


function noRet = showInitialHeading(PRY, PRY2)

    i=1;

    RX = [1 0 0;
        0 cos(PRY(4*i,1)) -sin(PRY(4*i,1));
        0 sin(PRY(4*i,1)) cos(PRY(4*i,1))];
    RY = [cos(PRY(4*i,2)) 0 sin(PRY(4*i,2));
        0 1 0;
        -sin(PRY(4*i,2)) 0 cos(PRY(4*i,2))];
    RZ = [cos(PRY(4*i,3)) -sin(PRY(4*i,3)) 0;
        sin(PRY(4*i,3)) cos(PRY(4*i,3)) 0;
        0 0 1];
    prod = RX*RY*RZ;
    X = [1 ; 0 ; 0];
    Y = [0; 1; 0];
    Z = [0; 0; 1];
    X=prod*X;
    Y=prod*Y;
    Z=prod*Z;


    plot3([0;X(1)], [0;X(2)], [0;X(3)], 'b');
    hold on
    plot3([0;Y(1)], [0;Y(2)], [0;Y(3)], 'r');
    plot3([0;Z(1)], [0;Z(2)], [0;Z(3)], 'g');

    zlim([-1 1]);
    ylim([-1 1]);
    xlim([-1 1]);
    grid on
    
    
    RX = [1 0 0;
        0 cos(PRY2(4*i,1)) -sin(PRY2(4*i,1));
        0 sin(PRY2(4*i,1)) cos(PRY2(4*i,1))];
    RY = [cos(PRY2(4*i,2)) 0 sin(PRY2(4*i,2));
        0 1 0;
        -sin(PRY2(4*i,2)) 0 cos(PRY2(4*i,2))];
    RZ = [cos(PRY2(4*i,3)) -sin(PRY2(4*i,3)) 0;
        sin(PRY2(4*i,3)) cos(PRY2(4*i,3)) 0;
        0 0 1];
    prod = RX*RY*RZ;
    X2 = [1 ; 0 ; 0];
    Y2 = [0; 1; 0];
    Z2 = [0; 0; 1];
    X2=prod*X2;
    Y2=prod*Y2;
    Z2=prod*Z2;

    plot3([0;X2(1)], [0;X2(2)], [0;X2(3)], 'c');
    hold on
    plot3([0;Y2(1)], [0;Y2(2)], [0;Y2(3)], 'm');
    plot3([0;Z2(1)], [0;Z2(2)], [0;Z2(3)], 'k');
    zlim([-1 1]);
    ylim([-1 1]);
    xlim([-1 1]);
    grid on

end

function noRet = animate()
    for i=1:size(Q1)/4
        %PRY(i,1) + "," + PRY(i,2) + "," + PRY(i,3)
        RX = [1 0 0;
            0 cos(PRY(4*i,1)) -sin(PRY(4*i,1));
            0 sin(PRY(4*i,1)) cos(PRY(4*i,1))];
        RY = [cos(PRY(4*i,2)) 0 sin(PRY(4*i,2));
            0 1 0;
            -sin(PRY(4*i,2)) 0 cos(PRY(4*i,2))];
        RZ = [cos(PRY(4*i,3)) -sin(PRY(4*i,3)) 0;
            sin(PRY(4*i,3)) cos(PRY(4*i,3)) 0;
            0 0 1];
        prod = RX*RY*RZ;
        X = [1 ; 0 ; 0];
        Y = [0; 1; 0];
        Z = [0; 0; 1];
        X=prod*X;
        Y=prod*Y;
        Z=prod*Z;


        plot3([0;X(1)], [0;X(2)], [0;X(3)], 'b');
        hold on
        plot3([0;Y(1)], [0;Y(2)], [0;Y(3)], 'r');
        plot3([0;Z(1)], [0;Z(2)], [0;Z(3)], 'g');
        hold off;

        title("T265 Frame: " + (4*i));
        zlim([-1 1]);
        ylim([-1 1]);
        xlim([-1 1]);
        grid on
        pause(0.0001);

    end

    for i=1:size(Q2)/4

        RX = [1 0 0;
            0 cos(PRY2(4*i,1)) -sin(PRY2(4*i,1));
            0 sin(PRY2(4*i,1)) cos(PRY2(4*i,1))];
        RY = [cos(PRY2(4*i,2)) 0 sin(PRY2(4*i,2));
            0 1 0;
            -sin(PRY2(4*i,2)) 0 cos(PRY2(4*i,2))];
        RZ = [cos(PRY2(4*i,3)) -sin(PRY2(4*i,3)) 0;
            sin(PRY2(4*i,3)) cos(PRY2(4*i,3)) 0;
            0 0 1];
        prod = RX*RY*RZ;
        X2 = [1 ; 0 ; 0];
        Y2 = [0; 1; 0];
        Z2 = [0; 0; 1];
        X2=prod*X2;
        Y2=prod*Y2;
        Z2=prod*Z2;

        plot3([0;X2(1)], [0;X2(2)], [0;X2(3)], 'b');
        hold on
        plot3([0;Y2(1)], [0;Y2(2)], [0;Y2(3)], 'r');
        plot3([0;Z2(1)], [0;Z2(2)], [0;Z2(3)], 'g');
        hold off;
        title("Ground Truth Frame: " + (4*i));
        zlim([-1 1]);
        ylim([-1 1]);
        xlim([-1 1]);
        grid on
        pause(0.001);

    end
end
