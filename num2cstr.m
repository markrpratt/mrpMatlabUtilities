function nstr = num2cstr(n,ndec)
%% nstr = num2commastr(n,dec)
% insert commas into number format
% n - number to be converted
% ndec - places past the decimal (default = 0)
if nargin < 2
    ndec = 0;
end;
if ndec == 0
    i = round(n,0);
else
    i = floor(n);
    f = n-i;
end;
nstr = sprintf(',%c%c%c',fliplr(num2str(i)));
nstr = fliplr(nstr(2:end));
if ndec>0
    fstr = sprintf('%.*f',ndec, f);
    nstr = [nstr fstr(2:end)];
end;
return
