function [coeff,score,latent,pnames] = namePCA(v,vnames)
% using input vnames, construct concatenated names for top PCs

[coeff,score,latent] = pca(v);
% rsC = robust_stats(abs(pC));  
[~,ispC] = sort(abs(coeff),'descend');
for i = size(coeff,2):-1:1
    pnames{i} = [vnames{ispC(1,i)} ':' vnames{ispC(2,i)} ':' vnames{ispC(3,i)}];
end;
    
