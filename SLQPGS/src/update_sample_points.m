function z = update_sample_points(q,z)

% function z = update_sample_points(q,z)
%
% Author       : Frank E. Curtis
% Description  : Updates sample points uniformly distributed over the
%                neighborhood {x : ||x-x_k||_inf <= epsilon}.
% Input        : q ~ quantities
%                z ~ iterate
% Output       : z ~ updated iterate
% Last revised : 28 October 2009

% Initialize x
z.x(:,2:q.p*(q.vfn+q.vcn)+1) = zeros(q.n,q.p*(q.vfn+q.vcn));

% Initialize u
z.u = zeros(q.n,q.p*(q.vfn+q.vcn)+1);

% Sample points randomly
for j = 1:q.p*(q.vfn+q.vcn)

  % Set random vector
  z.u(:,j+1) = 2*z.epsilon*rand(q.n,1)-z.epsilon;
  
  % Add to x
  z.x(:,j+1) = z.x(:,1) + z.u(:,j+1);

end