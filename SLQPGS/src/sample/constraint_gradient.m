function J = constraint_gradient(i,j,x)

% function J = constraint_gradient(i,j,x)
%
% Author       : Frank E. Curtis
% Description  : Evaluates gradient of jth constraint.
% Input        : i ~ input
%                j ~ constraint number
%                x ~ point
% Output       : J ~ constraint gradient
% Last revised : 28 October 2009

% Determine max
[val,ind] = max(i.vector.*x);

% Initialize gradient
J = zeros(1,length(x));

% Set nonzero element
J(ind) = i.vector(ind);