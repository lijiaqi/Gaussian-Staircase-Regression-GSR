function [mu_low,sigma_low,mu_high,sigma_high,total] =...
    Gaussian_pairs(threshold,mylabelfile,fea_path)
%%%   Gaussian_pairs() return two Gaussians,one for low level, 
%         another for high level,with the label compared to the threshold 
%%%     Input:
%          threshold: threshold to classify two levels
%          mylabelfile: a 50*3 matrix, with a row represent [subject part label]
%                     just like "203 1 3" 
%          fea_path: path of features ".mat" files
%%%     Output:
%          means and covariance matrixs of two Gaussian
%% Example:  Gaussian_pairs(5,train_label_3,...
%          'E:\AVECdata\Training_AudioFeatures\Training\mfcc_delta_mat_train\' )

%% find whose label < threshold
    low_index=find( mylabelfile(:,3)<threshold );
    % nb of low level subjects
    nblow=size(low_index,1); 
    
    %% find whose label >= threshold
    high_index=find( mylabelfile(:,3)>=threshold );
    %nb of high level subjects
    nbhigh=size(high_index,1); 
    
%%  
    features_low=[];
    ntotal_low=0;
    for i=1:nblow
        subj=mylabelfile(low_index(i),1);
        part=mylabelfile(low_index(i),2);
        
        dataname=['htk_' num2str(subj) '_' num2str(part) '_cut_audio_mfcc_delta_pca'];
        load([fea_path dataname '.mat']);
        eval(['ntotal_low=ntotal_low+size(' dataname ',1);']);
        eval(['features_low=[features_low;' dataname '];']);
    end
    [mu_low,sigma_low]=CreatGaussian(features_low);
%%    
    features_high=[];
    ntotal_high=0;
    for i=1:nbhigh
        subj=mylabelfile(high_index(i),1);
        part=mylabelfile(high_index(i),2);
        
        dataname=['htk_' num2str(subj) '_' num2str(part) '_cut_audio_mfcc_delta_pca'];
        load([fea_path dataname '.mat']);
        eval(['ntotal_high=ntotal_high+size(' dataname ',1);']);
        eval(['features_high=[features_high;' dataname '];']);
    end
    [mu_high,sigma_high]=CreatGaussian(features_high);
     total=[features_high;features_low];
    
end

