function errCounts = tabulateErrorMode(vTest, vTruth, vSubset)
%% errCounts = tabulateErrorMode(vTest, vGT, vSubset)
%  returns number of [TP TN FP FN] in vector vTest as graded by vGT
%  if optional vSubset logical vector is included, will use to restrict
if nargin < 3
    errCounts = sum([ ...
        vTest==vTruth & vTruth>0 ...
        vTest==vTruth & ~vTruth ...
        vTest~=vTruth & ~vTruth ...
        vTest~=vTruth & vTruth>0 ...
        ]);
else
    errCounts = sum([ ...
        vTest==vTruth & vTruth>0 & vSubset>0 ...
        vTest==vTruth & ~vTruth & vSubset>0  ...
        vTest~=vTruth & ~vTruth & vSubset>0  ...
        vTest~=vTruth & vTruth>0 & vSubset>0 ...
        ]);

return;
end

