%Plots the quaternions as unit axis to help with understanding how the T265
%camera reports its quaternion. The T265 documentation on T265
%documentation explains this.


Q1 = csvread("C:\Users\mitch\Documents\ResearchSummer19\DroneData\coordinateData.csv");
Q2 = csvread("C:\Users\mitch\Documents\ResearchSummer19\DroneData\RealSenseFlight.csv");
Q3 = csvread("C:\Users\mitch\Documents\ResearchSummer19\DroneData\heading.csv");
Q4 = csvread("C:\Users\mitch\Documents\ResearchSummer19\DroneData\heading2.csv");
Q5 = csvread("C:\Users\mitch\Documents\ResearchSummer19\DroneData\heading3.csv");
Q6 = csvread("C:\Users\mitch\Documents\ResearchSummer19\DroneData\heading4.csv");

PRY = zeros(20000,3);
PRY2 = zeros(20000,3);
PRY3 = zeros(20000,3);
PRY4 = zeros(20000,3);
PRY5 = zeros(20000,3);
PRY6 = zeros(20000,3);


x = Q1(:,3);
y = Q1(:,4);
z = Q1(:,5);
w = Q1(:,6);

x2 = Q2(:,11);
y2 = Q2(:,12);
z2 = Q2(:,13);
w2 = Q2(:,14);

x3 = Q3(:,3);
y3 = Q3(:,4);
z3 = Q3(:,5);
w3 = Q3(:,6);

x4 = Q4(:,3);
y4 = Q4(:,4);
z4 = Q4(:,5);
w4 = Q4(:,6);

x5 = Q5(:,3);
y5 = Q5(:,4);
z5 = Q5(:,5);
w5 = Q5(:,6);

x6 = Q6(:,3);
y6 = Q6(:,4);
z6 = Q6(:,5);
w6 = Q6(:,6);

q1 = [x y z w];
q2 = [x2 y2 z2 w2];
q3 = [x3 y3 z3 w3];
q4 = [x4 y4 z4 w4];
q5 = [x5 y5 z5 w5];
q6 = [x6 y6 z6 w6];



for i=1:size(Q1)
    roll  = atan2(2*y(i)*w(i) + 2*x(i)*z(i), 1 - 2*y(i)*y(i) - 2*z(i)*z(i));
    pitch = atan2(2*x(i)*w(i) + 2*y(i)*z(i), 1 - 2*x(i)*x(i) - 2*z(i)*z(i));
    yaw   = asin(2*x(i)*y(i) + 2*z(i)*w(i));
    PRY(i,1) = roll;
    PRY(i,2) = pitch;
    PRY(i,3) = yaw;
end
for i=1:size(Q2)
    
    roll  = atan2(2*y2(i)*w2(i) + 2*x2(i)*z2(i), 1 - 2*y2(i)*y2(i) - 2*z2(i)*z2(i));
    pitch = atan2(2*x2(i)*w2(i) + 2*y2(i)*z2(i), 1 - 2*x2(i)*x2(i) - 2*z2(i)*z2(i));
    yaw   = asin(2*x2(i)*y2(i) + 2*z2(i)*w2(i));
    PRY2(i,1) = roll;
    PRY2(i,2) = pitch;
    PRY2(i,3) = yaw;
end
for i=1:size(Q3)
    
    roll  = atan2(2*y3(i)*w3(i) + 2*x3(i)*z3(i), 1 - 2*y3(i)*y3(i) - 2*z3(i)*z3(i));
    pitch = atan2(2*x3(i)*w3(i) + 2*y3(i)*z3(i), 1 - 2*x3(i)*x3(i) - 2*z3(i)*z3(i));
    yaw   = asin(2*x3(i)*y3(i) + 2*z3(i)*w3(i));
    PRY3(i,1) = roll;
    PRY3(i,2) = pitch;
    PRY3(i,3) = yaw;
