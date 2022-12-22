clear all
close all
clc
load('C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CNN\CNNnetImage.mat');
inputSize =CNNnetImage.Layers(1).InputSize;

digitDatasetPath='C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CNN\testDatabase\';
testimds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
YTest = testimds.Labels;
digitestimage=augmentedImageDatastore(inputSize(1:2),testimds);
%resize
testimds=augmentedImageDatastore(inputSize(1:2),testimds);
%YPred = classify(net,XTest,'MiniBatchSize',miniBatchSize);
YPred = classify(CNNnetImage,testimds);

accuracy = sum(YPred == YTest)/numel(YTest)