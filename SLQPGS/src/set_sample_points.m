function z = set_sample_points(q,z)

% function z = set_sample_points(q,z)
%
% Author       : Frank E. Curtis
% Description  : Sets sample points uniformly distributed over the
%                neighborhood {x : ||x-x_k||_2 <= epsilon}.
% Input        : q ~ quantities
%                z ~ iterate
% Output       : z ~ updated iterate
% Last revised : 1 February 2011

% Initialize points
z.x(:,2:1+q.pO+sum(q.pE)+sum(q.pI)) = zeros(q.nV,q.pO+sum(q.pE)+sum(q.pI));

% Initialize differences
z.u = zeros(q.nV,1+q.pO+sum(q.pE)+sum(q.pI));

% Loop over number of sample points
for j = 1:q.pO+sum(q.pE)+sum(q.pI)

  % Generate normal deviates
  z.u(:,j+1) = randn(q.nV,1);
  
  % Transform into neighborhood
  z.u(:,j+1) = z.epsilon*rand^(1/q.nV)*z.u(:,j+1)/norm(z.u(:,j+1));

  % Add to set of sample points
  z.x(:,j+1) = z.x(:,1) + z.u(:,j+1);

end