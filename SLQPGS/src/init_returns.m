function r = init_returns(o,p,q,z)

% function r = init_returns(o,p,q,z)
%
% Author       : Frank E. Curtis
% Description  : Initializes return values including termination message,
%                objective values, infeasibility measures, and iterates.
% Input        : o ~ output data
%                p ~ parameters
%                q ~ quantities
%                z ~ iterate
% Output       : r ~ returns
% Last revised : 1 February 2011

% Initialize termination message
r.msg = '---';

% Initialize return values
if o.verbosity <= 1

  % Set objective
  r.f = z.f;

  % Set infeasibility measure
  r.v = z.v;

  % Set iterate
  r.x = z.x(:,1);

else

  % Initialize objective sequence
  r.f = zeros(1,p.itr_max+1); r.f(1) = z.f;

  % Initialize infeasibility measure sequence
  r.v = zeros(1,p.itr_max+1); r.v(1) = z.v;

  % Initialize iterate sequence
  r.x = zeros(q.nV,p.itr_max+1); r.x(:,1) = z.x(:,1);

end
