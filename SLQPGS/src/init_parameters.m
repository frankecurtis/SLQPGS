function p = init_parameters(i)

% function p = init_parameters(i)
%
% Author       : Frank E. Curtis
% Description  : Initializes parameters to inputs or, if unspecified, defaults.
% Input        : i ~ inputs
% Output       : p ~ parameters
% Last revised : 1 February 2011

% Set algorithm to ...
if isfield(i,'algorithm') & ischar(i.algorithm) & (strcmp(i.algorithm,'SQPGS') == 1 | strcmp(i.algorithm,'SLPGS') == 1)
  % ... input
  p.algorithm = i.algorithm;
else
  % ... default
  p.algorithm = 'SQPGS';
end

% Set optimality tolerance to ...
if isfield(i,'opt_tol') & isnumeric(i.opt_tol) & isscalar(i.opt_tol)
  % ... input
  p.opt_tol = i.opt_tol;
else
  % ... default
  p.opt_tol = 1e-6;
end

% Set infeasibility tolerance to ...
if isfield(i,'inf_tol') & isnumeric(i.inf_tol) & isscalar(i.inf_tol)
  % ... input
  p.inf_tol = i.inf_tol;
else
  % ... default
  p.inf_tol = 1e-6;
end

% Set iteration limit to ...
if isfield(i,'itr_max') & isnumeric(i.itr_max) & isscalar(i.itr_max)
  % ... input
  p.itr_max = i.itr_max;
else
  % ... default
  p.itr_max = 1e+3;
end

% Set initial penalty parameter to ...
if isfield(i,'rho_init') & isnumeric(i.rho_init) & isscalar(i.rho_init) & i.rho_init > 0
  % ... input
  p.rho_init = i.rho_init;
else
  % ... default
  p.rho_init = 1e-1;
end

% Set penalty parameter update factor to ...
if isfield(i,'rho_factor') & isnumeric(i.rho_factor) & isscalar(i.rho_factor) & i.rho_factor > 0 & i.rho_factor < 1
  % ... input
  p.rho_factor = i.rho_factor;
else
  % ... default
  p.rho_factor = 5e-1;
end

% Set penalty parameter update strategy to ...
if isfield(i,'rho_update') & ischar(i.rho_update) & (strcmp(i.rho_update,'conservative') == 1 | strcmp(i.rho_update,'steering') == 1)
  % ... input
  p.rho_update = i.rho_update;
else
  % ... default
  p.rho_update = 'conservative';
end

% Set initial sampling radius to ...
if isfield(i,'epsilon_init') & isnumeric(i.epsilon_init) & isscalar(i.epsilon_init) & i.epsilon_init > 0
  % ... input
  p.epsilon_init = i.epsilon_init;
else
  % ... default
  p.epsilon_init = 1e-1;
end

% Set sampling radius reduction factor to ...
if isfield(i,'epsilon_factor') & isnumeric(i.epsilon_factor) & isscalar(i.epsilon_factor) & i.epsilon_factor > 0 & i.epsilon_factor < 1
  % ... input
  p.epsilon_factor = i.epsilon_factor;
else
  % ... default
  p.epsilon_factor = 5e-1;
end

% Set initial feasibility indicator to ...
if isfield(i,'theta_init') & isnumeric(i.theta_init) & isscalar(i.theta_init) & i.theta_init > 0
  % ... input
  p.theta_init = i.theta_init;
else
  % ... default
  p.theta_init = 1e-1;
end

% Set feasibility indicator reduction factor to ...
if isfield(i,'theta_factor') & isnumeric(i.theta_factor) & isscalar(i.theta_factor) & i.theta_factor > 0 & i.theta_factor < 1
  % ... input
  p.theta_factor = i.theta_factor;
else
  % ... default
  p.theta_factor = 5e-1;
end

% Set Lipschitz continuity parameter to ...
if isfield(i,'Lipschitz') & isnumeric(i.Lipschitz) & isscalar(i.Lipschitz)
  % ... input
  p.Lipschitz = i.Lipschitz;
else
  % ... default
  p.Lipschitz = 0e+0;
end

% Set line search type to ...
if isfield(i,'ls_type') & ischar(i.ls_type) & (strcmp(i.ls_type,'btrack') == 1 | strcmp(i.ls_type,'wolfe') == 1)
  % ... input
  p.ls_type = i.ls_type;
else
  % ... default
  p.ls_type = 'btrack';
end

