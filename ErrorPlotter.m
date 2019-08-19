
%This script aligns the T265 data and motion capture data in time to plot
%and analyze the errors associated with the T265

M1 = csvread("C:\Users\mitch\Documents\ResearchSummer19\FacingSideways\ZAxisNvidia.csv");
M2 = csvread("C:\Users\mitch\Documents\ResearchSummer19\FacingSideways\ZAxisMotivFormatted.csv");

dataT = M1(:,7:9);
dataM = M2(:,1:3);
dataM = dataM(1:50*120,:);
%The two arrays are now of corresponding sizes
%Can bin dataT in bins of 5 as it is 200Hz and dataM in bins of 3 as it is
%120Hz
length(dataM)
length(dataT)
avgBinT = zeros(length(dataT)/5, 3);
avgBinM = zeros(length(dataM)/3, 3);
k = 1;
newInd = 0;
%Binning of 5
for i=1:length(dataT)
    if(newInd == 4)
        newInd = 0;
        k = k+1;
    else
        newInd = newInd + 1;
        avgBinT(k,1) = avgBinT(k,1) + dataT(i,1);
        avgBinT(k,2) = avgBinT(k,2) + dataT(i,2);
        avgBinT(k,3) = avgBinT(k,3) + dataT(i,3);
    end
end
k = 1;
newInd = 0;
%Binning of 3
for i=1:length(dataM)
    if(newInd == 2)
        newInd = 0;
        k = k+1;
    else
        newInd = newInd + 1;
        avgBinM(k,1) = avgBinM(k,1) + dataM(i,1);
        avgBinM(k,2) = avgBinM(k,2) + dataM(i,2);
        avgBinM(k,3) = avgBinM(k,3) + dataM(i,3);
    end
end

%Now divide bins by bin sizes

for i=1:length(avgBinM)

    avgBinM(i,1) = avgBinM(i,1)/3;
    avgBinM(i,2) = avgBinM(i,2)/3;
    avgBinM(i,3) = avgBinM(i,3)/3;
    avgBinT(i,1) = avgBinT(i,1)/5;
    avgBinT(i,2) = avgBinT(i,2)/5;
    avgBinT(i,3) = avgBinT(i,3)/5;
end

errorsVect = zeros(size(avgBinT));

for i=1:length(avgBinM)
    errorsVect(i,1) = abs(avgBinM(i,1) - avgBinT(i,1));
    errorsVect(i,2) = abs(avgBinM(i,2) - avgBinT(i,2));
    errorsVect(i,3) = abs(avgBinM(i,3) - avgBinT(i,3));
end

errors = zeros(length(avgBinT),1);
for i=1:length(avgBinM);
    errors(i) = sqrt(errorsVect(i,1)^2 + errorsVect(i,2)^2 + errorsVect(i,3).^2);
end

%histogram(errors, round(sqrt(length(errors))));
hold on
xlabel("Error (m)");
ylabel("Number of Data Points");
title("RealSense T235 Error");
maximum = max(errors)
minimum = min(errors)
sigma = std(errors)
middle = median(errors)
average = mean(errors)

%If the error is large and is in the same direction as the motion of the
%device then it is likely due to the two tests starting at different times

xCount = 0;
yCount = 0;
zCount = 0;

for i=1:length(errorsVect)
    if errorsVect(i,1) > average
        xCount = xCount + 1;
    elseif errorsVect(i,2) > average
        yCount = yCount + 1;
    elseif errorsVect(i,3) > average
        zCount = zCount + 1;
    end
end

%For non temporal alignment can look at the errors that aren't in the
%direction of motion to get a good idea of how much error is actually
%present

%Used to find the path of motion based on the errors
xFlag = 0;
yFlag = 0;
zFlag = 0;
if xCount > yCount && xCount > zCount
    xFlag = 1;
elseif  yCount > xCount && yCount > zCount
    yFlag = 1;
elseif zCount > yCount && zCount > xCount
    zFlag = 1;
end

correctedAvgError = zeros(length(avgBinT),1);
for i=1:length(errorsVect)
    if xFlag == 1
        correctedAvgError(i,1) = sqrt(errorsVect(i,2)^2 + errorsVect(i,3)^2);
    elseif yFlag == 1
         correctedAvgError(i,1) = sqrt(errorsVect(i,1)^2 + errorsVect(i,3)^2);
    elseif zFlag == 1
         correctedAvgError(i,1) = sqrt(errorsVect(i,1)^2 + errorsVect(i,2)^2);
    end
end

histogram(correctedAvgError, round(sqrt(length(correctedAvgError))));
hold on
xlabel("Error (m)");
ylabel("Number of Data Points");
title("RealSense T235 Error");
maximum = max(correctedAvgError)
minimum = min(correctedAvgError)
sigma = std(correctedAvgError)
middle = median(correctedAvgError)
average = mean(correctedAvgError)
line([average average], [0 120], 'color', 'r', 'LineWidth', 2)
line([average-sigma average-sigma], [0 120], 'color', 'g', 'LineStyle', '--', 'LineWidth', 2)
line([average+sigma average+sigma], [0 120], 'color','g', 'LineStyle', '--', 'LineWidth', 2)
