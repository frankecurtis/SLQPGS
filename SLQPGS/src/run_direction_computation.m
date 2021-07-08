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
% Last revised : 1 February 2011

% Set subproblem penalty
q = set_subproblem_penalty(p,q,z);

% Set subproblem data
[q,z] = set_subproblem_data(p,q,z);

% Solve subproblem
[c,d] = run_subproblem_solver(c,p,q);

% Evaluate model and model reduction
d = eval_model(p,q,z,d);

% Check penalty update option
if strcmp(p.rho_update,'steering') == 1

  % Check feasibility
  if z.v/max(z.v0,1) > p.inf_tol

    % Check linearized feasibility
    if d.l/max(z.v0,1) > p.inf_tol
  
      % Store initial penalty parameter
      rho = z.rho;
    
      % Set penalty parameter to zero
      z.rho = 0;
  
      % Set subproblem penalty to zero
      q = set_subproblem_penalty(p,q,z);
    
      % Solve subproblem
      [c,d0] = run_subproblem_solver(c,p,q);
    
      % Evaluate model and model reduction
      d0 = eval_model(p,q,z,d);
    
      % Set penalty parameter to current value
      z.rho = rho;

      % Steering loop
      while run_steering_check(p,z,d0,d,rho)
    
        % Decrease penalty parameter
        z.rho = p.rho_factor*z.rho;

        % Reevaluate merit function
        z = eval_merit(z);

        % Set subproblem penalty
        q = set_subproblem_penalty(p,q,z);
     
        % Solve subproblem
        [c,d] = run_subproblem_solver(c,p,q);
     
        % Evaluate model and model reduction
        d = eval_model(p,q,z,d);
     
      end
  
    end
    
  end

end
