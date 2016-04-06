function p=GaussianPDF(x,mu,sigma)
%%% calculate probability in Gaussian: p(x)
%     Input:
%        x: data vector
%        mu: mean vector of Gaussian(in column)
%        sigma: covariance matrix of Gaussian
    d=size(mu,1);
%     p=1/(power(2*pi,d/2)* sqrt(det(sigma))) *exp(-1/2 * (x-mu)'*pinv(sigma)* (x-mu));
    p=(2*pi)^(-d/2)*  det(sigma)^(-1/2)  *exp(-1/2 * (x-mu)' *pinv(sigma)* (x-mu));

end