function stats = blobstats(bwim, im, sed)
%% stats = blobstats(bwim, im, sed)
% find centroids, moments and intensities of image blobs
% bwim - binary image defining objects as contiguous true regions
% im - signal image for centroiding and intensity meaurements
% sed - structure element for dilating bwim

if nargin < 3 
    sed = strel('octagon',3);
end
if ~isempty(sed)
    bwim = imdilate(bwim,sed,'same');
end
stats = regionprops(bwim,'Centroid','MajorAxisLength','MinorAxisLength', ...
    'Orientation','Area','Perimeter','Solidity','PixelIdxList');
for b = 1:numel(stats)
    ii = stats(b).PixelIdxLis   t;           % included pixel ids
    stats(b).II = im(ii);                 % pixel intensities
    stats(b).I = sum(stats(b).II);          % intensity
    if stats(b).I<100
        stats(b).I = NaN;
        continue;
    end
    [rr,cc] = ind2sub(size(im), ii);
    % first moment: intensity weighted centroid
    stats(b).xc = sum(stats(b).II.*cc)/stats(b).I;
    stats(b).yc = sum(stats(b).II.*rr)/stats(b).I;
    % second moment: size and ellipticity
    xx = cc-stats(b).xc;
    yy = rr-stats(b).yc;
    M2 = zeros(2);
    M2(1,1) = sum(stats(b).II.*xx.^2)/stats(b).I;
    M2(2,2) = sum(stats(b).II.*yy.^2)/stats(b).I;
    M2(1,2) = sum(stats(b).II.*xx.*yy)/stats(b).I;
    M2(2,1) = M2(1,2);
    [v,d] = eig(M2);
    stats(b).major = sqrt(d(2,2));
    stats(b).minor = sqrt(d(1,1));
    stats(b).ang = atan(v(2,2)/v(1,2));      % trial and error
%  % third & fourth moments: distribution
%     stats(b).skew = [sum(xx.^3.*stats(b).II)/stats(b).I;
%                    sum(yy.^3.*stats(b).II)/stats(b).I];
%     stats(b).kurt = [sum(xx.^4.*stats(b).II)/stats(b).I;
%                     sum(yy.^4.*stats(b).II)/stats(b).I];
% plot major and minor axes
%         plot(blob(b).xc,blob(b).yc,'r+');
% majx = blob(b).xc + [-1 1]*2*blob(b).major*cos(blob(b).ang);
% majy = blob(b).yc + [-1 1]*2*blob(b).major*sin(blob(b).ang);
% plot(majx,majy,'w-','linewidth',2);
% minx = blob(b).xc + [-1 1]*2*blob(b).minor*cos(blob(b).ang+pi/2);
% miny = blob(b).yc + [-1 1]*2*blob(b).minor*sin(blob(b).ang+pi/2);
% plot(minx,miny,'w-','linewidth',2);
% 
% plot(majx,majy,'m-');
% plot(minx,miny,'m-');
%         if blob(b).major/blob(b).minor>2, break; end
end