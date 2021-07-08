function [c,z] = init_iterate(i,c,p,q)

% function [c,z] = init_iterate(i,c,p,q)
%
% Author       : Frank E. Curtis
% Description  : Initializes iterate including current point, sample
%                points, dynamic parameters, function values, gradient
%                values, infeasibility measure, merit function value and
%                gradient, and Hessian approximation.
% Input        : i ~ input valuess
%                c ~ counters
%                p ~ parameters
%                q ~ quantities
% Output       : c ~ updated counters
%                z ~ iterate
% Last revised : 28 October 2009

% Set initial point
z = init_point(i,q);

% Set penalty parameter
z.rho = p.rho_init;

% Set sample radius
z.epsilon = p.epsilon_init;

% Set rho update tolerance
z.theta = p.theta_init;

% Sample points about x
z = update_sample_points(q,z);

% Evaluate functions
[c,z] = eval_functions(i,c,z);

% Evaluate gradients
[c,z] = eval_gradients(i,c,q,z);

% Evaluate infeasibility
z = eval_infeasibility(z);

% Evaluate merit function
z = eval_merit_function(z);

% Evaluate merit gradient
z = eval_merit_gradient(q,z);

% Evaluate Hessian matrix
if strcmp(p.alg,'SQPGS') == 1, z = init_hessian(i,q,z); end;