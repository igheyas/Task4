clear all
close all
clc
digitDatasetPath='C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CPP\testDatabase';
testimds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');

% load trained CNN
load("CNNnetImage.mat")
inputSize =CNNnetImage.Layers(1).InputSize;
% resize images
augimdsTest = augmentedImageDatastore(inputSize(1:2),testimds);

layer = 'relu_5';
%Extract features from the CNN
featuresTest = activations(CNNnetImage,augimdsTest,layer,'OutputAs','rows');

load("C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CPP\PCX.mat")

%project  training datapoints on the Principal components
inputs=featuresTest;
[projectedInputs]=PCAInputTransformation(inputs,PCX);
nf=size(projectedInputs);
featuresTest1=projectedInputs;
%actual output
YTest = testimds.Labels;
load("C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CPP\categories.mat")
load("C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CPP\Networks.mat")
[YTestOutput]=convertTestOutputBinary(categories,YTest);
actualTestOutput=YTestOutput; % all numbers
[predictedProbAllCategory]=PNNPred(actualTestOutput,projectedInputs,Networks);

[predictedCategory,predictedCategoryString,accuracy]=performanceMeasurement(actualTestOutput,predictedProbAllCategory,categories);
n=size(YTestOutput);
n1=n(1,1);
%generate random number within certain range
numberImageVisualied=9;
ay = 1;
by = n1;
r = (by-ay).*rand(numberImageVisualied,1) + ay;
r=round(r);
r1=r';

idx=r1;
path='C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CPP\testDatabase\';
myfolder=path;
a=dir([myfolder '/*.jpg']);
N=size(a,1); % find the number of images in the folder
files=dir([path '*.jpg']);
nh=size(idx);
nh1=nh(1,2);
NV=round(nh1/3)+1;
figure

%for i = 1:N
for i = 1:numel(idx)
    %testimage=imread([path files(i).name]);
     testimage = readimage(testimds,idx(i));
     label = predictedCategoryString(idx(i));
    subplot(NV,3,i)
    
    %label = predictedCategoryString(i);
    imshow(testimage)
    title(char(label))
end
sgtitle('Predicted Labels by CPP')
