function [Ml2,Sl2,Mh2,Sh2] = ...
           SubjectAdaptation(features,label,Ml,Sl,Mh,Sh,Thresholds)
%%% subject based adaptation for one subject
%     Input:
%        features: serie of Xt,(a Xt in a row)
%        label: label of this subject
%        Ml,Sl,Mh,Sh: before adaptation
%        Threshold: a vector of 8 threshold
%     Output:
%        Ml2,Sl2,Mh2,Sh2: after adaptation

    Ml2=Ml;
    Sl2=Sl;
    Mh2=Mh;
    Sh2=Sh;
    nbframes=size(features,1); % num of frames(T in paper)
    num_thres=size(Ml,2); % here num_thres=8 :8 pairs of Gaussian
    alpha=nbframes/(nbframes+0.5);
    for i=1:num_thres
       if label < Thresholds(i)
           for t=1:nbframes
               Ml2(:,i)=(1-alpha)*Ml2(:,i)+alpha* features(t,:)';
           end
       else
           for t=1:nbframes
               Mh2(:,i)=(1-alpha)*Mh2(:,i)+alpha* features(t,:)';
           end
       end
    end
    
end

