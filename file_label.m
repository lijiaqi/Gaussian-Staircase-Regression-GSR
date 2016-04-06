%%%  from "mat" files to "file_label",with the form:[subject part label]
%    e.g.,the first sample in training set is "203_1", 
%         of which the label is 3, so [203 1 3]
clear all;
path=['E:\AVECdata\Training_DepressionLabels\'];
file_labels=[];
count=0;
for i=203:333
    for j=1:4
        filename=[num2str(i) '_' num2str(j) '_Depression'];
        filename2=[filename '.csv'];
        if exist([path filename2],'file')~=0
            count=count+1
            label=csvread([path filename2]);
            file_labels=[file_labels;[i,j,label]];
     
        else
            continue;
        end
        
    end    
end