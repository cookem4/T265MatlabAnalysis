dataMat = csvread("FullCamData.csv", 1,0);

sum1 = 0;
sum2 = 0;
sum3 = 0;
for i = 1:length(dataMat)
    if(dataMat(i,1))
        sum1 = sum1 + 1;
    end
    if(dataMat(i,2))
        sum2 = sum2 + 1;
    end
    if(dataMat(i,3))
        sum3 = sum3 + 1;
    end
end
mean1 = sum1/length(dataMat);
mean2 = sum2/length(dataMat);
mean3 = sum3/length(dataMat);

var1 = var(dataMat(:,1));
var2 = var(dataMat(:,2));
var3 = var(dataMat(:,3));

std1 = sqrt(var1);
std2 = sqrt(var2);
std3 = sqrt(var3);

