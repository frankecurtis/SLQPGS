function z = update_bfgs_quantities(z)

% function z = update_bfgs_quantities(z)
%
% Author       : Frank E. Curtis
% Description  : Updates quantities for BFGS update of Hessian.
% Input        : z ~ iterate
% Output       : z ~ updated iterate
% Last revised : 28 October 2009

% Store last point
z.x_last = z.x(:,1);

% Store last merit gradient
z.grad_last = z.grad;