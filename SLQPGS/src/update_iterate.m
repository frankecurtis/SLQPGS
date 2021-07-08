function [c,z] = update_iterate(i,c,p,q,z,d,a,opt)

% function [c,z] = update_iterate(i,c,p,q,z,d,a,opt)
%
% Author       : Frank E. Curtis
% Description  : Updates iterate.  During the line search (opt==0), only
%                function values are reevaluated at the trial point, whereas
%                during the main program (opt==1), gradients and the Hessian
%                matrix are also updated.
% Input        : i   ~ inputs
%                c   ~ counters
%                p   ~ parameters
%                q   ~ quantities
%                z   ~ iterate
%                d   ~ direction
%                a   ~ acceptance values
%                opt ~ evaluation option
%                        0 ~ function evaluation only
%                        1 ~ evaluate all
% Output       : c   ~ updated counters
%                z   ~ updated iterate
% Last revised : 28 October 2009

% Set quantities for BFGS update
if strcmp(p.alg,'SQPGS') == 1 & opt == 1, z = update_bfgs_quantities(z); end;

% Update point
z = update_point(z,d,a);

% Evaluate functions
[c,z] = eval_functions(i,c,z);

% Evaluate infeasibility
z = eval_infeasibility(z);

% Evaluate merit
z = eval_merit_function(z);

% Check evaluation option
if opt == 1
  
  % Sample points about x
  z = update_sample_points(q,z);

  % Evaluate gradients
  [c,z] = eval_gradients(i,c,q,z);
  
  % Evaluate merit gradient
  z = eval_merit_gradient(q,z);
  
  % Evaluate Hessian matrix
  if strcmp(p.alg,'SQPGS') == 1, z = update_hessian(p,q,z); end;
  
end