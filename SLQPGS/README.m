% README
%
% Author       : Frank E. Curtis
% Description  : README file.
% Last revised : 28 October 2009

% Please cite:
%   F. E. Curtis and M. L. Overton, ``A Robust Sequential Quadratic
%   Programming Algorithm for Nonconvex, Nonsmooth Constrained
%   Optimization,'' submitted to SIAM Journal on Optimization, 2009.

% This code runs a sequential quadratic programming method with gradient
% sampling (SQP-GS) or sequential linear programming method with gradient
% sampling (SLP-GS) for nonconvex, nonsmooth constrained optimization.  The
% problem of interest is formulated as
%   min f(x) subject to c(x) <= 0,
% where f and c are assumed to be locally Lipschitz and continuously
% differentiable on open dense subsets of R and R^n, respectively.

% A sample problem can be run, if the Matlab Optimization Toolbox is
% installed, with the command:
%   r = run_driver;
% An output file, rosenbrock.out, will be created.

% Please note that the algorithm is stochastic in nature, meaning that two
% consecutive runs of the same problem instance can yield different results!

% A user need only edit the file run_driver.m and create.m files for the
% data and function evaluations to run the code.  Please refer to the
% sample problem in ./sample to see how these files should be formatted.
% If a subproblem solver other than Matlab's built-in quadprog or linprog
% is to be used, then changes to the file run_subproblem_solver.m may be
% necessary.  For example, we recommend the solver MOSEK (www.mosek.com).

% A description of the output columns:
%   k     ~ iteration number
%   f     ~ objective value
%   v     ~ infeasibility measure
%   rho   ~ penalty parameter value
%   phi   ~ merit function value
%   eps   ~ sampling radius
%   theta ~ infeasibility tolerance
%   msg   ~ QP or LP solver result (interpretation varies with solver)
%   ||d|| ~ norm of search direction
%   m     ~ penalty function model value
%   mred  ~ penalty function model reduction
%   alpha ~ steplength