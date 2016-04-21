function ch = rgbhist(im,bins)
ch = zeros(numel(bins),3);
for c = 1:3
    cim = squeeze(im(:,:,c));
    ch(:,c) = hist(single(cim(:)),bins);
end;
cm = colormap;
colormap([1 0 0; 0 1 0; 0 0 1]);
bar(ch);
% colormap(cm);