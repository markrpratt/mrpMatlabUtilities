function ymodel = evalCentered2DGaussian(x, xdata)
%% for lsqcurvefit
% ymodel = eval2DGaussian(x, xdata)
% x = [Amplitude Sigma1 Sigma2 Theta0]
% xdata = [R Theta]
% 
% formulation from: https://en.wikipedia.org/wiki/Gaussian_function
% disp(x);
ymodel = x(1)*exp(-(xdata(:,1).^2 .* ( ...
    (cos(xdata(:,2)-x(4)).^2/(2*x(2))^2) + ...
    (sin(xdata(:,2)-x(4)).^2/(2*x(3))^2))));
return; 