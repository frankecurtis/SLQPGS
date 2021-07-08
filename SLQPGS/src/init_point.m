function z = init_point(i,q)

% function z = init_point(i,q)
%
% Author       : Frank E. Curtis
% Description  : Initializes point.  If the initial point was not set
%                in inputs, then the origin is used by default.
% Input        : i ~ inputs
%                q ~ quantities
% Output       : z ~ iterate
% Last revised : 1 February 2011

% Check for input initial point
if isfield(i,'x')
  
  % Assert that appropriate starting point has been specified
  assert(isvector(i.x) & length(i.x) == i.nV & size(i.x,1) >= size(i.x,2),'SLQP-GS: Initial point, i.x, must be a column n-vector.');
  
  % Set initial point to input
  z.x = i.x;
  
else
  
  % Set initial point to origin
  z.x = zeros(q.nV,1); end;

end