function[YTestOutput]=convertTestOutputBinary(categories,YTest)
YTrain=YTest
NC=size(categories);
NC1=NC(1,2);
ny=size(YTrain);
ny1=ny(1,1);
YTrainOutput=zeros(ny1,NC1);

K=1;
while K<=NC1
cg=categories(1,K);
k1=1;
while k1<=ny1
out1=YTrain(k1,1);
out2=char(out1);
out3=convertCharsToStrings(out2);
tf=strcmp(cg,out3);
if tf==1
YTrainOutput(k1,K)=1;
end%if tf==1
    k1=k1+1;
end%while k1<=ny1

    K=K+1;
end%while K<=NC1

YTestOutput=YTrainOutput;


