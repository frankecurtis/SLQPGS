function z = eval_merit(z)

% function z = eval_merit(z)
%
% Author       : Frank E. Curtis
% Description  : Evaluates merit function.
% Input        : z ~ iterate
% Output       : z ~ updated iterate
% Last revised : 1 February 2011

% Evaluate merit function
z.phi = z.rho*z.f + z.v;
