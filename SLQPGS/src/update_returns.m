function r = update_returns(o,c,p,z,r)

% function r = update_returns(o,c,p,z,r)
%
% Author       : Frank E. Curtis
% Description  : Updates return values.
% Input        : o ~ output values
%                c ~ counters
%                p ~ parameters
%                z ~ iterate
%                r ~ return values
% Output       : r ~ updated return values
% Last revised : 28 October 2009

% Check for maximum iterations
if c.k >= p.k_max, r.msg = 'itr'; end;

% Check for optimality and feasibility
if z.epsilon/p.epsilon_factor < p.opt_tol & z.v < p.inf_tol, r.msg = 'opt'; end;

% Initialize return values
if o.verbosity <= 1

  % Update objective
  r.f = z.f;

  % Update infeasibility measure
  r.v = z.v;

  % Update iterate
  r.x = z.x(:,1);

else

  % Update objective sequence
  r.f(c.k+1) = z.f;

  % Update infeasibility measure sequence
  r.v(c.k+1) = z.v;

  % Update iterate sequence
  r.x(:,c.k+1) = z.x(:,1);

end