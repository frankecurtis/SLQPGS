function z = eval_infeasibility(z)

% function z = eval_infeasibility(z)
%
% Author       : Frank E. Curtis
% Description  : Evaluates infeasibility measure.
% Input        : z ~ iterate
% Output       : z ~ updated iterate
% Last revised : 28 October 2009

% Evaluate infeasibility
z.v = norm(max(z.c,0),1);