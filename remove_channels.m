function [data2, labels2]=remove_channels(data,labels,labels2remove)

index2=[];
for i=1:length(labels2remove)
    
index=strcmp(labels,labels2remove(i));

index2=[index2 find(index==1)];

end

labels(:,index2)=[];
data(index2',:)=[];

data2=data;
labels2=labels;

end