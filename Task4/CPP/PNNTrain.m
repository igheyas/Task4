function[Networks]=PNNTrain(YTrainOutput,featuresTrain1)
n=size(YTrainOutput);
n1=n(1,1);
n2=n(1,2);
Networks=cell(1,n2);
NetwoksV=cell(1,n2);
KK=1;
while KK<=n2
    YTrain1=YTrainOutput(:,KK);
    featuresTrain=featuresTrain1;
[classifierPNN]=trainPNN(featuresTrain,YTrain1);
Networks{1,KK}=classifierPNN;
inputs=featuresTrain;
outs=YTrain1;

KK=KK+1;
end%while KK<=n1
