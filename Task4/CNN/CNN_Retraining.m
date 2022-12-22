clear all
close all
clc
digitDatasetPath='C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CNN\Database';
imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
load("C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CNN\CNNnetImage.mat")
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
options = trainingOptions('sgdm', ...
    'MaxEpochs',60000, ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');

trainNetwork(imdsTrain,CNNnetImage.Layers,options);

%%to save the net
% directory path
%outputDir = "path_to_dir";
outputDir = "C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CNN";
outputFile = fullfile(outputDir, "CNNnetImage.mat");
save(outputFile, "CNNnetImage");