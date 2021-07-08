function z = update_parameters(p,z,d)

% function z = update_parameters(p,z,d)
%
% Author       : Frank E. Curtis
% Description  : Updates parameters.
% Input        : p ~ parameters
%                z ~ iterate
%                d ~ direction
% Output       : z ~ updated iterate
% Last revised : 1 February 2011

% Check model reduction condition
if d.q_red <= z.epsilon
  
  % Decrease epsilon
  z.epsilon = p.epsilon_factor*z.epsilon;

  % Check penalty update option
  if strcmp(p.rho_update,'conservative') == 1

    % Check infeasibility measure condition
    if z.v > z.theta
    
      % Decrease rho
      z.rho = p.rho_factor*z.rho;
  
    else
    
      % Decrease theta
      z.theta = p.theta_factor*z.theta;
  
    end
    
  end

end
