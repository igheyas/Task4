function[classifierPNN]=trainPNN(featuresTrain,YTrain1)
n=size(featuresTrain);
n1=n(1,1);
DD=[];
K=1;
while K<=n1
TP=featuresTrain(K,:);
dd=[];
k1=1;
while k1<=n1

tp=featuresTrain(k1,:);
d=norm(TP-tp);
dd=[dd;d];
    k1=k1+1;
end%while k1<=n1
dp1=mean(dd);
DD=[DD;dp1];
    K=K+1;
end%while K<=n1
r=[1:n1]';
DD=[r,DD];
DD=sortrows(DD,2,"ascend");
indx=DD(1,1);
MM=featuresTrain(indx,:); % ceeentre

%%Standard deviation%%%%%%%%55555
DV=[];
K=1;
while K<=n1
TP=featuresTrain(K,:);
d=norm(TP-MM);
DV=[DV;d];
    K=K+1;
end%while K<=n1
sd=mean(DV);

%%%%%%%%%%%%%%pnn%%%%%%%%%%%%%%%%
HT{1,1}=featuresTrain;
HT{1,2}=YTrain1;
HT{1,3}=sd;
classifierPNN=HT;
outputDir = "C:\Users\CSMIGHEY\Documents\Task4\waveletScattering";
outputFile = fullfile(outputDir, "classifierPNN.mat");
save(outputFile, "classifierPNN");
