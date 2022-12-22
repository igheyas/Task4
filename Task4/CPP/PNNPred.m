function[predictedProbAllCategory]=PNNPred(actualTestOutput,projectedInputs,Networks)
na=size(actualTestOutput);
na1=na(1,1);
na2=na(1,2);
nm=size(Networks);
nm1=nm(1,1);
nm2=nm(1,2);
G=cell(1,nm2); % will contain predicted conditional means from all networks


        
        K2=1;
        while K2<=nm2

%inputs=projectedInputs;

classifierPNN=Networks{1,K2};
[probabilityTestImage]=PNNPrediction(classifierPNN,projectedInputs);
M=G{1,K2};
M=[M;probabilityTestImage];
G{1,K2}=M;


            K2=K2+1;
        end% while K2<=nm1
predictedProbAllCategory=G;