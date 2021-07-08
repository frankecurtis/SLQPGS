function d = init_multipliers(q,z)

% function d = init_multipliers(q,z)
%
% Author       : Frank E. Curtis
% Description  : Initializes Lagrange multipliers.
% Input        : q ~ quantities
%                z ~ iterate
% Output       : d ~ direction
% Last revised : 1 February 2011

% Initialize gradient multipliers
d.m = zeros(1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI),1);

% Set multiplier for gradient at current point to penalty parameter
d.m(1) = z.rho;

% Set multipliers for equality constraint gradients at current point
for j = 1:q.nE
  
  % Check sign of constraint
  if z.cE(j) > 0
    
    % Set multiplier
    d.m(1+q.pO+1) = 1;
    
  elseif z.cE(j) < 0
    
    % Set multiplier
    d.m(1+q.pO+q.nE+sum(q.pE)+1) = -1;
    
  end
  
end

% Set multipliers for inequality constraint gradients at current point
for j = 1:q.nI
  
  % Check sign of constraint
  if z.cI(j) > 0
    
    % Set multiplier
    d.m(1+q.pO+2*(q.nE+sum(q.pE))+1) = 1;
    
  end
  
end