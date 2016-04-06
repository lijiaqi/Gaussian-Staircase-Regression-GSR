function [S,count] = scoreCompute(pathname,Ml,Sl,Mh,Sh)
% 'E:\AVECdata\Training_AudioFeatures\Training\MFCC_delta_training_pca\'
%  'E:\AVECdata\Development_AudioFeatures\Development\MFCC_delta_dev_pca\'
    S=[];
    count=0;
    for i=203:333
       for j=1:4

           dataname=['htk_' num2str(i) '_' num2str(j) '_cut_audio_mfcc_delta_pca'];
           filename=[dataname '.mat'];

           if exist([pathname filename],'file')
               count=count+1;
               load([pathname filename]);
               eval( [ 'score' , '= LMLR(' ,dataname ',Ml,Sl,Mh,Sh );' ] );
               S=[S;score];
           else 
               continue;
           end

       end
    end

end

