%M1 = csvread("C:\Users\mitch\Documents\ResearchSummer19\ZAxisNvidiaV2.csv");
%M2 = csvread("C:\Users\mitch\Documents\ResearchSummer19\ZAisMotivV2Formatted.csv");
%M1 = csvread("C:\Users\mitch\Documents\ResearchSummer19\ZAxisSquareNvidia.csv");
%M2 = csvread("C:\Users\mitch\Documents\ResearchSummer19\ZAxisSquareMotivFormatted.csv");
%M1 = csvread("C:\Users\mitch\Documents\ResearchSummer19\Test4T265.csv");
%M2 = csvread("C:\Users\mitch\Documents\ResearchSummer19\Test4MotivFormatted.csv");
%M1 = csvread("C:\Users\mitch\Documents\ResearchSummer19\ZAxisSquareMultipleNvidia.csv");
%M2 = csvread("C:\Users\mitch\Documents\ResearchSummer19\ZAxisSquareMultipleMotivFormatted.csv");

%IMPORTANT NOTE
%In the FacingSideways folder, the device is oriented to have the device
%axis oriented with the Motiv axis with the X and Z axis being in the
%negative direction
%M1 = csvread("C:\Users\mitch\Documents\ResearchSummer19\FacingSideways\XAxisNvidia3.csv");
%M2 = csvread("C:\Users\mitch\Documents\ResearchSummer19\FacingSideways\XAxisMotiv3Formatted.csv");
%M1 = csvread("C:\Users\mitch\Documents\ResearchSummer19\FacingSideways\XAxisNvidia4.csv");
%M2 = csvread("C:\Users\mitch\Documents\ResearchSummer19\FacingSideways\XAxisMotiv4Formatted.csv");

M1 = csvread("C:\Users\mitch\Documents\ResearchSummer19\DroneData\coordinateData.csv");
M2 = csvread("C:\Users\mitch\Documents\ResearchSummer19\DroneData\RealSenseFlightFormatted.csv");
xT = M1(:,7);
yT = M1(:,8);
zT = M1(:,9);
xM = M2(:,1);
yM = M2(:,2);
zM = M2(:,3);

%For X Axis path
%{
xT2 = -zT;
yT2 = yT;
zT2 = xT;
%}

%For Z Axis path

xT2 = xT;
yT2 = yT;
zT2 = zT;


%For Y Axis path
%{
xT2 = -xT;
yT2 = yT;
zT2 = -zT;
%}

%xT2 = -xT;
%yT2 = yT;
%zT2 = -zT;

%Following variable is for using the plotting tab in Matlab IDE to help visualize
PlotNvidia = [xT2 yT2 zT2];
PlotMotiv = [xM yM zM];

plot3(xT2,zT2,yT2,'r');
hold on
plot3(xM,zM,yM,'b');
zlim([0 1]);
ylim([-3 3]);
xlim([-3 3]);
%xlabel('X (m)')
%ylabel('Y (m)')
%zlabel('Z (m)')
grid on
legend('T265', 'Motiv Tracker');
