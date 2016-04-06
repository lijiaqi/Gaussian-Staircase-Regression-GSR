function [mu,sigma]=CreatGaussian(X)
%%%   Gaussian model represent by data matrix X
%       Input:
%           X: data matrix(observation matrix)
%                with dimension = n * d
    [n,d]=size(X); % d:dim of random vector
    
    mu=zeros(d,1);
    sigma=zeros(d,d);
    
    mu=(mean(X))';
    sigma=cov(X); % divide by n-1
end