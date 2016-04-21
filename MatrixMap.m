function MatrixMap(Mfull, catlabels, scaleDiag)
% map matrix elements between rows and columns of a matrix
% Mfull is the input square matrix, catlabels is the category label of
% rows and columns, scaleDiag =1 will map the full matrix, =0 will remove
% the diagonal elements.
% This function can be tightened up bit with the assumption of square inputs

[nr nc] = size(Mfull);
Nd = max([nr nc]);
M = Mfull-eye(size(Mfull)).*Mfull*(1-scaleDiag);


M1 = sum(M); M1f = sum(Mfull);      % column sums
M2 = sum(M,2); M2f = sum(Mfull,2);  % row sums

% build unit spline
XX = [1:0.03:1.09 3.91:0.03:4];
YY = [zeros(1,4) ones(1,4)];
xx = 1:0.1:4;
yy = spline(XX, YY, xx);

cm = jet(2*(nr-1)+1);
cm = cm(1:2:end,:);
%%
% input bars
n = [0 cumsum(M1)/sum(M1)];
for i = 2:numel(n)
    patch([0 0 1 1 0],[n(i-1) n(i) n(i) n(i-1) n(i-1)],cm(i-1,:),'edgecolor','none');
    t1(i-1) = mean(n(i-1:i));
end;
% output bars
n = [0 cumsum(M2')/sum(M2)];
for i = 2:numel(n)
    patch([4 4 5 5 4],[n(i-1) n(i) n(i) n(i-1) n(i-1)],cm(i-1,:),'edgecolor','none');
    t2(i-1) = mean(n(i-1:i));
end;
noticks
hold on; 
% cumulative inputs
cM = reshape(cumsum(M(:)),size(M))/sum(M(:));
cM = [0 cM(:)'];
N = reshape(1:numel(M(:)),size(M))';
[tmp Ni] = sort([0 N(:)']);
% cumulative outputs
Mt = M';
cMt = reshape(cumsum(Mt(:)),size(Mt))/sum(Mt(:));
cMt = [0 cMt(:)'];
% plot splines
for i = 1:numel(cM(:))-1
    yy1 = cM(i)+yy*(cMt(Ni(i+1)-1)-cM(i));
    yy2 = cM(i+1)+yy*(cMt(Ni(i+1))-cM(i+1));
    patch([xx fliplr(xx) xx(1)], [yy1 fliplr(yy2) yy1(1)],  cm(ceil(i/Nd),:),'edgecolor','none');
end;
% draw edges
for i = 1:numel(cM(:))-1
    yy1 = cM(i)+yy*(cMt(Ni(i+1)-1)-cM(i));
    yy2 = cM(i+1)+yy*(cMt(Ni(i+1))-cM(i+1));
    % where appropriate
    if abs(yy1(1)-yy2(1))<0.01 && abs(yy1(end)-yy2(end))<0.01
        continue;
    end;
    h = plot(xx,yy1,'k','linewidth',0.5);
    plot(xx,yy2,'k','linewidth',0.5);
end;
hold off;
set(gca,'ytick',t1,'yticklabel',catlabels);
if scaleDiag 
    l1 = M1f;
    l2 = M2f;
else       % in special case of zero, sum only off diagonal elements for labels
    l1 = M1;        
    l2 = M2;
end;
for i = 1:numel(t1)
    text(0.125,t1(i),num2str(l1(i),'%.0f'), 'color', 0.75*([1 1 1] - cm(i,:)), ...
        'horizontalalignment','left','fontsize',8);
end;
for i = 1:numel(t2)
    text(4.875,t2(i),num2str(l2(i),'%.0f'), 'color', 0.75*([1 1 1] - cm(i,:)), ...
        'horizontalalignment','right','fontsize',8);
end;
return;
