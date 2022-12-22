function[PCX,vv]=PCM(featuresTrain,thr)
Q=cov(featuresTrain); % covariance matrix
[coeff,latent,explained] = pcacov(Q);
%Select principal components upto 95% variability
PCX=[];% will contain all the selected principal components
ne=size(explained);
ne1=ne(1,1);
vv=0;
K=1;
while K<=ne1
    if vv>thr
        break
    else
        e1=explained(K,1);
        vv=vv+e1;
        cc1=coeff(K,:);
        PCX=[PCX;cc1];
    end% end if vv>95

    K=K+1;
end%while K<=ne1
