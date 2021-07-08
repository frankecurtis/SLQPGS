function print_iterate(o,c,z)

% function print_iterate(o,c,z)
%
% Author       : Frank E. Curtis
% Description  : Prints iterate information.
% Input        : o ~ output data
%                c ~ counters
%                z ~ iterate
% Last revised : 1 February 2011

% Print iterate information
fprintf(o.fout,'%5d | %+.4e  %.4e | %.4e  %+.4e | ',c.k,z.f,z.v,z.rho,z.phi);
