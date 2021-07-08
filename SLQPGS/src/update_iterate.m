function [c,z] = update_iterate(i,c,p,q,z,d,a,opt)

% function [c,z] = update_iterate(i,c,p,q,z,d,a,opt)
%
% Author       : Frank E. Curtis
% Description  : Updates iterate.  During the line search (opt==0), only
%                function values are reevaluated at the trial point, whereas
%                during the main program (opt==1), gradients and the Hessian
%                approximation are also updated.
% Input        : i   ~ inputs
%                c   ~ counters
%                p   ~ parameters
%                q   ~ quantities
%                z   ~ iterate
%                d   ~ direction
%                a   ~ acceptance values
%                opt ~ 0 if in line search;
%                      1 otherwise
% Output       : c   ~ updated counters
%                z   ~ updated iterate
% Last revised : 1 February 2011

% Update Hessian matrix
if opt == 1, z = update_hessian(p,q,z,d); end;

% Update point
z = update_point(z,d,a);

% Evaluate functions
[c,z] = eval_functions(i,c,z);

% Set sample points
if opt == 1, z = set_sample_points(q,z); end;

% Evaluate gradients
if opt == 1 | strcmp(p.algorithm,'wolfe') == 1, [c,z] = eval_gradients(i,c,p,q,z,opt); end;

% Evaluate infeasibility
z = eval_infeasibility(q,z);

% Evaluate merit
z = eval_merit(z);
