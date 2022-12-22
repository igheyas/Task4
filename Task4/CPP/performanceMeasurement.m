function[predictedCategory,predictedCategoryString,accuracy]=performanceMeasurement(actualTestOutput,predictedProbAllCategory,categories)
YTrainOutput=actualTestOutput;
na=size(YTrainOutput);
na1=na(1,1);
na2=na(1,2);
G=predictedProbAllCategory;
K=1;
processedPredOut=[];
SL=[1:na2]';
while K<=na1
acout=YTrainOutput(K,:);
F=[];
k1=1;
while k1<=na2
pg=G{1,k1};
pg1=pg(K,1);
    
    F=[F;pg1];
    k1=k1+1;
end%while k1<=na2
F=[SL,F];
F=sortrows(F,2,'descend');
f1=F(1,1);
f2=F(1,2);
if f2<0.5
    F=zeros(1,na2);
else
   F=zeros(1,na2); 
   F(1,f1)=1;
end%if f2<0.5
processedPredOut=[processedPredOut;F];
    K=K+1;
end%while K<=na1

%%%accuracy
K=1;
ac=0;
while K<=na1
aOut=YTrainOutput(K,:);
pOut=processedPredOut(K,:);
g=norm(aOut-pOut);
if g==0
ac=ac+1;
end%if g==0

    K=K+1;
end%while K<=na1
predictedCategory=processedPredOut;
accuracy=(ac/na1)*100
np=size(processedPredOut);
np1=np(1,1);
bu=zeros(np1,1);
k=1;
while k<=np1
px=sum(processedPredOut(k,:));
if px==0
    bu(k,1)=1;
end%if px==0
    k=k+1;
end%while k<=np1
processedPredOut1=[processedPredOut,bu];
np=size(processedPredOut1);
np1=np(1,1);
np2=np(1,2);
categoriesPredicted=[categories,"No known Category"];
categoriesPredicted=categorical(categoriesPredicted);
K=1;
predictedCategoryString=[];
while K<=np1
pout=processedPredOut1(K,:);
gout=[];
k1=1;
while k1<=np2
pr=pout(1,k1);
if pr==1
gout=categoriesPredicted(1,k1);
predictedCategoryString=[predictedCategoryString;gout];
break
end%if pr==1
    k1=k1+1;
end%while k1<=np2
    K=K+1;
end%while K<=np1



