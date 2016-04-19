function score= LMLR( features,Ml,Sl,Mh,Sh )
%%% Gives featrues and models, return LMLR
%     Input:
%        features: nbframes * nbfea ,serie of Xt,each row is a frame t
%        Ml,Sl,Mh,Sh: 8 models, range in column
%           l: low  h:high
%     Output:
%        score: a vector of LMLR for 8 threshold

    [nbframes,nbfea]=size(features);
    num_pairs=size(Ml,2); % ici =8
    score=zeros(1,num_pairs);
    pL=[];
    pH=[];
    for i=1:num_pairs
        for t=1:nbframes
            pH=[pH;GaussianPDF(features(t,:)' ,Mh(:,i),Sh(:,nbfea*(i-1)+1:nbfea*i))];
            pL=[pL;GaussianPDF(features(t,:)' ,Ml(:,i),Sl(:,nbfea*(i-1)+1:nbfea*i))];
        end
        score(i)=log(sum(pH)/sum(pL));
    end

end

