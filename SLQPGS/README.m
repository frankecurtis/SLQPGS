% README
%
% Author       : Frank E. Curtis
% Description  : README file.
% Last revised : 1 February 2011

% Please cite:
%   F. E. Curtis and M. L. Overton, ``A Sequential Quadratic Programming Algorithm for
%   Nonconvex, Nonsmooth Constrained Optimization,'' in second round of review for
%   SIAM Journal on Optimization, February 2011.

% This code runs a sequential quadratic programming method with gradient sampling (SQPGS)
% or a sequential linear programming method with gradient sampling (SLPGS) for nonconvex,
% nonsmooth constrained optimization.  The problem of interest is formulated as
%   minimize f(x) subject to cE(x) = 0, cI(x) <= 0,
% where f, cE, and cI are all continuously differentiable on open dense subsets of R^n.
% Global convergence results hold with probability one if the problem functions are also
% locally Lipschitz on R^n; see the above citation.

% A sample problem can be run, if the Matlab Optimization Toolbox is installed, via:
%   i.dir = 'sample'; r = run_driver(i);
% An output file, sample.out, will be created.

% Please note that the algorithm is stochastic in nature, meaning that two runs for the
% same problem instance can yield different results!  The states of Matlab's built-in
% rand and randn functions should be set prior to a run to obtain reproducable results.

% A user need only create a problem_data.m file and other .m files for the data and
% function evaluations to run the code.  Please refer to the sample problem in ./sample
% to see how these files should be formatted and see below for more detail.  If a QP or LP
% solver other than Matlab's built-in quadprog or linprog, respectively, is desired, then
% changes to the file run_subproblem_solver.m may be necessary.  For example, we recommend
% the solver MOSEK (www.mosek.com), though for this solver one need only set the path to
% include the directory containing MOSEK's quadprog function.

% The remainder of this file includes more detail about how to create a problem instance,
% how to read the output file and returned values, and how to change the input parameters.

% CREATING A PROBLEM INSTANCE

% Please see the sample problem in ./sample as a guide.  The required fields for the input
% structure i, along with a short description of each, are as follows:
%   i.dir ~ directory containing .m files for the problem instance
%   i.nV  ~ number of variables
%   i.nE  ~ number of equality constraints
%   i.nI  ~ number of inequality constraints
%   i.pO  ~ number of sample points for the objective
%   i.pE  ~ vector of length i.nE indicating numbers of sample points for each equality constraint
%   i.pI  ~ vector of length i.nI indicating numbers of sample points for each inequality constraint
%   i.f   ~ handle for file evaluating the objective function value
%   i.g   ~ handle for file evaluating the objective function gradient
% If i.nE > 0 or, similarly, if i.nI > 0, then the following may also be necessary:
%   i.cE  ~ handle for file evaluating all equality constraint values
%   i.JE  ~ handle for file evaluating the jth equality constraint gradient for all j
%   i.cI  ~ handle for file evaluating all inequality constraint values
%   i.JI  ~ handle for file evaluating the jth inequality constraint gradient for all j
% Note that the objective gradient is expected to be a column vector and any constraint
% gradient is expected to be a row vector.

% The numbers of sample points --- i.pO, i.pE, and i.pI --- should be chosen based on the
% smoothness of each problem function.  If a given function is smooth, then the number of
% sample points for that function should be set to zero.  If a given function is nonsmooth,
% then the number of sample points should be positive.  The convergence theory in the paper
% cited above requires that at least i.nV+1 points be sampled for each nonsmooth function.
% However, if a given function depends on only m < i.nV variables, then it is reasonable
% to set the number of sample points to m+1 (if not more).  Generally speaking, more sample
% points will produce better search directions, but at a higher cost per iteration.

% The .m files for evaluating constraint values should evaluate all functions together and
% return the result as a column vector.  However, the .m files for evaluating constraint
% gradients should return only a single gradient at a time corresponding to constraint j.
% Again, see the sample problem in ./sample as a guide.

% Data required for the function and gradient evaluation files can be provided in
% problem_data.m and passed through the program via the structure i.  However, it is
% important to avoid denoting data structures with any field of i used by the program.
% (See the inputs defined above and the parameter values defined below.) It may be
% reasonable to create a substructure i.data to avoid any conflicts.

% READING THE OUTPUT FILE AND THE RETURNED VALUES

