function z = init_hessian(i,q,z)

% function z = init_hessian(i,q,z)
%
% Author       : Frank E. Curtis
% Description  : Initializes Hessian matrix.
% Input        : i ~ input values
%                q ~ quantities
%                z ~ iterate
% Output       : z ~ updated iterate
% Last revised : 28 October 2009

% Initialize Hessian matrix (default: max(1,||merit gradient||)*I)
if isfield(i,'H'), z.H = i.H; else z.H = max(1,norm(z.grad))*eye(q.n); end;