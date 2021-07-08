function [c,z] = init_iterate(i,c,p,q)

% function [c,z] = init_iterate(i,c,p,q)
%
% Author       : Frank E. Curtis
% Description  : Initializes iterate including current point, sample
%                points, dynamic parameters, function values, gradient
%                values, infeasibility measure, merit function and
%                gradient, and BFGS approximation of Hessian.
% Input        : i ~ inputs
%                c ~ counters
%                p ~ parameters
%                q ~ quantities
% Output       : c ~ updated counters
%                z ~ iterate
% Last revised : 1 February 2011

% Set initial point
z = init_point(i,q);

% Set penalty parameter
z.rho = p.rho_init;

% Set sample radius
z.epsilon = p.epsilon_init;

% Set penalty parameter update tolerance
z.theta = p.theta_init;

% Set sample points
z = set_sample_points(q,z);

% Evaluate functions
[c,z] = eval_functions(i,c,z);

% Evaluate gradients
[c,z] = eval_gradients(i,c,p,q,z,1);

% Evaluate infeasibility
z = eval_infeasibility(q,z);

% Store initial infeasibility
z.v0 = z.v;

% Evaluate merit function
z = eval_merit(z);

% Initialize Hessian approximation
z = init_hessian(p,q,z);