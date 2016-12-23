function y = sigmf(x,a,c)
% see fuzzy logic toolbox help for definitions
y = (1+exp(-a*(x-c))).^-1;
