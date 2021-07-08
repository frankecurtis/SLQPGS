function print_iterate(o,c,z)

% function print_iterate(o,c,z)
%
% Author       : Frank E. Curtis
% Description  : Prints iterate information to output file.
% Input        : o ~ output values
%                c ~ counters
%                z ~ iterate
% Last revised : 28 October 2009

% Print iterate information
if o.verbosity == 0 | o.verbosity == 2
  fprintf(o.fout,'%4d | %+.2e  %.2e  %.2e  %+.2e\n',c.k,z.f,z.v,z.rho,z.phi);
else
  fprintf(o.fout,'%4d | %+.2e  %.2e  %.2e  %+.2e | ',c.k,z.f,z.v,z.rho,z.phi);
end