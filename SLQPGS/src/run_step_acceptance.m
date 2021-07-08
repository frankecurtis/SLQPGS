function [c,a] = run_step_acceptance(i,c,p,q,z,d)

% function [c,a] = run_step_acceptance(i,c,p,q,z,d)
%
% Author       : Frank E. Curtis
% Description  : Runs step acceptance strategy, a backtracking line search
%                with an Armijo-like sufficient decrease condition.
% Input        : i ~ input values
%                c ~ counters
%                p ~ parameters
%                q ~ quantities
%                z ~ iterate
%                d ~ direction
% Output       : c ~ updated counters
%                a ~ acceptance value
% Last revised : 28 October 2009

% Initialize steplength coefficient
a = 1;

% Check for zero step
if norm(d.x) == 0, return; end;

% Store current merit function value and point
phi = z.phi; x = z.x(:,1);

% Backtracking line search
while a > eps

  % Update iterate
  [c,z] = update_iterate(i,c,p,q,z,d,a,0);
  
  % Reset point to current
  z.x(:,1) = x;

  % Check sufficient decrease condition
  if z.phi - phi <= -p.eta*a*d.m_red, break; end;
  
  % Decrement steplength coefficient
  a = a/2;
  
end

% Reset to zero
if a < eps, a = 0; end;