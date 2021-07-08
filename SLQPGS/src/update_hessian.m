function z = update_hessian(p,q,z,d)

% function z = update_hessian(p,q,z,d)
%
% Author       : Frank E. Curtis
% Description  : Updates BFGS approximation of Hessian of Lagrangian.
% Input        : p ~ parameters
%                q ~ quantities
%                z ~ iterate
%                d ~ direction
% Output       : z ~ updated iterate
% Last revised : 1 February 2011

% Check algorithm
if strcmp(p.algorithm,'SQPGS') == 0, return; end;

% Set step
s = z.x(:,1) - z.x_last;

% Update ``last'' iterate
z.x_last = z.x(:,1);

% Evaluate gradient of Lagrangian
z = eval_lagrangian_gradient(q,z,d);

% Set change in gradient
y = z.grad - z.grad_last;

% Update ``last'' gradient
z.grad_last = z.grad;

% Check for zero step
if norm(s) == 0 | sum(isnan(s)) > 0 | sum(isinf(s)) > 0 | sum(isnan(y)) > 0 | sum(isinf(y)), return; end;

% Compute products
sy = s'*y; Hs = z.H*s; sHs = s'*Hs;

% Check for small inner products
if min(abs([sy sHs sHs-sy])) <= p.bfgs_tol, return; end;

% Set theta
if sy >= p.bfgs_damp*sHs, theta = 1; else theta = (1-p.bfgs_damp)*sHs/(sHs-sy); end;

% Set r
r = theta*y + (1-theta)*Hs;

% Update Hessian matrix
z.H = z.H - (Hs*Hs')/sHs + (r*r')/(theta*sy + (1-theta)*sHs);

% Compute eigenvalues of H
l = eig(z.H);

% Compute Hessian modification constant
alpha1 = 1; if min(l) < p.scale_lower, alpha1 = min(max((p.scale_lower - 1)/(min(l) - 1),0),1); end;

% Update Hessian approximation
z.H = alpha1*z.H + (1-alpha1)*speye(q.nV);

% Compute Hessian modification constant
alphan = 1; if max(l) > p.scale_upper, alphan = min(max((p.scale_upper - 1)/(max(l) - 1),0),1); end;

% Update Hessian approximation
z.H = alphan*z.H + (1-alphan)*speye(q.nV);