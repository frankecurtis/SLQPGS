function z = update_point(z,d,a)

% function z = update_point(z,d,a)
%
% Author       : Frank E. Curtis
% Description  : Updates primal point.
% Input        : z ~ iterate
%                d ~ direction
%                a ~ acceptance value
% Output       : z ~ updated iterate
% Last revised : 1 February 2011

% Update point
z.x(:,1) = z.x(:,1) + a*d.x;
