%Plots trajectories from flight controlled by the T265 with motiv recroding
%for reference

M1 = csvread("C:\Users\mitch\Documents\ResearchSummer19\TrueFlightData\Flight1.csv");

xM = M1(:,7);
yM = M1(:,8);
zM = M1(:,9);

initialX = xM(1,1);
initialY = yM(1,1);
initialZ = zM(1,1);
for i=1:length(xM)
    xM(i,1) = xM(i,1)-initialX;
end
for i=1:length(yM)
    yM(i,1) = yM(i,1)-initialY;
end
for i=1:length(zM)
    zM(i,1) = zM(i,1)-initialZ;
end

xM=-xM;


M2 = csvread("C:\Users\mitch\Documents\ResearchSummer19\TrueFlightData\Flight2.csv");

xM2 = M2(:,7);
yM2 = M2(:,8);
zM2 = M2(:,9);

xM2=-xM2;

initialX = xM2(1,1);
initialY = yM2(1,1);
initialZ = zM2(1,1);
for i=1:length(xM2)
    xM2(i,1) = xM2(i,1)-initialX;
end
for i=1:length(yM2)
    yM2(i,1) = yM2(i,1)-initialY;
end
for i=1:length(zM2)
    zM2(i,1) = zM2(i,1)-initialZ;
end
M3 = csvread("C:\Users\mitch\Documents\ResearchSummer19\TrueFlightData\Flight3.csv");

xM3 = M3(:,7);
yM3 = M3(:,8);
zM3 = M3(:,9);

xM3 = -xM3;

initialX = xM3(1,1);
initialY = yM3(1,1);
initialZ = zM3(1,1);
for i=1:length(xM3)
    xM3(i,1) = xM3(i,1)-initialX;
end
for i=1:length(yM3)
    yM3(i,1) = yM3(i,1)-initialY;
end
for i=1:length(zM3)
    zM3(i,1) = zM3(i,1)-initialZ;
end

M4 = csvread("C:\Users\mitch\Documents\ResearchSummer19\TrueFlightData\Flight4.csv");

xM4 = M4(:,7);
yM4 = M4(:,8);
zM4 = M4(:,9);

%This data we do not have for the T265 since the PI shut off when it fell
%{
plot3(xM4,zM4,yM4,'k');
zlim([0 2]);
ylim([-3 3]);
xlim([-3 3]);
grid on
%}

%Opening T265 data from HTML files
fileText = fileread('C:\Users\mitch\Documents\ResearchSummer19\TrueFlightData\Flight1RawT265Data.txt');
xyzSeparated = strsplit(fileText, '[')
%Indices 3, 5, and 7 are the X, Y, and Z data respectively
xDataUntrimmed = transpose(strsplit(string(xyzSeparated(3)), ","));
yDataUntrimmed = transpose(strsplit(string(xyzSeparated(5)), ","));
zDataUntrimmed = transpose(strsplit(string(xyzSeparated(7)), ","));
xDataUntrimmed = xDataUntrimmed(1:length(xDataUntrimmed)-2,1);
yDataUntrimmed = yDataUntrimmed(1:length(yDataUntrimmed)-2,1);
zDataUntrimmed = zDataUntrimmed(1:length(zDataUntrimmed)-2,1);

figure

xDataNum = zeros(length(xDataUntrimmed),1);
yDataNum = zeros(length(yDataUntrimmed),1);
zDataNum = zeros(length(zDataUntrimmed),1);


for i=1:length(xDataUntrimmed)
    xDataNum(i,1) = double(xDataUntrimmed(i,1));
end
for i=1:length(yDataUntrimmed)
    yDataNum(i,1) = double(yDataUntrimmed(i,1));
end
for i=1:length(zDataUntrimmed)
    zDataNum(i,1) = double(zDataUntrimmed(i,1));
end

fullT265PosList = [xDataNum yDataNum zDataNum];

