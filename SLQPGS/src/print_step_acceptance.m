function print_step_acceptance(o,a)

% function print_step_acceptance(o,a)
%
% Author       : Frank E. Curtis
% Description  : Prints step acceptance value (i.e., steplength).
% Input        : o ~ output data
%                a ~ acceptance value
% Last revised : 1 February 2011

% Print step acceptance information
fprintf(o.fout,'%.4e\n',a);
