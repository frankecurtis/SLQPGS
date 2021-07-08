function c = constraint_value(i,x)

% function c = constraint_value(i,x)
%
% Author       : Frank E. Curtis
% Description  : Evaluates constraint value.
% Input        : i ~ input
%                x ~ point
% Output       : c ~ constraint value
% Last revised : 28 October 2009

% Evaluate constraint
c = -1 + max(i.vector.*x);