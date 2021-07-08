function f = objective_value(i,x)

% function f = objective_value(i,x)
%
% Author       : Frank E. Curtis
% Description  : Evaluates objective value.
% Input        : i ~ input
%                x ~ point
% Output       : f ~ objective value
% Last revised : 28 October 2009

% Evaluate nonsmooth Rosenbrock function
f = i.scalar*abs(x(1)^2 - x(2)) + (1 - x(1))^2;