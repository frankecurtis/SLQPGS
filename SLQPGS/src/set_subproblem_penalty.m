function q = set_subproblem_penalty(p,q,z)

% function q = set_subproblem_penalty(p,q,z)
%
% Author       : Frank E. Curtis
% Description  : Sets penalty parameter for subproblem.
% Input        : p ~ parameters
%                q ~ quantities
%                z ~ iterate
% Output       : q ~ updated quantities
% Last revised : 1 February 2011

% Check subproblem problem to solve
if strcmp(p.sp_problem,'primal') == 1

  % Set subproblem penalty parameter
  q.g(q.nV+1) = z.rho;

else

  % Set subproblem penalty parameter
  q.bE(q.nV+1) = z.rho;

end
