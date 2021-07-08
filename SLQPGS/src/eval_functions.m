function [c,z] = eval_functions(i,c,z)

% function [c,z] = eval_functions(i,c,z)
%
% Author       : Frank E. Curtis
% Description  : Evaluates objective and constraint functions at current
%                point; increments function evaluation counter.
% Input        : i ~ inputs
%                c ~ counters
%                z ~ iterate
% Output       : c ~ updated counters
%                z ~ updated iterate
% Last revised : 1 February 2011

% Evaluate objective value
z.f = feval(i.f,i,z.x(:,1));

% Evaluate constraint values
if i.nE > 0, z.cE = feval(i.cE,i,z.x(:,1)); end;
if i.nI > 0, z.cI = feval(i.cI,i,z.x(:,1)); end;

% Increment function evaluation counter
c.f = c.f + 1;
