function JI = inequality_constraint_gradient(i,j,x)

% function JI = inequality_constraint_gradient(i,j,x)
%
% Author       : Frank E. Curtis
% Description  : Evaluates gradient of jth constraint.
% Input        : i ~ input (expected argument, even if not needed)
%                j ~ constraint number (expected argument, even if only one constraint)
%                x ~ point
% Output       : J ~ jth inequality constraint gradient
% Last revised : 1 February 2011

% Evaluate constraint gradient
if sqrt(2)*x(1) >= 2*x(2), JI = [sqrt(2) 0]; else JI = [0 2]; end