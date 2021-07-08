function [c,a] = run_step_acceptance(i,c,p,q,z,d)

% function [c,a] = run_step_acceptance(i,c,p,q,z,d)
%
% Author       : Frank E. Curtis
% Description  : Runs step acceptance strategy: backtracking or
%                weak Wolfe line search.
% Input        : i ~ inputs
%                c ~ counters
%                p ~ parameters
%                q ~ quantities
%                z ~ iterate
%                d ~ direction
% Output       : c ~ updated counters
%                a ~ acceptance value
% Last revised : 1 February 2011

% Check for negative reduction
if d.q_red <= 0, a = 0; return; end;

% Check line search type
if strcmp(p.ls_type,'btrack')==1

  % Initialize steplength
  a = 1;
  
  % Store current merit and point
  phi = z.phi; x = z.x(:,1);

  % Backtracking line search
  while a > eps

    % Update iterate
    [c,z] = update_iterate(i,c,p,q,z,d,a,0);
  
    % Reset point to current
    z.x(:,1) = x;

    % Check sufficient decrease condition
    if z.phi - phi <= -p.ls_cons1*a*max(d.q_red,0), break; end;
  
    % Decrease steplength coefficient
    a = p.ls_factor*a;
  
  end

else

  % Initialize steplength coefficients
  a_last = 0;
  a      = 1;
  a_max  = p.ls_max;

  % Check for zero step
  if norm(d.x) == 0, return; end;

  % Store current merit function value and point
  phi_0 = z.phi; grad_0 = z.grad; x = z.x(:,1);

  % Set last phi
  phi_last = phi_0;

  % Weak Wolfe Line Search
  while a < (1-eps)*a_max

    % Update iterate
    [c,z] = update_iterate(i,c,p,q,z,d,a,0);
  
    % Reset point to current
    z.x(:,1) = x;
  
    % Set current phi
    phi_curr = z.phi;
  
    % Check sufficient decrease condition
    if phi_curr - phi_0 > p.ls_cons1*a*grad_0'*d.x | (a ~= 1 & phi_curr >= phi_last), a = zoom(i,c,p,q,z,d,x,phi_0,grad_0,a_last,phi_last,a); break; end;
  
    % Check curvature condition
    if z.grad'*d.x >= p.ls_cons2*grad_0'*d.x, break; end;
  
    % Check curvature
    if z.grad'*d.x >= 0, a = zoom(i,c,p,q,z,d,x,phi_0,grad_0,a,z.phi,a_max); break; end;
  
    % Update quantities
    a_last = a; phi_last = phi_curr;

    % Increase steplength
    a = (a+a_max)/2;
  
  end
  
end

% Reset to zero
if a <= eps, a = 0; end;

% Zoom function
function a = zoom(i,c,p,q,z,d,x,phi_0,grad_0,a_lo,phi_lo,a_hi)

% Zoom loop
while abs(a_hi-a_lo) > p.ls_tol

  % Set trial steplength
  a = (a_lo+a_hi)/2;

  % Update iterate
  [c,z] = update_iterate(i,c,p,q,z,d,a,0);

  % Reset point to current
  z.x(:,1) = x;

  % Check sufficient decrease condition
  if z.phi - phi_0 > p.ls_cons1*a*grad_0'*d.x | z.phi >= phi_lo, a_hi = a;
  else
  
    % Check curvature condition
    if z.grad'*d.x >= p.ls_cons2*grad_0'*d.x, break; end;
    
    % Check directional derivative in a
    if (z.grad'*d.x)*(a_hi-a_lo) >= 0, a_hi = a_lo; end;
    
    % Update lower bound
    a_lo = a;
  
  end

end
