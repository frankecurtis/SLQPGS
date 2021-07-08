function r = run_optimization(i)

% function r = run_optimization(i)
%
% Author       : Frank E. Curtis
% Description  : Runs optimization algorithm.
% Input        : i ~ input values
% Output       : r ~ return values
% Last revised : 28 October 2009

% Initialize output
o = init_output(i);

% Initialize counters
c = init_counters;

% Initialize parameters
p = init_parameters(i);

% Initialize quantities
q = init_quantities(i);

% Initialize iterate
[c,z] = init_iterate(i,c,p,q);

% Initialize return values
r = init_returns(o,p,q,z);

% Print output header
print_header(i,o,q);

% Print break
print_break(o,c);

% Main loop
while run_termination_check(r)
  
  % Print iterate
  print_iterate(o,c,z);
  
  % Run search direction computation
  [c,q,z,d] = run_direction_computation(c,p,q,z);
  
  % Print direction
  print_direction(o,z,d);
  
  % Run step acceptance strategy
  [c,a] = run_step_acceptance(i,c,p,q,z,d);
  
  % Print step acceptance
  print_step_acceptance(o,a);
  
  % Update iterate
  [c,z] = update_iterate(i,c,p,q,z,d,a,1);
  
  % Update counters
  c = update_counters(c);
  
  % Update parameters
  z = update_parameters(p,z,d);
  
  % Update returns
  r = update_returns(o,c,p,z,r);
  
  % Print break
  print_break(o,c);
  
end

% Print footer
print_footer(o,c,z,r);

% Terminate output
run_termination(o);