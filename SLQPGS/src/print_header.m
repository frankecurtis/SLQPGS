function print_header(o,p,q)

% function print_header(o,p,q)
%
% Author       : Frank E. Curtis
% Description  : Prints header to output file.
% Input        : o ~ output data
%                p ~ parameters
%                q ~ quantities
% Last revised : 1 February 2011

% Print problem size
fprintf(o.fout,'Problem size\n');
fprintf(o.fout,'============\n');
fprintf(o.fout,'  # of variables.................... : %6d\n',q.nV);
fprintf(o.fout,'  # of equality constraints......... : %6d\n',q.nE);
fprintf(o.fout,'  # of inequality constraints....... : %6d\n',q.nI);
fprintf(o.fout,'\n');

% Print subproblem size
fprintf(o.fout,'Maximum subproblem size (%s,%s)\n',p.algorithm,p.sp_problem);
if strcmp(p.algorithm,'SQPGS') == 1 & strcmp(p.sp_problem,'primal') == 1
  fprintf(o.fout,'======================================\n');
  fprintf(o.fout,'  # of variables.................... : %6d\n',q.nV+1+q.nE+q.nI);
  fprintf(o.fout,'  # of linear equality constraints.. : %6d\n',0);
  fprintf(o.fout,'  # of linear inequality constraints : %6d\n',1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI));
  fprintf(o.fout,'  # of bound constraints............ : %6d\n',q.nE+q.nI);
elseif strcmp(p.algorithm,'SQPGS') == 1
  fprintf(o.fout,'====================================\n');
  fprintf(o.fout,'  # of variables.................... : %6d\n',q.nV+1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI));
  fprintf(o.fout,'  # of linear equality constraints.. : %6d\n',q.nV+1);
  fprintf(o.fout,'  # of linear inequality constraints : %6d\n',q.nE+q.nI);
  fprintf(o.fout,'  # of bound constraints............ : %6d\n',1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI));
elseif strcmp(p.sp_problem,'primal') == 1
  fprintf(o.fout,'======================================\n');
  fprintf(o.fout,'  # of variables.................... : %6d\n',q.nV+1+q.nE+q.nI);
  fprintf(o.fout,'  # of linear equality constraints.. : %6d\n',0);
  fprintf(o.fout,'  # of linear inequality constraints : %6d\n',1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI));
  fprintf(o.fout,'  # of bound constraints............ : %6d\n',2*q.nV+q.nE+q.nI);
else
  fprintf(o.fout,'====================================\n');
  fprintf(o.fout,'  # of variables.................... : %6d\n',1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI)+2*q.nV);
  fprintf(o.fout,'  # of linear equality constraints.. : %6d\n',q.nV+1);
  fprintf(o.fout,'  # of linear inequality constraints : %6d\n',q.nE+q.nI);
  fprintf(o.fout,'  # of bound constraints............ : %6d\n',1+q.pO+2*(q.nE+sum(q.pE))+q.nI+sum(q.pI)+2*q.nV);
end
fprintf(o.fout,'\n');
