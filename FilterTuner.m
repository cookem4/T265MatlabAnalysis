
%Used to filter the flight path for tuning low pass filter parameters

M1 = csvread("C:\Users\mitch\Documents\ResearchSummer19\DroneData\coordinateData2.csv");
M2 = csvread("C:\Users\mitch\Documents\ResearchSummer19\DroneData\RealSenseFlight2Formatted.csv");
xT = M1(:,7);
yT = M1(:,8);
zT = M1(:,9);
xM = M2(:,1);
yM = M2(:,2);
zM = M2(:,3);

orderRS=10;
orderMotiv = 100;
decayFactor=0.05;
filteredPosRS = zeros(length(M1),3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Can implement with decaying or non decaying coefficients for the FIR %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%If coefficients decay as a power of two then the sum will be weighted to
%one as N of the FIR approaches infinity

for i =orderRS:length(M1)
    pSum = 0;
    for j = 0:orderRS-1
       %coeff = (decayFactor)/((1+decayFactor)^(j+1));
       coeff = 1/orderRS;
       pSum = pSum + coeff*[xT(i-j) yT(i-j) zT(i-j)];
    end
    filteredPosRS(i,1) = pSum(1);
    filteredPosRS(i,2) = pSum(2);
    filteredPosRS(i,3) = pSum(3);
end

filteredPosMotiv = zeros(length(M2),3);
for i =orderMotiv:length(M2)
    pSum = 0;
    for j = 0:orderMotiv-1
       %coeff = (decayFactor)/((1+decayFactor)^(j+1));
       coeff = 1/orderMotiv;
       pSum = pSum + coeff*[xM(i-j) yM(i-j) zM(i-j)];
    end
    filteredPosMotiv(i,1) = pSum(1);
    filteredPosMotiv(i,2) = pSum(2);
    filteredPosMotiv(i,3) = pSum(3);
end

%Plotting filtered position in 3D:
plot3(xM,zM,yM,'r');
hold on
plot3(filteredPosRS(:,1),filteredPosRS(:,3),filteredPosRS(:,2),'b');
plot3(xT,zT,yT,'c');
plot3(filteredPosMotiv(:,1),filteredPosMotiv(:,3),filteredPosMotiv(:,2),'g');
zlim([0 1]);
ylim([-3 3]);
xlim([-3 3]);
grid on
legend('Motiv', 'T265 Filtered', 'T65 Original', 'Motiv Filtered');

%{
The following code is used to plot the calculated speed of the drone with
each method from numerical derivation
%}


speedMotiv = zeros(length(M2)-1, 1);

for i = 2:length(xM)
    speedVal = sqrt((xM(i)-xM(i-1))^2 + (yM(i)-yM(i-1))^2 + (zM(i)-zM(i-1))^2)/0.008;
    if(speedVal > 10)
        speedVal = 0;
    end
    speedMotiv(i-1) = speedVal; 
end

speedFilteredMotiv = zeros(length(filteredPosMotiv)-1,1);
for i = 2:length(xM)
    speedVal = sqrt((filteredPosMotiv(i,1)-filteredPosMotiv(i-1,1))^2 + (filteredPosMotiv(i,2)-filteredPosMotiv(i-1,2))^2 + (filteredPosMotiv(i,3)-filteredPosMotiv(i-1,3))^2)/0.008;
    if(speedVal > 10)
        speedVal = 0;
    end
    speedFilteredMotiv(i-1) = speedVal; 
end

%%%%%NOTE%%%%%%%%%%%%%%%%
%Calculating frame rate from the time between each recording creates a LOT
%of noise in the velocity as the frame rate can vary to a large degree but
%the average frame rate is still 200FPS

speedIntel = zeros(length(xT)-1,1);
for i = 2:length(xT)
    %Poor method of calculating frame rate from the difference between each
    %frame measurement that creates a lot of noise is seen below:
    %speedIntel(i-1) = sqrt((xT(i)-xT(i-1))^2 + (yT(i)-yT(i-1))^2 + (zT(i)-zT(i-1))^2)/((M1(i,2)-M1(i-1,2))/1000000);
    speedIntel(i-1) = sqrt((xT(i)-xT(i-1))^2 + (yT(i)-yT(i-1))^2 + (zT(i)-zT(i-1))^2)/0.005;
end

speedFilteredRS = zeros(length(filteredPosRS)-1,1);
for i = 2:length(filteredPosRS)
    %Time recordings should be the same
    %speedFilteredRS(i-1) = sqrt((filteredPosRS(i,1)-filteredPosRS(i-1,1))^2 + (filteredPosRS(i,2)-filteredPosRS(i-1,2))^2 + (filteredPosRS(i,3)-filteredPosRS(i-1,3))^2)/((M1(i,2)-M1(i-1,2))/1000000);
    speedFilteredRS(i-1) = sqrt((filteredPosRS(i,1)-filteredPosRS(i-1,1))^2 + (filteredPosRS(i,2)-filteredPosRS(i-1,2))^2 + (filteredPosRS(i,3)-filteredPosRS(i-1,3))^2)/0.005;

end


%Speed plotting

figure
subplot(2,2,1);
plot(speedMotiv)
title("Motion Capture System")
ylabel("Speed (m/s)")
xlabel("Frame Number")
subplot(2,2,2);
plot(speedIntel)
title("Intel Camera")
ylabel("Speed (m/s)")
xlabel("Frame Number")
subplot(2,2,3)
plot(speedFilteredMotiv)
title("Position Filtered Motiv Data");
ylabel("Speed (m/s)")
xlabel("Frame Number")
subplot(2,2,4)
plot(speedFilteredRS)
title("Position Filtered Intel Cam");
ylabel("Speed (m/s)")
xlabel("Frame Number")


%Plotting velocities:
velMotiv  = zeros(length(M2)-1, 3);
for i = 2:length(xM)
    velX = (xM(i)-xM(i-1))/0.008;
    velY = (yM(i)-yM(i-1))/0.008;
    velZ = (zM(i)-zM(i-1))/0.008;
    if(sqrt(velX^2 + velY^2 + velZ^2) > 10)
        velX = 0;
        velY = 0;
        velZ = 0;
    end
    velMotiv(i-1,1) = velX;
    velMotiv(i-1,2) = velY; 
    velMotiv(i-1,3) = velZ; 
end

filteredVelMotiv = zeros(length(filteredPosMotiv)-1,3)
for i = 2:length(xM)
    velX = (filteredPosMotiv(i,1)-filteredPosMotiv(i-1,1))/0.008;
    velY = (filteredPosMotiv(i,2)-filteredPosMotiv(i-1,2))/0.008;
    velZ = (filteredPosMotiv(i,3)-filteredPosMotiv(i-1,3))/0.008;
    if(sqrt(velX^2 + velY^2 + velZ^2) > 10)
        velX = 0;
        velY = 0;
        velZ = 0;
    end
    filteredVelMotiv(i-1,1) = velX;
    filteredVelMotiv(i-1,2) = velY; 
    filteredVelMotiv(i-1,3) = velZ; 
end

velIntel = zeros(length(xT)-1,1);
for i = 2:length(xT)
    velX = (xT(i)-xT(i-1))/0.005;
    velY = (yT(i)-yT(i-1))/0.005;
    velZ = (zT(i)-zT(i-1))/0.005;
    velIntel(i-1,1) = velX;
    velIntel(i-1,2) = velY;
    velIntel(i-1,3) = velZ;
end

filteredVelIntel = zeros(length(filteredPosRS)-1,1);
for i = 2:length(xT)
    velX = (filteredPosRS(i,1)-filteredPosRS(i-1,1))/0.005;
    velY = (filteredPosRS(i,2)-filteredPosRS(i-1,2))/0.005;
    velZ = (filteredPosRS(i,3)-filteredPosRS(i-1,3))/0.005;
    filteredVelIntel(i-1,1) = velX;
    filteredVelIntel(i-1,2) = velY;
    filteredVelIntel(i-1,3) = velZ;
end

figure
subplot(2,2,1);
plot(velMotiv(:,1),'r')
title("Motion Capture System")
ylabel("Velocity X (m/s)")
xlabel("Frame Number")
subplot(2,2,2);
plot(velIntel(:,1),'r')
title("Intel Camera")
ylabel("Velocity X (m/s)")
xlabel("Frame Number")
subplot(2,2,3)
plot(filteredVelMotiv(:,1),'r')
title("Position Filtered Motiv Data");
ylabel("Velocity X (m/s)")
xlabel("Frame Number")
subplot(2,2,4)
plot(filteredVelIntel(:,1),'r')
title("Position Filtered Intel Cam");
ylabel("Velocity X (m/s)")
xlabel("Frame Number")

figure
subplot(2,2,1);
plot(velMotiv(:,2),'g')
title("Motion Capture System")
ylabel("Velocity Y (m/s)")
xlabel("Frame Number")
subplot(2,2,2);
plot(velIntel(:,2),'g')
title("Intel Camera")
ylabel("Velocity Y (m/s)")
xlabel("Frame Number")
subplot(2,2,3)
plot(filteredVelMotiv(:,2),'g')
title("Position Filtered Motiv Data");
ylabel("Velocity Y (m/s)")
xlabel("Frame Number")
subplot(2,2,4)
plot(filteredVelIntel(:,2),'g')
title("Position Filtered Intel Cam");
ylabel("Velocity Y (m/s)")
xlabel("Frame Number")

figure
subplot(2,2,1);
plot(velMotiv(:,3),'b')
title("Motion Capture System")
ylabel("Velocity Z (m/s)")
xlabel("Frame Number")
subplot(2,2,2);
plot(velIntel(:,3),'b')
title("Intel Camera")
ylabel("Velocity Z (m/s)")
xlabel("Frame Number")
subplot(2,2,3)
plot(filteredVelMotiv(:,3),'b')
title("Position Filtered Motiv Data");
ylabel("Velocity Z (m/s)")
xlabel("Frame Number")
subplot(2,2,4)
plot(filteredVelIntel(:,3),'b')
title("Position Filtered Intel Cam");
ylabel("Velocity Z (m/s)")
xlabel("Frame Number")


%Can now filter the velocity from the filtered position
orderRSVel = 3;
orderMotivVel = 10;
doubleFilteredVelIntel = zeros(length(filteredVelIntel), 3);
for i =orderRSVel:length(filteredVelIntel)
    pSum = 0;
    for j = 0:orderRSVel-1
       coeff = 1/orderRSVel;
       pSum = pSum + coeff*[filteredVelIntel(i-j,1) filteredVelIntel(i-j,2) filteredVelIntel(i-j,3)];
    end
    doubleFilteredVelIntel(i,1) = pSum(1);
    doubleFilteredVelIntel(i,2) = pSum(2);
    doubleFilteredVelIntel(i,3) = pSum(3);
end

doubleFilteredVelMotiv = zeros(length(filteredVelMotiv),3);
for i =orderMotivVel:length(filteredVelMotiv)
    pSum = 0;
    for j = 0:orderMotivVel-1
       coeff = 1/orderMotivVel;
       pSum = pSum + coeff*[filteredVelMotiv(i-j,1) filteredVelMotiv(i-j,2) filteredVelMotiv(i-j,3)];
    end
    doubleFilteredVelMotiv(i,1) = pSum(1);
    doubleFilteredVelMotiv(i,2) = pSum(2);
    doubleFilteredVelMotiv(i,3) = pSum(3);
end


figure
subplot(2,2,1);
plot(filteredVelMotiv(:,1),'r')
title("Position Filtered Motion Capture System")
ylabel("Velocity Z (m/s)")
xlabel("Frame Number")
subplot(2,2,2);
plot(filteredVelIntel(:,1),'r')
title("Position Filtered Intel Camera")
ylabel("Velocity Z (m/s)")
xlabel("Frame Number")
subplot(2,2,3)
plot(doubleFilteredVelMotiv(:,1),'r')
title("Position and Velocity Filtered Motiv Data");
ylabel("Velocity Z (m/s)")
xlabel("Frame Number")
subplot(2,2,4)
plot(doubleFilteredVelIntel(:,1),'r')
title("Position and Velocity Filtered Intel Cam");
ylabel("Velocity Z (m/s)")
xlabel("Frame Number")

figure
subplot(2,2,1);
plot(filteredVelMotiv(:,2),'g')
title("Position Filtered Motion Capture System")
ylabel("Velocity Z (m/s)")
xlabel("Frame Number")
subplot(2,2,2);
plot(filteredVelIntel(:,2),'g')
title("Position Filtered Intel Camera")
ylabel("Velocity Z (m/s)")
xlabel("Frame Number")
subplot(2,2,3)
plot(doubleFilteredVelMotiv(:,2),'g')
title("Position and Velocity Filtered Motiv Data");
ylabel("Velocity Z (m/s)")
xlabel("Frame Number")
subplot(2,2,4)
plot(doubleFilteredVelIntel(:,2),'g')
title("Position and Velocity Filtered Intel Cam");
ylabel("Velocity Z (m/s)")
xlabel("Frame Number")

figure
subplot(2,2,1);
plot(filteredVelMotiv(:,3),'b')
title("Position Filtered Motion Capture System")
ylabel("Velocity Z (m/s)")
xlabel("Frame Number")
subplot(2,2,2);
plot(filteredVelIntel(:,3),'b')
title("Position Filtered Intel Camera")
ylabel("Velocity Z (m/s)")
xlabel("Frame Number")
subplot(2,2,3)
plot(doubleFilteredVelMotiv(:,3),'b')
title("Position and Velocity Filtered Motiv Data");
ylabel("Velocity Z (m/s)")
xlabel("Frame Number")
subplot(2,2,4)
plot(doubleFilteredVelIntel(:,3),'b')
title("Position and Velocity Filtered Intel Cam");
ylabel("Velocity Z (m/s)")
xlabel("Frame Number")




%Can also plot the position versus time to understand the amount of phase
%lag present when a given filter order is applied

posIntelMag = zeros(length(xT), 1);
for i = 1:length(xT)
   posIntelMag(i) = sqrt(xT(i)^2 + yT(i)^2 + zT(i)^2); 
end
posFilteredRSMag = zeros(length(filteredPosRS), 1);
for i = 1:length(filteredPosRS)
   posFilteredRSMag(i) = sqrt(filteredPosRS(i,1)^2 + filteredPosRS(i,2)^2 + filteredPosRS(i,3)^2); 
end

figure
plot(posIntelMag);
hold on
plot(posFilteredRSMag);
xlabel("Frame Number");
ylabel("Magnitude of position (m)")
title("Demonstrating Phase Lag with filter order " + int2str(orderRS))

%For order 7:
(6072-6069)

%For order 5:
(6017 - 6015)

%For order 10:
(6054 - 6049)

%For order 25:
(6021 - 6009)

%For order 50:
(6048 - 6023)

%For order 100:
(6084 - 6034)

%For order 200:
(6092 - 5965)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The following uses correlation to find the true phase lag%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Keep shifting posFilteredRSMag left until the correlation is at a maximum
%Shifting right not needed since the filter shifts left
%{
maxShiftOrderRight = 1000
RR = zeros(maxShiftOrderRight,1);
for shiftOrder = 1:maxShiftOrderRight
    posFilteredRSMag = circshift(posFilteredRSMag, 1);
    tempArr = corrcoef(posIntelMag, posFilteredRSMag);
    RR(shiftOrder) = tempArr(1,2);
end
%}

maxShiftOrderLeft = 20
RL = zeros(maxShiftOrderLeft,1);
peak = -2
peakShift = -1
disablePeak = false
for shiftOrder = 1:maxShiftOrderLeft
    posIntelMag = circshift(posIntelMag, 1);
    posIntelMag(1) = 0;
    tempArr = corrcoef(posIntelMag, posFilteredRSMag);
    if(~disablePeak & shiftOrder > 1 & tempArr(1,2) < RL(shiftOrder-1))
       peak = RL(shiftOrder-1);
       peakShift = shiftOrder-1;
       disablePeak = true;
    end
    RL(shiftOrder) = tempArr(1,2);
end

figure
plot(RL)
xlabel("Horizontal Translation (Number of Frames at 200Hz)")
ylabel("Correlation Coefficient")
title("Correlation vs. Horizontal Shift")
%for i = 1:shiftOrder
%    posFilteredRSMag(i) = posFilteredRSMag(shiftOrder+1);
%end
