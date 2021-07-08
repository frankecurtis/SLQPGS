function print_direction(o,z,d)

% function print_direction(o,z,d)
%
% Author       : Frank E. Curtis
% Description  : Prints direction information.
% Input        : o ~ output data
%                z ~ iterate
%                d ~ direction
% Last revised : 1 February 2011

% Print direction information
if o.verbosity == 0 | o.verbosity == 2
  fprintf(o.fout,'%.4e | ',norm(d.x));
else
  fprintf(o.fout,'%.4e  %.4e  %4d  %4d  %.4e  %+.4e  %+.4e | ',z.epsilon,z.theta,z.size,d.flag,norm(d.x),d.q,d.q_red);
end
