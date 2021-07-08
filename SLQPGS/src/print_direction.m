function print_direction(o,z,d)

% function print_direction(o,z,d)
%
% Author       : Frank E. Curtis
% Description  : Prints direction information.
% Input        : o ~ outputs
%                z ~ iterate
%                d ~ direction
% Last revised : 28 October 2009

% Print direction information
if o.verbosity == 1 | o.verbosity == 3
  fprintf(o.fout,'%.2e  %.2e  %3d  %.2e  %+.2e  %+.2e | ',z.epsilon,z.theta,d.flag,norm(d.x),d.m,d.m_red);
end