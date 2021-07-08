function r = run_driver

% function r = run_driver
%
% Author       : Frank E. Curtis
% Description  : Runs driver for optimization algorithm; adds directories
%                to path that include the problem functions and subproblem
%                solver; sets options and input parameters.
% Output       : r ~ return values
% Last revised : 28 October 2009

% Add to path the directory containing problem (default: ./sample)
addpath('./sample');

% Set problem data (default: read from problem_data.m)
i = feval('problem_data');

% Assert that all required data has been specified
assert(isfield(i,'n'),'SLQP-GS: Number of variables, n, not specified.');
assert(isfield(i,'m'),'SLQP-GS: Number of constraints, m, not specified.');
assert(isfield(i,'f'),'SLQP-GS: Objective function file, f, not specified.');
assert(isfield(i,'c'),'SLQP-GS: Constraint function file, c, not specified.');
assert(isfield(i,'g'),'SLQP-GS: Objective gradient file, g, not specified.');
assert(isfield(i,'J'),'SLQP-GS: Constraint gradient file, J, not specified.');

% Set algorithm as SQPGS or SLPGS (default: SQPGS)
i.alg = 'SQPGS';

% Name of the LP or QP solver function (default: Matlab's built-in quadprog)
i.solver = 'quadprog';

% Set LP or QP solver options (default: no display)
i.options = optimset('Display','off');

% Set (Matlab's built-in function) eigs options (default: no display)
i.eigs_options.disp = 0;

% Set verbosity level (default: 0)
%   0 ~ output only iterate information, return values include only information of last iterate
%   1 ~ output iterate and step information, return values include only information of last iterate
%   2 ~ output only iterate information, return values include information of all iterates
%   3 ~ output iterate and step information, return values include information of all iterates
i.verbosity = 0;

% Set algorithm parameters (default: values shown)
i.rho_init       = 1e-01; % initial penalty parameter value
i.epsilon_init   = 1e-01; % initial sampling radius value
i.theta_init     = 1e-01; % initial infeasibility measure tolerance
i.rho_factor     = 5e-01; % penalty parameter value reduction factor
i.epsilon_factor = 5e-01; % sampling radius value reduction factor
i.theta_factor   = 5e-01; % infeasibility measure tolerance reduction factor
i.opt_tol        = 1e-06; % optimality tolerance
i.inf_tol        = 1e-06; % infeasibility tolerance
i.k_max          = 1e+03; % iteration limit
i.eta            = 1e-08; % line search sufficient decrease parameter
i.bfgs_tol       = 1e-08; % BFGS update tolerance
i.damp           = 2e-01; % BFGS damping parameter
i.xi_lower       = 1e-02; % Hessian minimum eigenvalue tolerance/trust region scale factor
i.xi_upper       = 1e+02; % Hessian maximum eigenvalue tolerance

% Run optimization algorithm
r = run_optimization(i);