function cI = inequality_constraint_value(i,x)

% function cI = inequality_constraint_value(i,x)
%
% Author       : Frank E. Curtis
% Description  : Evaluates constraint value.
% Input        : i  ~ input (expected argument, even if not needed)
%                x  ~ point
% Output       : cI ~ inequality constraint value
% Last revised : 1 February 2011

% Evaluate constraint value
cI = max(sqrt(2)*x(1),2*x(2)) - 1;
