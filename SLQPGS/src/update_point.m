function z = update_point(z,d,a)

% function z = update_point(z,d,a)
%
% Author       : Frank E. Curtis
% Description  : Updates point.
% Input        : z ~ iterate
%                d ~ direction
%                a ~ acceptance value
% Output       : z ~ updated iterate
% Last revised : 28 October 2009

% Update point
z.x(:,1) = z.x(:,1) + a*d.x;