clear all
close all
clc
load('C:\Users\Documents\Task4\CNN_PCA_PNN\sent\CNN\CNNnetImage.mat');
inputSize =CNNnetImage.Layers(1).InputSize;
%{
check how many image in the test set
%}

path='C:\Users\Documents\Task4\CNN_PCA_PNN\testnoSubfolder\';
myfolder=path;
a=dir([myfolder '/*.jpg']);
N=size(a,1); % find the number of images in the folder
files=dir([path '*.jpg']);
predictedOutput=[];
k=1;
while k<=N
testimage=imread([path files(k).name]);
testimage=augmentedImageDatastore(inputSize(1:2),testimage);
YPred = classify(CNNnetImage,testimage);

predictedOutput=[predictedOutput;YPred];
k=k+1;
end%while k<=N


figure
for i = 1:N
    testimage=imread([path files(i).name]);
    subplot(4,3,i)
    
    label = predictedOutput(i);
    imshow(testimage)
    title(char(label))
end
sgtitle('CNN')