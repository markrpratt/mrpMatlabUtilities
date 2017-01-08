function chist(v,b)

if nargin < 2
    [hh, bb] = hist(v);
else
    [hh, bb] = hist(v,b);
end;
ch = cumsum(hh)/sum(hh);
bar(bb,hh/max(hh(:)),'edgecolor','none');
hold on;
plot(bb,ch,'w-','linewidth',3);
plot(bb,ch,'b-','linewidth',1);
hold off;
set(gca,'xgrid','on','ygrid','on');



