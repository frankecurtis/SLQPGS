function b = run_steering_check(p,z,d0,d,rho)

% function b = run_steering_check(p,z,d0,d,rho)
%
% Author       : Frank E. Curtis
% Description  : Runs check for steering rules.
% Input        : p   ~ parameters
%                z   ~ iterate
%                d0  ~ feasibility step
%                d   ~ primal step
%                rho ~ initial penalty parameter
% Output       : b   ~ 1 if not done;
%                      0 otherwise
% Last revised : 1 February 2011

% Initialize boolean variable
b = 0;

% Check for max decrease
if z.rho < (p.rho_factor^p.steering_max)*rho, return; end;

% Check for linearized feasibility reduction
b = max(b,(d.l_red/max(z.v0,1) < p.steering_cons1*d0.l_red/max(z.v0,1)));

% Check for merit model reduction
if strcmp(p.algorithm,'SQPGS') == 1, b = max(b,(d.q_red/max(z.v0,1) < p.steering_cons2*d0.l_red/max(z.v0,1))); end;
