function z = eval_merit_gradient(q,z)

% function z = eval_merit_gradient(q,z)
%
% Author       : Frank E. Curtis
% Description  : Evaluates merit gradient.
% Input        : q ~ quantities
%                z ~ iterate
% Output       : z ~ updated iterate
% Last revised : 28 October 2009

% Initialize with objective gradient
z.grad = z.rho*z.g(:,1);

% Update with constraint gradients
for j = 1:q.m, if z.c(j) > 0, z.grad = z.grad + z.J(j,:,1)'; end; end;