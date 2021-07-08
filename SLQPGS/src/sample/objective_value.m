function f = objective_value(i,x)

% function f = objective_value(i,x)
%
% Author       : Frank E. Curtis
% Description  : Evaluates objective value.
% Input        : i ~ input (expected argument, even if not needed)
%                x ~ point
% Output       : f ~ objective value
% Last revised : 1 February 2011

% Evaluate objective
f = 8*abs(x(1)^2 - x(2)) + (1 - x(1))^2;
