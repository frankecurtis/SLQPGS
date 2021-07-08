function print_break(o,c)

% function print_break(o,c)
%
% Author       : Frank E. Curtis
% Description  : Prints break in algorithm output to show quantities.
% Input        : o ~ outputs
%                c ~ counters
% Last revised : 28 October 2009

% Print break
if mod(c.k,20) == 0, fprintf(o.fout,'%s\n%s\n%s\n',o.line,o.quan,o.line); end;
