clear all
close all
clc
digitDatasetPath='C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CNN\Database';
imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
%{
To see a particular image: just change the number in the curly bracket.
First N files from the first folder and the remaining number for the second
folder
%} 

%figure; imshow(imds.Files{10})

fracTrainFiles=0.7;
fracValFiles=0.3;
[imdsTrain,imdsValidation]=splitEachLabel(imds,...
    fracTrainFiles,fracValFiles,'randomized');
imageSize = [28 28 3];
numClasses = 2;

layers = [
    imageInputLayer(imageSize)
    
    convolution2dLayer(3,60,'Padding','same')
    batchNormalizationLayer
    reluLayer   
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,50,'Padding','same')
    batchNormalizationLayer
    reluLayer   
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,40,'Padding','same')
    batchNormalizationLayer
    reluLayer   
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(3,30,'Padding','same')
    batchNormalizationLayer
    reluLayer  
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(3,20,'Padding','same')
    batchNormalizationLayer
    reluLayer  
    
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];



options = trainingOptions('sgdm', ...
    'MaxEpochs',60000, ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');

CNNnetImage = trainNetwork(imdsTrain,layers,options);
%{
imdsTest=imread(imds.Files{1});
YPred = classify(net,imdsTest);
%}
%%to save the net
% directory path
%outputDir = "path_to_dir";
outputDir = "C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CNN";
outputFile = fullfile(outputDir, "CNNnetImage.mat");
save(outputFile, "CNNnetImage");