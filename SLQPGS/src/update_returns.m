function r = update_returns(o,c,p,z,r)

% function r = update_returns(o,c,p,z,r)
%
% Author       : Frank E. Curtis
% Description  : Updates return values.
% Input        : o ~ output data
%                c ~ counters
%                p ~ parameters
%                z ~ iterate
%                r ~ returns
% Output       : r ~ updated returns
% Last revised : 1 February 2011

% Check for maximum iterations
if c.k >= p.itr_max, r.msg = 'itr'; end;

% Check for optimality and feasibility
if z.epsilon/p.epsilon_factor <= p.opt_tol & z.v/max(z.v0,1) <= p.inf_tol, r.msg = 'opt'; end;

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

% Check for termination
if strcmp(r.msg,'---') ~= 1 & o.verbosity > 1
  
  % Truncate objective sequence
  r.f = r.f(1:c.k+1);
  
  % Truncate infeasibility measure sequence
  r.v = r.v(1:c.k+1);
  
  % Truncate iterate sequence
  r.x = r.x(:,1:c.k+1);
  
end