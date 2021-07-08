function q = init_quantities(i,p)

% function q = init_quantities(i,p)
%
% Author       : Frank E. Curtis
% Description  : Initializes quantities for subproblem.
% Input        : i ~ inputs
%                p ~ parameters
% Output       : q ~ quantities
% Last revised : 1 February 2011

% Set problem size quantities
q.nV = i.nV; q.pO = i.pO; q.nE = i.nE; q.pE = i.pE; q.nI = i.nI; q.pI = i.pI;

% Check subproblem problem to solve
if strcmp(p.sp_problem,'primal') == 1

  % Initialize Hessian
  if strcmp(p.algorithm,'SQPGS') == 1, q.H = sparse(q.nV+1+q.nE+q.nI,q.nV+1+q.nE+q.nI); end;
  
  % Initialize linear objective term
  q.g = [sparse(q.nV+1,1); ones(q.nE+q.nI,1)];

  % Initialize subproblem equality constraint matrix
  q.AE = [];

  % Initialize subproblem inequality constraint matrix
  q.AI = sparse(1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI),q.nV+1+q.nE+q.nI);

  % Initialize row counters and column counter
  row = 1; col = q.nV+1;

  % Place auxiliary variable coefficients for objective
  q.AI(row:row+q.pO,col) = -ones(1+q.pO,1);
  
  % Increment row and column counters
  row = row + q.pO + 1; col = col + 1;

  % Loop through equality constraints
  for j = 1:q.nE

    % Place auxiliary variable coefficients for equality constraint j
    q.AI(row               :row               +q.pE(j),col) = -ones(1+q.pE(j),1);
    q.AI(row+q.nE+sum(q.pE):row+q.nE+sum(q.pE)+q.pE(j),col) = -ones(1+q.pE(j),1);

    % Increment row and column counters
    row = row + q.pE(j) + 1; col = col + 1;

  end
  
  % Increment row counter
  row = row + q.nE + sum(q.pE);

  % Loop through inequality constraints
  for j = 1:q.nI

    % Place auxiliary variable coefficients for inequality constraint j
    q.AI(row:row+q.pI(j),col) = -ones(1+q.pI(j),1);

    % Increment row and column counters
    row = row + q.pI(j) + 1; col = col + 1;

  end

  % Initialize subproblem equality constraint right-hand-side
  q.bE = [];

  % Initialize subproblem inequality constraint right-hand-side
  q.bI = zeros(1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI),1);

  % Set subproblem bounds
  q.l = [-inf*ones(q.nV+1,1);   sparse(q.nE+q.nI,1)];
  q.u = [ inf*ones(q.nV+1,1); inf*ones(q.nE+q.nI,1)];

elseif strcmp(p.algorithm,'SQPGS') == 1

  % Initialize Hessian
  q.H = sparse(q.nV+1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI),q.nV+1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI));
  
  % Initialize linear objective term
  q.g = sparse(q.nV+1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI),1);
  
  % Initialize subproblem inequality constraint Jacobian
  q.AI = sparse(q.nE+q.nI,q.nV+1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI));
  
  % Initialize subproblem equality constraint Jacobian
  q.AE = sparse(q.nV+1,q.nV+1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI));
  
  % Place dual variable coefficients for primal auxiliary variable coefficient for objective
  q.AE(q.nV+1,q.nV+1:q.nV+1+q.pO) = ones(1,1+q.pO);
  
  % Initialize row and column counters
  row = 1; col = q.nV+1+q.pO+1;

  % Loop through equality constraints
  for j = 1:q.nE

    % Place dual variable coefficients for primal auxiliary variable coefficients for equality constraints
    q.AI(row,col               :col               +q.pE(j)) = ones(1,1+q.pE(j));
    q.AI(row,col+q.nE+sum(q.pE):col+q.nE+sum(q.pE)+q.pE(j)) = ones(1,1+q.pE(j));
    
    % Increment row and column counters
    row = row + 1; col = col + q.pE(j) + 1;
    
  end
  
  % Increment column counter
  col = col + q.nE + sum(q.pE);

  % Loop through inequality constraints
  for j = 1:q.nI
  
    % Place dual variable coefficients for primal auxiliary variable coefficients for inequality constraints
    q.AI(row,col:col+q.pI(j)) = ones(1,1+q.pI(j));
    
    % Increment row and column counters
    row = row + 1; col = col + q.pI(j) + 1;
    
  end

  % Initialize subproblem equality constraint right-hand-side
  q.bE = sparse(q.nV+1,1);
  
  % Set subproblem inequality constraint right-hand-side
  q.bI = ones(q.nE+q.nI,1);
  
  % Set subproblem bounds
  q.l = [-inf*ones(q.nV,1);   sparse(1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI),1)];
  q.u = [ inf*ones(q.nV,1); inf*ones(1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI),1)];

else

  % Initialize linear objective term
  q.g = sparse(1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI)+2*q.nV,1);
  
  % Initialize subproblem inequality constraint Jacobian
  q.AI = sparse(q.nE+q.nI,1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI)+2*q.nV);
  
  % Initialize subproblem equality constraint Jacobian
  q.AE = sparse(q.nV+1,1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI)+2*q.nV);
  
  % Place dual variable coefficients for primal bounds
  q.AE(1:q.nV,1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI)+1:1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI)+2*q.nV) = [-speye(q.nV) speye(q.nV)];
  
  % Place dual variable coefficients for primal auxiliary variable coefficient for objective
  q.AE(q.nV+1,1:1+q.pO) = ones(1,1+q.pO);
  
  % Initialize row and column counters
  row = 1; col = 1+q.pO+1;

  % Loop through equality constraints
  for j = 1:q.nE

    % Place dual variable coefficients for primal auxiliary variable coefficients for equality constraints
    q.AI(row,col               :col               +q.pE(j)) = ones(1,1+q.pE(j));
    q.AI(row,col+q.nE+sum(q.pE):col+q.nE+sum(q.pE)+q.pE(j)) = ones(1,1+q.pE(j));
    
    % Increment row and column counters
    row = row + 1; col = col + q.pE(j) + 1;
    
  end
  
  % Increment column counter
  col = col + q.nE + sum(q.pE);

  % Loop through inequality constraints
  for j = 1:q.nI
  
    % Place dual variable coefficients for primal auxiliary variable coefficients for inequality constraints
    q.AI(row,col:col+q.pI(j)) = ones(1,1+q.pI(j));
    
    % Increment row and column counters
    row = row + 1; col = col + q.pI(j) + 1;
    
  end

  % Initialize subproblem equality constraint right-hand-side
  q.bE = sparse(q.nV+1,1);
  
  % Set subproblem inequality constraint right-hand-side
  q.bI = ones(q.nE+q.nI,1);
  
  % Set subproblem bounds
  q.l = [  sparse(1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI)+2*q.nV,1)];
  q.u = [inf*ones(1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI)+2*q.nV,1)];

end