plot3(xDataNum,yDataNum,zDataNum,'m');
hold on
plot3(xM,zM,yM,'b');
zlim([0 1]);
ylim([-1 1]);
xlim([-1 1]);
xlabel("x")
ylabel("y")
xlabel("z")
grid on

%Opening T265 data from HTML files
fileText = fileread('C:\Users\mitch\Documents\ResearchSummer19\TrueFlightData\Flight2RawT265Data.txt');
xyzSeparated2 = strsplit(fileText, '[');
xDataUntrimmed2 = transpose(strsplit(string(xyzSeparated2(3)), ","));
yDataUntrimmed2 = transpose(strsplit(string(xyzSeparated2(5)), ","));
zDataUntrimmed2 = transpose(strsplit(string(xyzSeparated2(7)), ","));
xDataUntrimmed2 = xDataUntrimmed2(1:length(xDataUntrimmed2)-1,1);
yDataUntrimmed2 = yDataUntrimmed2(1:length(yDataUntrimmed2)-6,1);
zDataUntrimmed2 = zDataUntrimmed2(1:length(zDataUntrimmed2)-6,1);

figure

xDataNum2 = zeros(length(xDataUntrimmed2),1);
yDataNum2 = zeros(length(yDataUntrimmed2),1);
zDataNum2 = zeros(length(zDataUntrimmed2),1);

for i=1:length(xDataUntrimmed2)
    xDataNum2(i,1) = double(xDataUntrimmed2(i,1));
end
for i=1:length(yDataUntrimmed2)
    yDataNum2(i,1) = double(yDataUntrimmed2(i,1));
end
for i=1:length(zDataUntrimmed2)
    zDataNum2(i,1) = double(zDataUntrimmed2(i,1));
end

fullT265PosList2 = [xDataNum2(1:2086,1) yDataNum2(1:2086,1) zDataNum2];

plot3(xDataNum2(1:2086,1),yDataNum2(1:2086,1),zDataNum2,'m');
hold on
plot3(xM2,zM2,yM2,'b');
zlim([0 0.7]);
ylim([-0.5 0.5]);
xlim([-0.5 0.5]);
xlabel("x")
ylabel("y")
xlabel("z")
grid on

%Opening T265 data from HTML files
fileText = fileread('C:\Users\mitch\Documents\ResearchSummer19\TrueFlightData\Flight3RawT265Data.txt');
xyzSeparated3 = strsplit(fileText, '[');
xDataUntrimmed3 = transpose(strsplit(string(xyzSeparated3(3)), ","));
yDataUntrimmed3 = transpose(strsplit(string(xyzSeparated3(5)), ","));
zDataUntrimmed3 = transpose(strsplit(string(xyzSeparated3(7)), ","));
xDataUntrimmed3 = xDataUntrimmed3(1:length(xDataUntrimmed3)-1,1);
yDataUntrimmed3 = yDataUntrimmed3(1:length(yDataUntrimmed3)-6,1);
zDataUntrimmed3 = zDataUntrimmed3(1:length(zDataUntrimmed3)-6,1);

figure

xDataNum3 = zeros(length(xDataUntrimmed3),1);
yDataNum3 = zeros(length(yDataUntrimmed3),1);
zDataNum3 = zeros(length(zDataUntrimmed3),1);

for i=1:length(xDataUntrimmed3)
    xDataNum3(i,1) = double(xDataUntrimmed3(i,1));
end
for i=1:length(yDataUntrimmed3)
    yDataNum3(i,1) = double(yDataUntrimmed3(i,1));
end
for i=1:length(zDataUntrimmed3)
    zDataNum3(i,1) = double(zDataUntrimmed3(i,1));
end

fullT265PosList3 = [xDataNum3(1:2721,1) yDataNum3(1:2721,1) zDataNum3];


plot3(xDataNum3(1:2721,1),yDataNum3(1:2721,1),zDataNum3,'m');
hold on
plot3(xM3,zM3,yM3,'b');
zlim([0 0.7]);
ylim([-0.3 0.3]);
xlim([-0.3 0.3]);
xlabel("x")
ylabel("y")
xlabel("z")
grid on