% Set line search reduction factor to ...
if isfield(i,'ls_factor') & isnumeric(i.ls_factor) & isscalar(i.ls_factor) & i.ls_factor > 0 & i.ls_factor < 1
  % ... input
  p.ls_factor = i.ls_factor;
else
  % ... default
  p.ls_factor = 5e-1;
end

% Set line search condition constant 1 to ...
if isfield(i,'ls_cons1') & isnumeric(i.ls_cons1) & isscalar(i.ls_cons1) & i.ls_cons1 > 0 & i.ls_cons1 < 1
  % ... input
  p.ls_cons1 = i.ls_cons1;
else
  % ... default
  p.ls_cons1 = 1e-8;
end

% Set line search condition constant 2 to ...
if isfield(i,'ls_cons2') & isnumeric(i.ls_cons2) & isscalar(i.ls_cons2) & i.ls_cons2 > p.ls_cons1 & i.ls_cons2 < 1
  % ... input
  p.ls_cons2 = i.ls_cons2;
else
  % ... default
  p.ls_cons2 = max(9e-1,(p.ls_cons1+1)/2);
end

% Set line search maximum steplength to ...
if isfield(i,'ls_max') & isnumeric(i.ls_max) & isscalar(i.ls_max) & i.ls_max >= 1
  % ... input
  p.ls_max = i.ls_max;
else
  % ... default
  p.ls_max = 1e+1;
end

% Set BFGS update tolerance parameter to ...
if isfield(i,'bfgs_tol') & isnumeric(i.bfgs_tol) & isscalar(i.bfgs_tol) & i.bfgs_tol > 0
  % ... input
  p.bfgs_tol = i.bfgs_tol;
else
  % ... default
  p.bfgs_tol = 1e-8;
end

% Set BFGS updating damping parameter to ...
if isfield(i,'bfgs_damp') & isnumeric(i.bfgs_damp) & isscalar(i.bfgs_damp) & i.bfgs_damp > 0 & i.bfgs_damp < 1
  % ... input
  p.bfgs_damp = i.bfgs_damp;
else
  % ... default
  p.bfgs_damp = 2e-1;
end

% Set Hessian eigenvalue/trust region scaling lower value to ...
if isfield(i,'scale_lower') & isnumeric(i.scale_lower) & isscalar(i.scale_lower) & i.scale_lower > 0
  % ... input
  p.scale_lower = i.scale_lower;
else
  % ... default
  p.scale_lower = 1e-2;
end

% Set Hessian eigenvalue/trust region scaling upper value to ...
if isfield(i,'scale_upper') & isnumeric(i.scale_upper) & isscalar(i.scale_upper) & i.scale_upper >= p.scale_lower
  % ... input
  p.scale_upper = i.scale_upper;
else
  % ... default
  p.scale_upper = max(1e+2,p.scale_lower);
end

% Set subproblem solver handle to ...
if isfield(i,'sp_solver') & ischar(i.sp_solver)
  % ... input
  p.sp_solver = i.sp_solver;
else
  % ... default
  p.sp_solver = 'quadprog';
end

% Set line search type to ...
if isfield(i,'sp_options')
  % ... input
  p.sp_options = i.sp_options;
else
  % ... default
  p.sp_options = optimset('Display','off');
end

% Set line search type to ...
if isfield(i,'sp_problem') & ischar(i.sp_problem) & (strcmp(i.sp_problem,'primal') == 1 | strcmp(i.sp_problem,'dual') == 1)
  % ... input
  p.sp_problem = i.sp_problem;
else
  % ... default
  p.sp_problem = 'primal';
end

% Set steering rule constant 1 to ...
if isfield(i,'steering_cons1') & isnumeric(i.steering_cons1) & isscalar(i.steering_cons1) & i.steering_cons1 > 0 & i.steering_cons1 < 1
  % ... input
  p.steering_cons1 = i.steering_cons1;
else
  % ... default
  p.steering_cons1 = 1e-1;
end

% Set steering rule constant 2 to ...
if isfield(i,'steering_cons2') & isnumeric(i.steering_cons2) & isscalar(i.steering_cons2) & i.steering_cons2 > 0 & i.steering_cons2 < 1
  % ... input
  p.steering_cons2 = i.steering_cons2;
else
  % ... default
  p.steering_cons2 = 1e-1;
end

% Set steering rule subproblem solution limit to ...
if isfield(i,'steering_max') & isnumeric(i.steering_max) & isscalar(i.steering_max) & i.steering_max > 0
  % ... input
  p.steering_max = i.steering_max;
else
  % ... default
  p.steering_max = 4;
end