end
for i=1:size(Q4)
    
    roll  = atan2(2*y4(i)*w4(i) + 2*x4(i)*z4(i), 1 - 2*y4(i)*y4(i) - 2*z4(i)*z4(i));
    pitch = atan2(2*x4(i)*w4(i) + 2*y4(i)*z4(i), 1 - 2*x4(i)*x4(i) - 2*z4(i)*z4(i));
    yaw   = asin(2*x4(i)*y4(i) + 2*z4(i)*w4(i));
    PRY4(i,1) = roll;
    PRY4(i,2) = pitch;
    PRY4(i,3) = yaw;
end
for i=1:size(Q5)
    
    roll  = atan2(2*y5(i)*w5(i) + 2*x5(i)*z5(i), 1 - 2*y5(i)*y5(i) - 2*z5(i)*z5(i));
    pitch = atan2(2*x5(i)*w5(i) + 2*y5(i)*z5(i), 1 - 2*x5(i)*x5(i) - 2*z5(i)*z5(i));
    yaw   = asin(2*x5(i)*y5(i) + 2*z5(i)*w5(i));
    PRY5(i,1) = roll;
    PRY5(i,2) = pitch;
    PRY5(i,3) = yaw;
end
for i=1:size(Q6)
    
    roll  = atan2(2*y6(i)*w6(i) + 2*x6(i)*z6(i), 1 - 2*y6(i)*y6(i) - 2*z6(i)*z6(i));
    pitch = atan2(2*x6(i)*w6(i) + 2*y6(i)*z6(i), 1 - 2*x6(i)*x6(i) - 2*z6(i)*z6(i));
    yaw   = asin(2*x6(i)*y6(i) + 2*z6(i)*w6(i));
    PRY6(i,1) = roll;
    PRY6(i,2) = pitch;
    PRY6(i,3) = yaw;
end
%Base vectors for rotation matrix
X = [1 ; 0 ; 0];
Y = [0; 1; 0];
Z = [0; 0; 1];


showInitialHeading(PRY, PRY2, PRY3, PRY4, PRY5, PRY6)


