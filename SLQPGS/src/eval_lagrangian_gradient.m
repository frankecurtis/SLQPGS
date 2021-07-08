function z = eval_lagrangian_gradient(q,z,d)

% function z = eval_lagrangian_gradient(q,z,d)
%
% Author       : Frank E. Curtis
% Description  : Evaluates Lagrangian gradient.
% Input        : q ~ quantities
%                z ~ iterate
%                d ~ direction
% Output       : z ~ updated iterate
% Last revised : 1 February 2011

% Initialize gradient to convex combination of objective gradients
z.grad = z.g*d.m(1:1+q.pO);

% Loop through equality constraints
for k = 1:q.nE
  
  % Loop through sample points for equality constraint k
  for j = 1:1+q.pE(k)
    
    % Update gradient for equality constraint gradients
    z.grad = z.grad + z.JE(k,:,j)'*d.m(1+q.pO               +k-1+sum(q.pE(1:k-1))+j);
    z.grad = z.grad - z.JE(k,:,j)'*d.m(1+q.pO+q.nE+sum(q.pE)+k-1+sum(q.pE(1:k-1))+j);
    
  end
  
end

% Loop through inequality constraints
for k = 1:q.nI
  
  % Loop throught sample points for inequality constraint k
  for j = 1:1+q.pI(k)
    
    % Update gradient for inequality constraint gradients
    z.grad = z.grad + z.JI(k,:,j)'*d.m(1+q.pO+2*(q.nE+sum(q.pE))+k-1+sum(q.pI(1:k-1))+j);
    
  end
  
end