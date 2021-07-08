function g = objective_gradient(i,x)

% function g = objective_gradient(i,x)
%
% Author       : Frank E. Curtis
% Description  : Evaluates objective gradient.
% Input        : i ~ input
%                x ~ point
% Output       : g ~ objective gradient
% Last revised : 28 October 2009

% Evaluate nonsmooth Rosenbrock gradient
if x(1)^2 - x(2) >= 0
  g = i.scalar*[ 2*x(1);-1] + [-2*(1-x(1));0];
else
  g = i.scalar*[-2*x(1); 1] + [-2*(1-x(1));0];
end