function g = objective_gradient(i,x)

% function g = objective_gradient(i,x)
%
% Author       : Frank E. Curtis
% Description  : Evaluates objective gradient.
% Input        : i ~ input
%                x ~ point
% Output       : g ~ objective gradient
% Last revised : 8 July 2010

% Initialize objective gradient
g = [-2*(1-x(1)); 0];

% Update objective gradient
if x(1)^2 - x(2) >= 0
  g = g + 8*[ 2*x(1); -1];
else
  g = g + 8*[-2*x(1);  1];
end
