function [projectedInputs]=PCAInputTransformation(inputs,PCX,MeanX)
ni=size(inputs);
ni1=ni(1,1);
np=size(PCX);
np1=np(1,1);
projectedInputs=[];
K=1;
while K<=ni1
    
inp1=inputs(K,:)-MeanX;
pcaFeatures=[];
k1=1;
while k1<=np1
px=PCX(k1,:);
PP=dot(inp1,px);
pcaFeatures=[pcaFeatures,PP];
    k1=k1+1;
end%while k1<=np1
projectedInputs=[projectedInputs;pcaFeatures];
    K=K+1;
end%projectedInputs