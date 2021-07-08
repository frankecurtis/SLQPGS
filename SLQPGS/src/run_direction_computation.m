function [c,q,z,d] = run_direction_computation(c,p,q,z)

% function [c,q,z,d] = run_direction_computation(c,p,q,z)
%
% Author       : Frank E. Curtis
% Description  : Runs search direction computation; sets up subproblem
%                data, runs subproblem solver, and evaluates model.
% Input        : c ~ counters
%                p ~ parameters
%                q ~ quantities
%                z ~ iterate
% Output       : c ~ updated counters
%                q ~ updated quantities
%                z ~ updated iterate
%                d ~ direction
% Last revised : 28 October 2009

% Set subproblem data
q = update_subproblem_data(q,z);

% Solve subproblem
[c,d] = run_subproblem_solver(c,p,q,z);

% Evaluate model and model reduction
d = eval_model(p,q,z,d);