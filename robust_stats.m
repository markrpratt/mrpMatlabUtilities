function rstats = robust_stats(v)
% Robust statistics on vector or matrix columns
% rsig is estimated by assuming a gaussian central lobe (+/- sigma)
if ndims(v) > 2
    rstats = [];
    return;
end;
pt = prctile(v,100*normcdf([-1 0 1]));  % median and gaussian +/- 1 sig pts
rstats.mean = nanmean(v);
rstats.sig = nanstd(v);
rstats.min = nanmin(v);
rstats.max = nanmax(v);
sz = size(v);
if sz(1)==1 || sz(2)==1
    rstats.med = pt(2);
    rstats.rsig = diff(pt([1 3]))/2;
else
    rstats.med = pt(2,:);
    rstats.rsig = diff(pt([1 3],:))/2;
end;
