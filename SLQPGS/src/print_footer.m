function print_footer(o,c,z,r)

% function print_footer(o,c,z,r)
%
% Author       : Frank E. Curtis
% Description  : Prints footer for output file.
% Input        : o ~ output values
%                c ~ counters
%                z ~ iterate
%                r ~ return values
% Last revised : 28 October 2009

% Print final iterate
print_iterate(o,c,z);

% Print iteration information close
if o.verbosity == 0 | o.verbosity == 2
  fprintf(o.fout,'%s\n',o.line);
else
  fprintf(o.fout,'%s\n%s\n',o.none,o.line);
end
fprintf(o.fout,'\n');

% Print result
fprintf(o.fout,'RESULT : ');
if strcmp(r.msg,'---') == 1, fprintf(o.fout,'Unknown termination result\n'); end;
if strcmp(r.msg,'opt') == 1, fprintf(o.fout,'Stationary point found\n'); end;
if strcmp(r.msg,'itr') == 1, fprintf(o.fout,'Iteration limit reached\n'); end;
fprintf(o.fout,'\n');

% Print final iterate information
fprintf(o.fout,'Solution quality\n');
fprintf(o.fout,'================\n');
fprintf(o.fout,'  Objective function....... : %+.2e\n',z.f);
fprintf(o.fout,'  Infeasibility measure.... : %+.2e\n',z.v);
fprintf(o.fout,'\n');

% Print algorithm output
fprintf(o.fout,'Algorithm counts\n');
fprintf(o.fout,'================\n');
fprintf(o.fout,'  # of iterations.......... : %4d\n',c.k);
fprintf(o.fout,'  # of function evaluations : %4d\n',c.f);
fprintf(o.fout,'  # of gradient evaluations : %4d\n',c.g);
fprintf(o.fout,'  # of subproblems solved.. : %4d\n',c.solver);
fprintf(o.fout,'\n');

% Print timing output
fprintf(o.fout,'Computation time\n');
fprintf(o.fout,'================\n');
fprintf(o.fout,'  CPU seconds.............. : %+.2e\n',toc);