%{
All resized images will be saved in the following directory
%}
ori_dir='C:\Users\Documents\Task4\CNN_PCA_PNN\testDataB\vase\vase';
%{
The original images to be resized are kept in the following directory.
%}
path='C:\Users\Documents\Task4\CNN_PCA_PNN\testDataB\vase\';
myfolder=path;
a=dir([myfolder '/*.jpg']);
N=size(a,1); % find the number of images in the folder
files=dir([path '*.jpg']);
k=1;
while k<=N
originalimage=imread([path files(k).name]);
resizedimage = imresize(originalimage, [28 28]);
fname = sprintf('cz%d.jpg', k);
destinationFolder=ori_dir;
fullDestinationFileName = fullfile(destinationFolder,fname);
imwrite(resizedimage, fullDestinationFileName);
k=k+1;
end%while k<=N