function noRet = showInitialHeading(PRY, PRY2, PRY3, PRY4, PRY5, PRY6)
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
    plot3([0;Y(1)], [0;Y(2)], [0;Y(3)], 'b');
    plot3([0;Z(1)], [0;Z(2)], [0;Z(3)], 'b');

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

    plot3([0;X2(1)], [0;X2(2)], [0;X2(3)], 'g');
    hold on
    plot3([0;Y2(1)], [0;Y2(2)], [0;Y2(3)], 'g');
    plot3([0;Z2(1)], [0;Z2(2)], [0;Z2(3)], 'g');
    zlim([-1 1]);
    ylim([-1 1]);
    xlim([-1 1]);
    grid on
    
    
    RX = [1 0 0;
        0 cos(PRY3(4*i,1)) -sin(PRY3(4*i,1));
        0 sin(PRY3(4*i,1)) cos(PRY3(4*i,1))];
    RY = [cos(PRY3(4*i,2)) 0 sin(PRY3(4*i,2));
        0 1 0;
        -sin(PRY3(4*i,2)) 0 cos(PRY3(4*i,2))];
    RZ = [cos(PRY3(4*i,3)) -sin(PRY3(4*i,3)) 0;
        sin(PRY3(4*i,3)) cos(PRY3(4*i,3)) 0;
        0 0 1];
    prod = RX*RY*RZ;
    X3 = [1 ; 0 ; 0];
    Y3 = [0; 1; 0];
    Z3 = [0; 0; 1];
    X3=prod*X3;
    Y3=prod*Y3;
    Z3=prod*Z3;

    plot3([0;X3(1)], [0;X3(2)], [0;X3(3)], 'r');
    plot3([0;Y3(1)], [0;Y3(2)], [0;Y3(3)], 'r');
    plot3([0;Z3(1)], [0;Z3(2)], [0;Z3(3)], 'r');
    zlim([-1 1]);
    ylim([-1 1]);
    xlim([-1 1]);
    grid on
 
   
    
    RX = [1 0 0;
        0 cos(PRY4(4*i,1)) -sin(PRY4(4*i,1));
        0 sin(PRY4(4*i,1)) cos(PRY4(4*i,1))];
    RY = [cos(PRY4(4*i,2)) 0 sin(PRY4(4*i,2));
        0 1 0;
        -sin(PRY4(4*i,2)) 0 cos(PRY4(4*i,2))];
    RZ = [cos(PRY4(4*i,3)) -sin(PRY4(4*i,3)) 0;
        sin(PRY4(4*i,3)) cos(PRY4(4*i,3)) 0;
        0 0 1];
    prod = RX*RY*RZ;
    X4 = [1 ; 0 ; 0];
    Y4 = [0; 1; 0];
    Z4 = [0; 0; 1];
    X4=prod*X4;
    Y4=prod*Y4;
    Z4=prod*Z4;

    plot3([0;X4(1)], [0;X4(2)], [0;X4(3)], 'c');
    plot3([0;Y4(1)], [0;Y4(2)], [0;Y4(3)], 'c');
    plot3([0;Z4(1)], [0;Z4(2)], [0;Z4(3)], 'c');
    zlim([-1 1]);
    ylim([-1 1]);
    xlim([-1 1]);
    grid on
    
    RX = [1 0 0;
        0 cos(PRY5(4*i,1)) -sin(PRY5(4*i,1));
        0 sin(PRY5(4*i,1)) cos(PRY5(4*i,1))];
    RY = [cos(PRY5(4*i,2)) 0 sin(PRY5(4*i,2));
        0 1 0;
        -sin(PRY5(4*i,2)) 0 cos(PRY5(4*i,2))];
    RZ = [cos(PRY5(4*i,3)) -sin(PRY5(4*i,3)) 0;
        sin(PRY5(4*i,3)) cos(PRY5(4*i,3)) 0;
        0 0 1];
    prod = RX*RY*RZ;
    X5 = [1 ; 0 ; 0];
    Y5 = [0; 1; 0];
    Z5 = [0; 0; 1];
    X5=prod*X5;
    Y5=prod*Y5;
    Z5=prod*Z5;

    plot3([0;X5(1)], [0;X5(2)], [0;X5(3)], 'k');
    hold on
    plot3([0;Y5(1)], [0;Y5(2)], [0;Y5(3)], 'k');
    plot3([0;Z5(1)], [0;Z5(2)], [0;Z5(3)], 'k');
    zlim([-1 1]);
    ylim([-1 1]);
    xlim([-1 1]);
    grid on
    
    RX = [1 0 0;
        0 cos(PRY6(4*i,1)) -sin(PRY6(4*i,1));
        0 sin(PRY6(4*i,1)) cos(PRY6(4*i,1))];
    RY = [cos(PRY6(4*i,2)) 0 sin(PRY6(4*i,2));
        0 1 0;
        -sin(PRY6(4*i,2)) 0 cos(PRY6(4*i,2))];
    RZ = [cos(PRY6(4*i,3)) -sin(PRY6(4*i,3)) 0;
        sin(PRY6(4*i,3)) cos(PRY6(4*i,3)) 0;
        0 0 1];
    prod = RX*RY*RZ;
    X6 = [1 ; 0 ; 0];
    Y6 = [0; 1; 0];
    Z6 = [0; 0; 1];
    X6=prod*X6;
    Y6=prod*Y6;
    Z6=prod*Z6;

    plot3([0;X6(1)], [0;X6(2)], [0;X6(3)], 'y');
    plot3([0;Y6(1)], [0;Y6(2)], [0;Y6(3)], 'y');
    plot3([0;Z6(1)], [0;Z6(2)], [0;Z6(3)], 'y');
    zlim([-1 1]);
    ylim([-1 1]);
    xlim([-1 1]);
    grid on

end
