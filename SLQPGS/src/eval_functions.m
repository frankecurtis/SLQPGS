function [c,z] = eval_functions(i,c,z)

% function [c,z] = eval_functions(i,c,z)
%
% Author       : Frank E. Curtis
% Description  : Evaluates objective and constraint functions at current
%                point; increments function evaluation counter.
% Input        : i ~ input values
%                c ~ counters
%                z ~ iterate
% Output       : c ~ updated counters
%                z ~ updated iterate
% Last revised : 28 October 2009

% Compute objective value
z.f = feval(i.f,i,z.x(:,1));

% Compute constraint value
z.c = feval(i.c,i,z.x(:,1));

% Update counters
c.f = c.f + 1;