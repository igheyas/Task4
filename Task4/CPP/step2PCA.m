clear all
close all
clc
digitDatasetPath='C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CPP\Database';
imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
% load trained CNN
load("CNNnetImage.mat")
inputSize =CNNnetImage.Layers(1).InputSize;
% resize images
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
%analyzeNetwork(CNNnetImage)

layer = 'relu_5';
%Extract features from the CNN
featuresTrain = activations(CNNnetImage,augimdsTrain,layer,'OutputAs','rows');
% find principal componentss
%{
% select principal components (PCX) that explains thr% of variance

%vv: threshold cumulative percent variance
%}
thr=99; 
[PCX,vv]=PCM(featuresTrain,thr);
outputDir = "C:\Users\Documents\Task4\CNN_PCA_PNN";
outputFile = fullfile(outputDir, "PCX.mat");
save(outputFile, "PCX");
%project  the datapoints onto the Principal components
inputs=featuresTrain;
[projectedInputs]=PCAInputTransformation(inputs,PCX);
nf=size(projectedInputs);
featuresTrain1=projectedInputs;

%{
find unique categories
%}
YTrain = imds.Labels;
[categories]=findUniqueCategories(YTrain);

outputDir = "C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CPP";
outputFile = fullfile(outputDir, "categories.mat");
save(outputFile, "categories");
%{
create a binay output variable for each category of the output variable
%}
[YTrainOutput]=convertTrainingOutputBinary(categories,YTrain);

%%%%%%%%%%%%Training PNN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Networks]=PNNTrain(YTrainOutput,featuresTrain1);
outputDir = "C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CPP";
outputFile = fullfile(outputDir, "Networks.mat");
save(outputFile, "Networks");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Get the accuracy of the trained
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%networks on the training+validation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%sets
featuresTest=featuresTrain1;
projectedInputs=featuresTest;
actualTestOutput=YTrainOutput; % all numbers
%{
'predictedProbAllCategory' contains the predicted probability of the
category of interest in each binary output variable.
%}
[predictedProbAllCategory]=PNNPred(actualTestOutput,projectedInputs,Networks)
%{
"predictedCategory" contains a vector of zeros and ones for each test
image where 0 indicates the category of the test image is not the category 
of the interest in the corresponding output variable and 1 indicates 
the category of the test image is the category of the interest in the corresponding output variable.  
'predictedCategoryString' is a column vector containing the predicted label
of the image in string.
%}
       
[predictedCategory,predictedCategoryString,accuracy]=performanceMeasurement(actualTestOutput,predictedProbAllCategory,categories);


