function [c,z] = eval_gradients(i,c,q,z)

% function [c,z] = eval_gradients(i,c,q,z)
%
% Author       : Frank E. Curtis
% Description  : Evaluates objective and constraint gradients at current
%                point; increments gradient evaluation counter.
% Input        : i ~ input values
%                c ~ counters
%                q ~ quantities
%                z ~ iterate
% Output       : c ~ updated counters
%                z ~ updated iterate
% Last revised : 28 October 2009

% Loop through sample points for objective
for j = 1:1+q.p*(1-q.vf)

  % Compute objective gradient
  z.g(:,j) = feval(i.g,i,z.x(:,j));

end

% Set sample point place marker
mark = 1+q.p*(1-q.vf);

% Loop through constraints
for k = 1:q.m

  % Loop through sample points for constraint
  for j = 1:1+q.p*(1-q.vc(k))

    % Compute constraint gradient
    if j == 1, z.J(k,:,j) = feval(i.J,i,k,z.x(:,1));
    else,      z.J(k,:,j) = feval(i.J,i,k,z.x(:,mark+j-1)); end;

  end

  % Increment sample point place marker
  mark = mark + q.p*(1-q.vc(k));

end

% Update counter
c.g = c.g + 1;