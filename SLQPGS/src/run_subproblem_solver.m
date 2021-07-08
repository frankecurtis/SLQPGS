function [c,d] = run_subproblem_solver(c,p,q)

% function [c,d] = run_subproblem_solver(c,p,q)
%
% Author       : Frank E. Curtis
% Description  : Runs subproblem solver and increments counter.
% Input        : c ~ counters
%                p ~ parameters
%                q ~ quantities
% Output       : c ~ updated counters
%                d ~ direction
% Last revised : 1 February 2011

% Check algorithm
if strcmp(p.algorithm,'SQPGS') == 1
    
  % Solve quadratic program
  [primals,~,flag,~,duals] = feval(p.sp_solver,q.H,q.g,q.AI,q.bI,q.AE,q.bE,q.l,q.u,[],p.sp_options);
    
else
  
  % Solve linear program
  [primals,~,flag,~,duals] = feval(p.sp_solver,q.g,q.AI,q.bI,q.AE,q.bE,q.l,q.u,[],p.sp_options);
  
end

% Check subproblem type
if strcmp(p.sp_problem,'primal') == 1

  % Set primal step
  d.x = primals(1:q.nV);

  % Set gradient multipliers
  d.m = duals.ineqlin;

elseif strcmp(p.algorithm,'SQPGS') == 1

  % Set primal step
  d.x = primals(1:q.nV);

  % Set gradient multipliers
  d.m = primals(q.nV+1:q.nV+1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI));

else

  % Set primal step
  d.x = -duals.eqlin(1:q.nV);

  % Set gradient multipliers
  d.m = primals(1:1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI));
  
end

% Set flag
d.flag = flag;

% Increment subproblem solver counter
c.s = c.s + 1;
