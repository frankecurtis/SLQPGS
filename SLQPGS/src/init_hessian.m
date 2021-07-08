function z = init_hessian(p,q,z)

% function z = init_hessian(p,q,z)
%
% Author       : Frank E. Curtis
% Description  : Initializes BFGS approximation to Hessian of Lagrangian.
% Input        : p ~ parameters
%                q ~ quantities
%                z ~ iterate
% Output       : z ~ updated iterate
% Last revised : 1 February 2011

% Check algorithm
if strcmp(p.algorithm,'SQPGS') == 1

  % Initialize gradient multipliers
  d = init_multipliers(q,z);

  % Evaluate Lagrangian gradient
  z = eval_lagrangian_gradient(q,z,d);
  
  % Initialize ``last'' point
  z.x_last = z.x(:,1);
  
  % Initialize ``last'' gradient
  z.grad_last = z.grad;
  
  % Initialize Hessian matrix
  z.H = max(1,norm(z.grad))*speye(q.nV);
  
end