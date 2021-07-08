function c = init_counters

% function c = init_counters
%
% Author       : Frank E. Curtis
% Description  : Initializes counters for iterations, function evaluations,
%                subproblem solutions, and CPU time.
% Output       : c ~ counters
% Last revised : 28 October 2009

% Initialize iteration counter
c.k = 0;

% Initialize evaluation counters
c.f = 0;
c.g = 0;

% Initialize subproblem solution counter
c.solver = 0;

% Initialize clock
tic;