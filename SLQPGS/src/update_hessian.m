function z = update_hessian(p,q,z)

% function z = update_hessian(p,q,z)
%
% Author       : Frank E. Curtis
% Description  : Updates BFGS approximation of Hessian matrix.
% Input        : p ~ parameters
%                q ~ quantities
%                z ~ iterate
% Output       : z ~ updated iterate
% Last revised : 28 October 2009

% Set step
s = z.x(:,1) - z.x_last;

% Set change in merit gradient
y = z.grad - z.grad_last;

% Check for zero step
if norm(s) == 0 | sum(isnan(s)) > 0 | sum(isinf(s)) > 0 | sum(isnan(y)) > 0 | sum(isinf(y)), return; end;

% Compute products
sy = s'*y; Hs = z.H*s; sHs = s'*Hs;

% Check for small inner products
if min(abs([sy sHs sHs-sy])) <= p.bfgs_tol, return; end;

% Set theta
if sy >= p.damp*sHs, theta = 1; else theta = (1-p.damp)*sHs/(sHs-sy); end;

% Set r
r = theta*y + (1-theta)*Hs;

% Update Hessian matrix
z.H = z.H - (Hs*Hs')/sHs + (r*r')/(theta*sy + (1-theta)*sHs);

% Compute minimum eigenvalue of H
l1 = eigs(z.H,1,'SM',q.eigs_options);

% Compute Hessian modification constant
alpha1 = 1; if l1 < p.xi_lower, alpha1 = min(max((p.xi_lower - 1)/(l1 - 1),0),1); end;

% Update Hessian
z.H = alpha1*z.H + (1-alpha1)*eye(q.n);

% Compute maximum eigenvalue of H
ln = eigs(z.H,1,'LM',q.eigs_options);

% Compute Hessian modification constant
alphan = 1; if ln > p.xi_upper, alphan = min(max((p.xi_upper - 1)/(ln - 1),0),1); end;

% Update Hessian
z.H = alphan*z.H + (1-alphan)*eye(q.n);