function [probabilityTestImage]=PNNPrediction(classifierPNN,projectedInputs)
%[probabilityTestImage,out,output,accuracy]=predictionPNN(classifierPNN,featuresTest,YTest)
featuresTest=projectedInputs;

PP=classifierPNN{:,1};
TT=classifierPNN{1,2};
sd=classifierPNN{:,3};
np=size(PP);
np1=np(1,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=size(featuresTest);
n1=n(1,1);
K=1;
HH=[];
while K<=n1
TP=featuresTest(K,:);
mb=[];
h=[];
k1=1;
while k1<=np1
tri=PP(k1,:);
tro=TT(k1,:);
d= norm(TP - tri);
d2=d^2;
sd1=2*(sd)^2;
sf=-(d2/sd1);
sf1=exp(sf);
sf2=sf1*tro;
mb=[mb;sf2];
h=[h;sf1];
    k1=k1+1;
end%while k1<=np1
bm1=sum(mb);
hb=sum(h);
u=bm1/hb;
HH=[HH;u];
    K=K+1;
end%while K<=n1
probabilityTestImage=HH;
