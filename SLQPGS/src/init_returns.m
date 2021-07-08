function r = init_returns(o,p,q,z)

% function r = init_returns(o,p,q,z)
%
% Author       : Frank E. Curtis
% Description  : Initializes return values including termination message
%                and sequences of objective values, infeasibility measures,
%                and iterates.
% Input        : o ~ output values
%                p ~ parameters
%                q ~ quantities
%                z ~ iterate
% Output       : r ~ return values
% Last revised : 28 October 2009

% Initialize termination message
r.msg = '---';

% Initialize return values
if o.verbosity <= 1

  % Set objective
  r.f = z.f;

  % Set infeasibility measure
  r.v = z.v;

  % Initialize iterate sequence
  r.x = z.x(:,1);

else
  
  % Initialize objective sequence
  r.f = zeros(1,p.k_max+1); r.f(1) = z.f;

  % Initialize infeasibility measure sequence
  r.v = zeros(1,p.k_max+1); r.v(1) = z.v;

  % Initialize iterate sequence
  r.x = zeros(q.n,p.k_max+1); r.x(:,1) = z.x(:,1);

end