% The level of detail in the output file and returned data structure depend on the level of
% verbosity desired by the user.  The level can be changed through the input parameter
% i.verbosity.  The default value is 0.  All levels can be described as follows:
%   0 ~ output only iterate information, return values include only information of last iterate
%   1 ~ output iterate and step information, return values include only information of last iterate
%   2 ~ output only iterate information, return values include information of all iterates
%   3 ~ output iterate and step information, return values include information of all iterates

% A short description of each item in the output file is as follows, some of which will appear
% only for verbosity levels 1 and 3.  Notation in parentheses refers to quantities as they
% are denoted in the paper cited above; please see the citation for more details.
%   Iter.      ~ iteration number (k)
%   Objective  ~ objective value (f)
%   Infeas.    ~ infeasibility measure; l1-norm of constraint violations (v)
%   Pen. Par.  ~ penalty parameter value (rho)
%   Merit      ~ merit/penalty function value (phi)
%   Samp. Rad. ~ sampling radius (epsilon)
%   Inf. Rad.  ~ infeasibility radius (theta)
%   Size       ~ subproblem size (see below)
%   Msg.       ~ subproblem solver message (see below)
%   ||Step||   ~ l2-norm of computed search direction (||d||)
%   Model      ~ model of penalty function value for computed search direction (q)
%   Mod. Red.  ~ reduction in model of penalty function for computed search direction (Delta-q)
%   Steplen.   ~ steplength determined by line search (alpha)
% The meaning of the subproblem size depends on whether the primal or dual subproblem is
% being solved (see discussion on input parameters below).  In the former case the size
% refers to the number of linear inequality constraints in the subproblem, and in the latter
% case the size refers to the number of dual variables.  By default, the size will always
% match the corresponding quantity listed in the ``Maximum subproblem size'' header, but
% there are implemented options that may reduce the subproblem size (again, see below).  The
% subproblem solver message should be observed to ensure that the subproblems are being solved
% sufficiently accurately to produce a good enough step for the nonlinear optimization.

% The returned data structure r contains four fields: msg, f, v, and x.  The first is a
% termination message, which should either be 'opt', indicating that a stationary point has
% been found, or 'itr', indicating that the code has reached the iteration limit.  The code
% terminates with a message that a stationary point has been found if it has reduced the
% sampling radius (epsilon) below a threshold (see discussion on input parameters below) and
% if the infeasibility measure has been reduced below a small fraction (again, see the list
% of input parameters below) of its initial value.

% CHANGING INPUT PARAMETERS

