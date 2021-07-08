function [c,d] = run_subproblem_solver(c,p,q,z)

% function [c,d] = run_subproblem_solver(c,p,q,z)
%
% Author       : Frank E. Curtis
% Description  : Runs subproblem solver and increments counter.
% Input        : c ~ counters
%                p ~ parameters
%                q ~ quantities
%                z ~ iterate
% Output       : c ~ updated counters
%                d ~ direction
% Last revised : 28 October 2009

% Set linear objective term
g = [sparse(q.n,1); z.rho; ones(q.a-1,1)];

% Run subproblem solver
if strcmp(p.alg,'SQPGS') == 1
  
  % Set Hessian matrix
  H = [z.H sparse(q.n,q.a); sparse(q.a,q.n) sparse(q.a,q.a)];
  
  % Solve quadratic program
  [dir,obj,flag] = feval(p.solver,H,g,q.A,q.b,[],[],q.l,q.u,[],q.options);
  
else
  
  % Set trust region bounds
  q.l(1:q.n) = -sqrt(10)*z.epsilon/sqrt(p.xi_lower);
  q.u(1:q.n) =  sqrt(10)*z.epsilon/sqrt(p.xi_lower);

  % Solver linear program
  [dir,obj,flag] = feval(p.solver,g,q.A,q.b,[],[],q.l,q.u,[],q.options);

end

% Set output
d.x = dir(1:q.n); d.flag = flag;

% Update counters
c.solver = c.solver + 1;