function print_step_acceptance(o,a)

% function print_step_acceptance(o,a)
%
% Author       : Frank E. Curtis
% Description  : Prints step acceptance value (i.e., steplength).
% Input        : o ~ output values
%                a ~ acceptance value
% Last revised : 28 October 2009

% Print step acceptance information
if o.verbosity == 1 | o.verbosity == 3
  fprintf(o.fout,'%.2e\n',a);
end