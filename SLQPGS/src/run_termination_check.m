function b = run_termination_check(r)

% function b = run_termination_check(r)
%
% Author       : Frank E. Curtis
% Description  : Runs check for algorithm termination.
% Input        : r ~ return values
% Output       : b ~ 1 if not done; 0 otherwise
% Last revised : 28 October 2009

% Check for termination
if strcmp(r.msg,'---') == 1, b = 1; else b = 0; end;