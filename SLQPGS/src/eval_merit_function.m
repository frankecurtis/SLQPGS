function z = eval_merit_function(z)

% function z = eval_merit_function(z)
%
% Author       : Frank E. Curtis
% Description  : Evaluates merit function.
% Input        : z ~ iterate
% Output       : z ~ updated iterate
% Last revised : 28 October 2009

% Evaluate merit function
z.phi = z.rho*z.f + z.v;