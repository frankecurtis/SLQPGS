function run_termination(o)

% function run_termination(o)
%
% Author       : Frank E. Curtis
% Description  : Runs termination of algorithm (i.e., closes output).
% Output       : o ~ output values
% Last revised : 28 October 2009

% Close output file
if ~ismember(o.fout,[0 1 2]), fclose(o.fout); end;