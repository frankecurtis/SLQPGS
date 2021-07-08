function b = run_termination_check(r)

% function b = run_termination_check(r)
%
% Author       : Frank E. Curtis
% Description  : Runs check for algorithm termination.
% Input        : r ~ returns
% Output       : b ~ 1 if not done;
%                    0 otherwise
% Last revised : 1 February 2011

% Check for termination
if strcmp(r.msg,'---') == 1, b = 1; else b = 0; end;
