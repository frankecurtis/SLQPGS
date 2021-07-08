function z = eval_infeasibility(q,z)

% function z = eval_infeasibility(q,z)
%
% Author       : Frank E. Curtis
% Description  : Evaluates infeasibility measure.
% Input        : q ~ quantities
%                z ~ iterate
% Output       : z ~ updated iterate
% Last revised : 1 February 2011

% Initialize constraint vector
vec = [];

% Update constraint vector for equality constraints
if q.nE > 0, vec = [vec; z.cE]; end;

% Update constraint vector for inequality constraints
if q.nI > 0, vec = [vec; max(z.cI,0)]; end;

% Evaluate infeasibility
z.v = norm(vec,1);
