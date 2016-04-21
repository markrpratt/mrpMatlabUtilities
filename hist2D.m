function h = hist2D(xv, yv, xedge, yedge, trim_ends)
% construct a 2D histogram of values xv and yv
% if trim_ends, discard values outside of extreme edges, otherwise include
% out of range values in first and last bins
% 2D histogram is made from a long 1D histogram of a composite variable 
% in which fractional values are mapped to y and integer values to x
% output is in the form of a 2D array
% xedge and yedge must be uniformly spaced

%%
if trim_ends
    iok = xv>=xedge(1) & xv<=xedge(end) & ...
        yv>=yedge(1) & yv<=yedge(end);
    xv = xv(iok);
    yv = yv(iok);
else
    xv(xv<xedge(1)) = xedge(1);
    xv(xv>xedge(end)) = xedge(end);
    yv(yv<yedge(1)) = yedge(1);
    yv(yv>yedge(end)) = yedge(end);
end;
nx = numel(xedge);
ny = numel(yedge);
vbin =  repmat((0:nx-1), ny, 1) + repmat((0:ny-1)'/ny,1,nx);
[~, xb] = histc(xv, xedge);
[~, yb] = histc(yv, yedge);
v = (xb-1) + (yb-1)/ny;
h = zeros(size(vbin));
h(:) = histc(v,vbin);    
