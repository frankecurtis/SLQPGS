function print_header(i,o,q)

% function print_header(i,o,q)
%
% Author       : Frank E. Curtis
% Description  : Prints header to output file including problem name, size,
%                and size of the subproblem.
% Input        : i ~ inputs
%                o ~ outputs
%                q ~ quantities
% Last revised : 28 October 2009

% Set problem name
if ~isfield(i,'name'), i.name = '(not specified)'; end;

% Print problem name
fprintf(o.fout,'Problem\n');
fprintf(o.fout,'=======\n');
fprintf(o.fout,'  Name..................... : %s\n',i.name);
fprintf(o.fout,'\n');

% Print problem size
fprintf(o.fout,'Problem size\n');
fprintf(o.fout,'============\n');
fprintf(o.fout,'  # of variables........... : %4d\n',q.n);
fprintf(o.fout,'  # of objectives.......... : %4d (%4d smooth, %4d nonsmooth)\n',  1,q.vfs,q.vfn);
fprintf(o.fout,'  # of constraints......... : %4d (%4d smooth, %4d nonsmooth)\n',q.m,q.vcs,q.vcn);
fprintf(o.fout,'  # of auxiliary variables. : %4d\n',q.a);
fprintf(o.fout,'  # of sample points....... : %4d\n',q.p);
fprintf(o.fout,'\n');

% Print subproblem name
fprintf(o.fout,'Subproblem\n');
fprintf(o.fout,'==========\n');
fprintf(o.fout,'  Type..................... : %s\n',i.alg);
fprintf(o.fout,'\n');

% Print subproblem size
fprintf(o.fout,'Subproblem size\n');
fprintf(o.fout,'===============\n');
fprintf(o.fout,'  # of variables........... : %4d\n',q.n+q.a);
fprintf(o.fout,'  # of linear constraints.. : %4d\n',q.vfs+q.vcs+(q.p+1)*(q.vfn+q.vcn));
fprintf(o.fout,'  # of bound constraints... : %4d\n',q.a-1);
fprintf(o.fout,'\n');