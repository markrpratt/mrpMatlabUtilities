function [mu,sigma,KS] = fitNormCDF(V)
%%
V = V(:);
mu0 = nanmedian(V);
ppV = prctile(V,[1 15.87 84.13 99]);
sig0 = diff(ppV(2:3))/2;
bb = linspace(ppV(1),ppV(end),200);
chh = cumsum(hist(V,bb))/numel(V);
befp = @(X)sum((chh-normcdf(bb,X(1),X(2))).^2);
X = fminsearch(befp,double([mu0 sig0]));
mu=X(1);
sigma=X(2);
KS = max(abs(chh-normcdf(bb,mu,sigma)));
