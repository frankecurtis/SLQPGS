function print_footer(o,c,z,r)

% function print_footer(o,c,z,r)
%
% Author       : Frank E. Curtis
% Description  : Prints footer for output file.
% Input        : o ~ output data
%                c ~ counters
%                z ~ iterate
%                r ~ returns
% Last revised : 1 February 2011

% Print final iterate
print_iterate(o,c,z);

% Print iteration information close
fprintf(o.fout,'%s\n%s\n\n',o.none,o.line);

% Print result
fprintf(o.fout,'Algorithm result\n');
fprintf(o.fout,'================\n');
if strcmp(r.msg,'---') == 1, fprintf(o.fout,'  Unknown termination result\n'); end;
if strcmp(r.msg,'opt') == 1, fprintf(o.fout,'  Stationary point found\n');     end;
if strcmp(r.msg,'itr') == 1, fprintf(o.fout,'  Iteration limit reached\n');    end;
fprintf(o.fout,'\n');

% Print final iterate information
fprintf(o.fout,'Final quantities\n');
fprintf(o.fout,'================\n');
fprintf(o.fout,'  Objective function................ : %+.4e\n',z.f);
fprintf(o.fout,'  Infeasibility measure............. : %+.4e\n',z.v);
fprintf(o.fout,'\n');

% Print algorithm output
fprintf(o.fout,'Algorithm counts\n');
fprintf(o.fout,'================\n');
fprintf(o.fout,'  # of iterations................... : %6d\n',c.k);
fprintf(o.fout,'  # of function evaluations......... : %6d\n',c.f);
fprintf(o.fout,'  # of gradient evaluations......... : %6d\n',c.g);
fprintf(o.fout,'  # of subproblems solved........... : %6d\n',c.s);
fprintf(o.fout,'  # of CPU seconds.................. : %6d\n',ceil(toc));
