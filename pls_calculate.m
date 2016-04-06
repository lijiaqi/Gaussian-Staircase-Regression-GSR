function [yp, error,MAE,RMSE]=pls_calculate(x1,y1,x2,y2)
%% pls regression calaulate which call the function pls()
%  Input:
%      x1: matrix of predictors for training   n * m
%      y1: matrix of responses for training    n * p
%      x2: matrix of predictors for test       n_test * m
%      y2: matrix of responses for test        n_test * p
%  Output:
%      yp: matrix of predictions for x2   n_test * p
%     error: yp-y2
%      MAE ,RMSE: if p=1, we calculate MAE and RMSE
%%  normalization 
    N=size(x1,1);
    xmean=mean(x1);
    xstd=std(x1);
    ymean=mean(y1);
    ystd=std(y1);
    X=(x1-xmean(ones(N,1),:))./xstd(ones(N,1),:);
    Y=(y1-ymean(ones(N,1),:))./ystd(ones(N,1),:);
    %% PLS model
    [T,P,U,Q,B,W]=pls(X,Y,1);
    %% Prediction and error\
    x2_norm=x2;
    x2_norm=bsxfun(@minus,x2_norm,xmean);
    x2_norm=bsxfun(@rdivide,x2_norm,xstd);
    %% =========================================
    %%% 两种predict的方法，貌似第二种更准确    
    %%% Y1 = (X1*P)*B*Q' = X1*(P*B*Q')  or   
    %%% Y1 = X1*(W*inv(P'*W)*inv(T'*T)*T'*Y) 
    %%%=========================================

    % yp_norm= x2_norm* (P*B*Q');
    yp_norm= x2_norm*(W*inv(P'*W)*inv(T'*T)*T'*Y);
    %% === 用 ystd 和 ymean 逆normalization ===
    yp=bsxfun(@times,yp_norm,ystd); 
    yp=bsxfun(@plus,yp,ymean);

    %% if yp < 0 , yp <- 0
    index=find(yp<0);
    yp(index)=0;
    yp=round(yp);
    error=yp-y2; 

    %% MAE and RMSE
    if size(y1,2)==1
        n_test=size(y2,1);
        MAE=sum(abs(error))/n_test;
        RMSE=sqrt( sum(error.^2)/n_test );
    else
        MAE=[];
        RMSE=[];
    end

end