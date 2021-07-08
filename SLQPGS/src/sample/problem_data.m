function i = problem_data(i)

% function i = problem_data(i)
%
% Author       : Frank E. Curtis
% Description  : Sets problem data.
% Input        : i ~ inputs
% Output       : i ~ updated inputs
% Last revised : 1 February 2011

% Set problem size
i.nV = 2;
i.nE = 0;
i.nI = 1;

% Set sample sizes
i.pO = 2*i.nV;
i.pE = [];
i.pI = 2*i.nV;

% Set initial point
i.x = randn(i.nV,1);

% Set function handles
i.f  = 'objective_value';
i.g  = 'objective_gradient';
i.cI = 'inequality_constraint_value';
i.JI = 'inequality_constraint_gradient';
