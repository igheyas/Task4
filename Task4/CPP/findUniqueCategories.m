function[categories]=findUniqueCategories(YTrain)
ny=size(YTrain);
ny1=ny(1,1);
categories=YTrain(1,1);
categories=char(categories);
categories=convertCharsToStrings(categories);
k=2;
while k<=ny1
ct=YTrain(k,1);
ct1=char(ct);
ct2=convertCharsToStrings(ct1);
nc=size(categories);
nc1=nc(1,2);
k1=1;
np=0;
while k1<=nc1
ctg=categories(1,k1);
tf=strcmp(ct2,ctg);
if tf==1
    np=1;
break

end%if tf==1
    k1=k1+1;
end%while k1<=nc1
if np==0
categories=[categories,ct2];
end%if np==1
    k=k+1;
end%while k<=ny1