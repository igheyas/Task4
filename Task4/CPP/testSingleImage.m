clear all
close all
clc
% load trained CNN
load("CNNnetImage.mat")
inputSize =CNNnetImage.Layers(1).InputSize;
load("C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CPP\PCX.mat")
load("C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CPP\categories.mat")
load("C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CPP\Networks.mat")
path='C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CPP\testnoSubfolder\';
myfolder=path;
a=dir([myfolder '/*.jpg']);
N=size(a,1); % find the number of images in the folder
files=dir([path '*.jpg']);
predictedOutput=[];
k=1;
while k<=N
testimage=imread([path files(k).name]);
% resize images
augimdsTest = augmentedImageDatastore(inputSize(1:2),testimage);

layer = 'relu_5';
%Extract features from the CNN
featuresTest = activations(CNNnetImage,augimdsTest,layer,'OutputAs','rows');
inputs=featuresTest;
[projectedInputs]=PCAInputTransformation(inputs,PCX);
nf=size(projectedInputs);
featuresTest1=projectedInputs;
%[predictedProbAllCategory]=PNNPred(actualTestOutput,projectedInputs,Networks);
[predictedProbAllCategory]=PNNPredSingle(projectedInputs,Networks);


[predictedCategory,predictedCategoryString]=finalPredSingle(predictedProbAllCategory,categories);
predictedOutput=[predictedOutput;predictedCategoryString];
%YPred = classify(net,testimage);

%predictedOutput=[predictedOutput;YPred];
k=k+1;
end%while k<=N

%%%%%%%%%%%%%Figure%%%%%%%%%%%%%%%%%%%%%%%%%%
idx=[1:N];
nb=size(idx);
nb1=nb(1,2);

figure
NV=(round(nb1/3))+1;
for i = 1:numel(idx)

  
    testimage=imread([path files(i).name]);
    label = predictedOutput(idx(i));
    subplot(NV,3,i)
    
    
    imshow(testimage)
    title(char(label))
end
sgtitle('Classifications by CPP')

