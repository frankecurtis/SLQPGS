function p = init_parameters(i)

% function p = init_parameters(i)
%
% Author       : Frank E. Curtis
% Description  : Initializes parameters including algorithm inputs, those
%                relating to the line search and Hessian update, and
%                algorithm termination tolerances.  Parameters not set
%                manually are set to default values.
% Input        : i ~ input values
% Output       : p ~ parameters
% Last revised : 28 October 2009

% Set algorithm and subproblem solver
if isfield(i,'alg'),    p.alg    = i.alg;    else p.alg    = 'SQPGS';    end;
if isfield(i,'solver'), p.solver = i.solver; else p.solver = 'quadprog'; end;

% Set initial dynamic parameters
if isfield(i,'rho_init'),     p.rho_init     = i.rho_init;     else p.rho_init     = 1e-01; end;
if isfield(i,'epsilon_init'), p.epsilon_init = i.epsilon_init; else p.epsilon_init = 1e-01; end;
if isfield(i,'theta_init'),   p.theta_init   = i.theta_init;   else p.theta_init   = 1e-01; end;

% Set dynamic update parameters
if isfield(i,'rho_factor'),     p.rho_factor     = i.rho_factor;     else p.rho_factor     = 5e-01; end;
if isfield(i,'epsilon_factor'), p.epsilon_factor = i.epsilon_factor; else p.epsilon_factor = 5e-01; end;
if isfield(i,'theta_factor'),   p.theta_factor   = i.theta_factor;   else p.theta_factor   = 5e-01; end;

% Set optimality and infeasibility tolerances
if isfield(i,'opt_tol'), p.opt_tol = i.opt_tol; else p.opt_tol = 1e-06; end;
if isfield(i,'inf_tol'), p.inf_tol = i.inf_tol; else p.inf_tol = 1e-06; end;

% Set iteration limit
if isfield(i,'k_max'), p.k_max = i.k_max; else p.k_max = 1e+03; end;

% Set line search parameter
if isfield(i,'eta'), p.eta = i.eta; else p.eta = 1e-08; end;

% Set BFGS tolerances
if isfield(i,'bfgs_tol'), p.bfgs_tol = i.bfgs_tol; else p.bfgs_tol = 1e-08; end;
if isfield(i,'damp'),     p.damp     = i.damp;     else p.damp     = 2e-01; end;

% Set Hessian eigenvalue/trust region scaling tolerances
if isfield(i,'xi_lower'), p.xi_lower = i.xi_lower; else p.xi_lower = 1e-02; end;
if isfield(i,'xi_upper'), p.xi_upper = i.xi_upper; else p.xi_upper = 1e+02; end;