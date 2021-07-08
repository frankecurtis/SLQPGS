function z = init_point(i,q)

% function z = init_point(i,q)
%
% Author       : Frank E. Curtis
% Description  : Initializes point.  If the initial point not set
%                manually, then the origin is used by default.
% Input        : i ~ input values
%                q ~ quantities
% Output       : z ~ iterate
% Last revised : 28 October 2009

% Set initial point (default: zero vector)
if isfield(i,'x'), z.x = i.x; else z.x = zeros(q.n,1); end;