% The code allows the user to change a number of input parameters, though in most cases the
% default values should be sufficient.  Below are descriptions of each input parameter a user
% may choose to include in the input structure i, listed in decreasing order of the likelihood
% that a user would like to change its value from the default.
%   i.verbosity ~ the verbosity level.  See the section above on reading the output file.
%     The default value for this parameter is 0.
%   i.x ~ the initial point.  By default, the origin is used, though in many cases the origin
%     could be troublesome, especially if any problem function is nondifferentiable there.
%     According to the global convergence theory, the starting point should be chosen as one
%     at which all problem functions are differentiable, but a random point should be sufficient.
%   i.algorithm ~ the algorithm to tbe run.  There are two options: 'SQPGS' (the default) and
%     'SLPGS'.  The former option solves QP subproblems to compute search directions and the
%     latter solves LP subproblems.  IMPORTANT: If the 'SLPGS' option is chosen, then the
%     user should replace i.sp_solver (see below) with the name of an available LP solver.
%   i.sp_solver ~ the subproblem solver.  The default is 'quadprog'.  As previously mentioned
%     if a solver other than those in the Matlab Optimization Toolbox is to be used, then
%     changes to the file run_subproblem_solver.m may be necessary.
%   i.sp_options ~ subproblem solver options.  The default is optimset('Display','off') so
%     that the default displayed results from quadprog are suppressed.
%   i.sp_problem ~ the type of subproblem to solve.  The valid options are 'primal' or 'dual',
%     the former of which is the default.  The primal subproblem is the one discussed in the
%     paper cited above; the dual subproblem is that problem's dual.  The better option for
%     a given problem depends on the problem size, but also depends greatly on the QP solver.
%     For example, Matlab's built-in quadprog generally performs better with the 'primal'
%     option, whereas Mosek's quadprog generally performs better with the 'dual' option.
%   i.opt_tol ~ optimality tolerance.  The default value is 1e-6.  This is the threshold
%     value for epsilon used to determine if a stationary point has been found.
%   i.inf_tol ~ infeasibility tolerance.  The default value is 1e-6.  This is the threshold
%     value such that if the infeasibility measure (divided by the maximum of 1 and the
%     initial infeasibility measure) is below this value, the current iterate is deemed
%     sufficiently feasible for termination purposes.
%   i.itr_max ~ iteration limit.  The default value is 1e+3.
%   i.epsilon_init ~ initial sampling radius.  The default value is 1e-1.
%   i.epsilon_factor ~ sampling radius reduction factor.  The default value is 5e-1.  If/when
%     the algorithm determines that a reduction in the sampling radius is appropriate, the
%     value is reduced by this factor.
%   i.rho_init ~ initial penalty parameter.  The default value is 1e-1.
%   i.rho_factor ~ penalty parameter reduction factor.  The default value is 5e-1.  If/when
%     the algorithm determines that a reduction in the penalty parameter is appropriate, the
%     value is reduced by this factor.  IMPORTANT: A user should be aware that if the penalty
%     parameter is reduced to near zero, then any termination at a "stationary" point should
%     be taken to mean only that a sufficiently feasible point has been found and the algorithm
%     could do no better in terms of attaining an optimal point.
%   i.rho_update ~ penalty parameter updating rule.  The default value is 'conservative',
%     meaning that rho is decreased only if an (approximately) epsilon-stationary point for
%     the merit/penalty function has been found and the current infeasibility measure is
%     above the infeasibility tolerance (see below).  The alternative value is 'steering',
%     meaning that a steering rule is applied.  The latter option has the benefit that the
%     penalty parameter may be decreased more rapidly, but this may be at the cost of having
%     to solve multiple QPs during certain iterations.
%   i.ls_type ~ line search type.  The options are 'btrack' (the default) for a backtracking
%     line search, or 'wolfe' for a weak Wolfe line search.
%   i.ls_factor ~ line search factor.  This is the factor by which the steplength may be
%     reduced during a backtracking line search.  The default value is 1e-5.
%   i.ls_cons1 ~ line search constant 1.  In either type of line search, this is the parameter
%     appearing in the sufficient decrease (Armijo-like) condition.  The default is 1e-8.
%   i.ls_cons2 ~ line search constant 2.  In a Wolfe line search, this is the parameter
%     appearing in the curvature condition.
%   i.ls_max ~ line search maximum value.  In a Wolfe line search, this is the largest
%     allowable value for the steplength.  The default value is 1e+1.
%   i.Lipschitz ~ Lipschitz-like parameter.  If set to a positive value, then sampled gradients
%     may be disregarded during the subproblem solution, resulting in smaller subproblems
%     and possibly more efficient solves.  The downside of a positive value, however, is that
%     an insufficient number of sampled gradients may worsen the search direction, resulting
%     in the algorithm requiring more iterations to progress to a solution.  A sampled gradient
%     is disregarded if the difference between it and the gradient at the current iterate
%     is small enough with respect to the distance between the two points of interest, the
%     current sampling radius, and i.Lipschitz.  This is an experimental aspect of the code,
%     and so the default value is 0, meaning that no gradient information is discarded.  An
%     interested user may try a positive value (say, 1e+0) to see if there are any savings in
%     the cost per subproblem solution.
%   i.bfgs_tol ~ BFGS update tolerance.  The BFGS update for the Hessian is skipped if
%     certain quantities are smaller than this threshold.  The default value is 1e-8.
%   i.bfgs_damp ~ BFGS damping parameter.  Parameter appearing in a damped BFGS update.
%     The default value is 2e-1.
%   i.scale_lower ~ Hessian eigenvalue/trust region scaling parameter.  The default value
%     is 1e-2.  In the SQPGS algorithm, the BFGS update for the Hessian is altered to ensure
%     that the eigenvalues for the BFGS matrix remain above this value.  In the SLPGS algorithm,
%     this parameter scales the trust region radius.
%   i.scale_upper ~ Hessian eigenvalue/trust region scaling parameter.  The default value
%     is 1e+2.  In the SQPGS algorithm, the BFGS update for the Hessian is altered to ensure
%     that the eigenvalues for the BFGS matrix remain below this value.
%   i.steering_cons1 ~ steering rule constant 1.  Default value is 1e-1.  A larger value for
%     this parameter decreases the penalty parameter more aggressively if i.rho_update is
%     set to the 'steering' option.
%   i.steering_cons2 ~ steering rule constant 2.  Default value is 1e-1.  A larger value for
%     this parameter decreases the penalty parameter more aggressively if i.rho_update is
%     set to the 'steering' option.
%   i.steering_max ~ steering rule iteration tolerance.  Default value is 4e+0.  This
%     parameter limits the number of decreases in the penalty parameter per iteration if
%     i.rho_update is set to the 'steering' option.
