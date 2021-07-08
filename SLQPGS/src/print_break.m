function print_break(o,c)

% function print_break(o,c)
%
% Author       : Frank E. Curtis
% Description  : Prints break in algorithm output to show quantities.
% Input        : o ~ output data
%                c ~ counters
% Last revised : 1 February 2011

% Print break
if mod(c.k,20) == 0, fprintf(o.fout,'%s\n%s\n%s\n',o.line,o.quan,o.line); end;
