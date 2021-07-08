function z = update_parameters(p,z,d)

% function z = update_parameters(p,z,d)
%
% Author       : Frank E. Curtis
% Description  : Updates parameters.
% Input        : p ~ parameters
%                z ~ iterate
%                d ~ direction
% Output       : z ~ updated iterate
% Last revised : 28 October 2009

% Check model reduction condition
if abs(d.m_red) <= 2*z.epsilon^2/p.xi_lower
  
  % Decrease epsilon
  z.epsilon = p.epsilon_factor*z.epsilon;

  % Check infeasibility measure condition
  if z.v > z.theta
    
    % Decrease rho
    z.rho = p.rho_factor*z.rho;
  
  else
    
    % Decrease theta
    z.theta = p.theta_factor*z.theta;
  
  end

end
