function i = problem_data

% function i = problem_data
%
% Author       : Frank E. Curtis
% Description  : Sets problem data.
% Output       : i ~ inputs
% Last revised : 28 October 2009

% Set problem name
i.name = 'rosenbrock';

% Set output file
i.fout = 'rosenbrock.out';

% Set problem size
i.n = 2;
i.m = 1;

% Set indicators for smooth/nonsmooth functions:
%   First element corresponds to objective, and remaining elements
%   correspond to constraint functions.  Set an element to 1 to indicate
%   that the function is smooth; otherwise, set it to 0.
i.v = [0;0];

% Set initial point
i.x = randn(i.n,1);

% Set auxiliary variables for functions
i.scalar = 8;
i.vector = [sqrt(2);2];

% Set function names
i.f = 'objective_value';
i.g = 'objective_gradient';
i.c = 'constraint_value';
i.J = 'constraint_gradient';

% Set initial Hessian
%i.H = eye(i.n);

% Set number of sample points
%i.p = 2*i.n;