function [q,z] = set_subproblem_data(p,q,z)

% function [q,z] = set_subproblem_data(p,q,z)
%
% Author       : Frank E. Curtis
% Description  : Sets data for the subproblem including linear
%                constraint matrices and right-hand-sides.
% Input        : p ~ parameters
%                q ~ quantities
%                z ~ iterate
% Output       : q ~ updated quantities
%                z ~ updated iterate
% Last revised : 1 February 2011

% Check subproblem problem to solve
if strcmp(p.sp_problem,'primal') == 1

  % Set Hessian (for SQPGS) or trust region (for SLPGS)
  if strcmp(p.algorithm,'SQPGS') == 1
  
    % Set Hessian matrix
    q.H(1:q.nV,1:q.nV) = z.H;
    
  else
  
    % Set trust region bounds
    q.l(1:q.nV) = -z.epsilon/sqrt(p.scale_lower);
    q.u(1:q.nV) =  z.epsilon/sqrt(p.scale_lower);

  end

  % Initialize number of linear constraints
  z.size = 0;

  % Loop through sample points for objective
  for j = 1:1+q.pO

    % Set constraint values for objective for sample point j
    q.AI(j,1:q.nV) =  z.g(:,j)';
    q.bI(j       ) = -z.f;
      
    % Increment linear inequality counter
    z.size = z.size + 1;

  end

  % Loop through equality constraints
  for k = 1:q.nE
  
    % Loop through sample points for equality constraint k
    for j = 1:1+q.pE(k)
  
      % Set constraint values for equality constraint k for sample point j
      q.AI(1+q.pO               +k-1+sum(q.pE(1:k-1))+j,1:q.nV) =  z.JE(k,:,j);
      q.AI(1+q.pO+q.nE+sum(q.pE)+k-1+sum(q.pE(1:k-1))+j,1:q.nV) = -z.JE(k,:,j);
      q.bI(1+q.pO               +k-1+sum(q.pE(1:k-1))+j       ) = -z.cE(k);
      q.bI(1+q.pO+q.nE+sum(q.pE)+k-1+sum(q.pE(1:k-1))+j       ) =  z.cE(k);
      
      % Increment linear inequality counter
      z.size = z.size + 2;

    end

  end

  % Loop through inequality constraints
  for k = 1:q.nI

    % Loop through sample points for inequality constraint k
    for j = 1:1+q.pI(k)
  
      % Set constraint values for inequality constraint k for sample point j
      q.AI(1+q.pO+2*(q.nE+sum(q.pE))+k-1+sum(q.pI(1:k-1))+j,1:q.nV) =  z.JI(k,:,j);
      q.bI(1+q.pO+2*(q.nE+sum(q.pE))+k-1+sum(q.pI(1:k-1))+j       ) = -z.cI(k);
      
      % Increment linear inequality counter
      z.size = z.size + 1;
  
    end

  end

elseif strcmp(p.algorithm,'SQPGS') == 1

  % Set Hessian matrix
  q.H (1:q.nV,1:q.nV) = z.H;
  q.AE(1:q.nV,1:q.nV) = z.H;
  
  % Reset variable upper bounds
  q.u = [ inf*ones(q.nV,1); inf*ones(1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI),1)];

  % Initialize numbers of dual variables
  z.size = 0;

  % Loop through sample points for objective
  for j = 1:1+q.pO

    % Set constraint and linear objective term values for objective for sample point j
    q.AE(1:q.nV,q.nV+j) =  z.g(:,j);
    q.g (       q.nV+j) = -z.f;
      
    % Increment dual variable of inequality constraint counter
    z.size = z.size + 1;
  
  end

  % Loop through equality constraints
  for k = 1:q.nE
  
    % Loop through sample points for equality constraint k
    for j = 1:1+q.pE(k)
  
      % Set constraint and linear objective term values for equality constraint k for sample point j
      q.AE(1:q.nV,q.nV+1+q.pO               +k-1+sum(q.pE(1:k-1))+j) =  z.JE(k,:,j)';
      q.AE(1:q.nV,q.nV+1+q.pO+q.nE+sum(q.pE)+k-1+sum(q.pE(1:k-1))+j) = -z.JE(k,:,j)';
      q.g (       q.nV+1+q.pO               +k-1+sum(q.pE(1:k-1))+j) = -z.cE(k);
      q.g (       q.nV+1+q.pO+q.nE+sum(q.pE)+k-1+sum(q.pE(1:k-1))+j) =  z.cE(k);
      
      % Increment dual variable of equality constraint counter
      z.size = z.size + 2;
  
    end

  end

  % Loop through inequality constraints
  for k = 1:q.nI

    % Loop through sample points for inequality constraint k
    for j = 1:1+q.pI(k)
  
      % Set constraint and linear objective term values for inequality constraint k for sample point j
      q.AE(1:q.nV,q.nV+1+q.pO+2*(q.nE+sum(q.pE))+k-1+sum(q.pI(1:k-1))+j) =  z.JI(k,:,j)';
      q.g (       q.nV+1+q.pO+2*(q.nE+sum(q.pE))+k-1+sum(q.pI(1:k-1))+j) = -z.cI(k);
      
      % Increment dual variable of inequality constraint counter
      z.size = z.size + 1;
  
    end

  end

else

  % Set linear objective terms for primal bounds
  q.g(1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI)     +1:1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI)+q.nV     ) = z.epsilon/sqrt(p.scale_lower);
  q.g(1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI)+q.nV+1:1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI)+q.nV+q.nV) = z.epsilon/sqrt(p.scale_lower);

  % Reset variable upper bounds
  q.u = [inf*ones(1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI)+2*q.nV,1)];

  % Initialize numbers of dual variables
  z.size = 0;

  % Loop through sample points for objective
  for j = 1:1+q.pO

    % Set constraint and linear objective term values for objective for sample point j
    q.AE(1:q.nV,j) =  z.g(:,j);
    q.g (       j) = -z.f;
      
    % Increment dual variable of inequality constraint counter
    z.size = z.size + 1;
  
  end

  % Loop through equality constraints
  for k = 1:q.nE
  
    % Loop through sample points for equality constraint k
    for j = 1:1+q.pE(k)
  
      % Set constraint and linear objective term values for equality constraint k for sample point j
      q.AE(1:q.nV,1+q.pO               +k-1+sum(q.pE(1:k-1))+j) =  z.JE(k,:,j)';
      q.AE(1:q.nV,1+q.pO+q.nE+sum(q.pE)+k-1+sum(q.pE(1:k-1))+j) = -z.JE(k,:,j)';
      q.g (       1+q.pO               +k-1+sum(q.pE(1:k-1))+j) = -z.cE(k);
      q.g (       1+q.pO+q.nE+sum(q.pE)+k-1+sum(q.pE(1:k-1))+j) =  z.cE(k);
      
      % Increment dual variable of equality constraint counter
      z.size = z.size + 2;
  
    end

  end

  % Loop through inequality constraints
  for k = 1:q.nI

    % Loop through sample points for inequality constraint k
    for j = 1:1+q.pI(k)
  
      % Set constraint and linear objective term values for inequality constraint k for sample point j
      q.AE(1:q.nV,1+q.pO+2*(q.nE+sum(q.pE))+k-1+sum(q.pI(1:k-1))+j) =  z.JI(k,:,j)';
      q.g (       1+q.pO+2*(q.nE+sum(q.pE))+k-1+sum(q.pI(1:k-1))+j) = -z.cI(k);
      
      % Increment dual variable of inequality constraint counter
      z.size = z.size + 1;
  
    end

  end

end