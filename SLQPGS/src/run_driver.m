function r = run_driver(i)

% function r = run_driver(i)
%
% Author       : Frank E. Curtis
% Description  : Runs driver for optimization algorithm;
%                asserts input data has been specified.
% Output       : r ~ returns
% Last revised : 1 February 2011

% Assert that problem function directory has been provided
assert(isfield(i,'dir'),'SLQP-GS: Problem function folder, i.dir, must be specified as a string.');

% Assert that problem function directory has been provided as a string
assert(ischar(i.dir),'SLQP-GS: Problem function folder, i.dir, must be specified as a string.');

% Add problem function directory to path
addpath(i.dir);

% Assert that problem_data.m exists
assert(exist(sprintf('%s/problem_data.m',i.dir),'file')~=0,sprintf('SLQP-GS: Problem data file, %s, does not exist.',sprintf('%s/problem_data.m',i.dir)));

% Read problem data
i = feval('problem_data',i);

% Assert that number of variables has been specified
assert(isfield(i,'nV') & length(i.nV) == 1 & isscalarinteger(i.nV),'SLQP-GS: Number of variables, i.nV, must be specified as a scalar integer.');

% Assert that number of sample points for objective has been specified
assert(isfield(i,'pO') & length(i.pO) == 1 & isscalarinteger(i.pO),'SLQP-GS: Number of sample points for objective, i.pO, must be specified as a scalar integer.');

% Assert that objective data have been specified
assert(isfield(i,'f'),'SLQP-GS: Objective function handle, i.f, must be specified as a string.');
assert(isfield(i,'g'),'SLQP-GS: Objective gradient handle, i.g, must be specified as a string.');

% Assert that objective data have been specified as strings
assert(ischar(i.f),'SLQP-GS: Objective function handle, i.f, must be specified as a string.');
assert(ischar(i.g),'SLQP-GS: Objective gradient handle, i.g, must be specified as a string.');

% Assert that numbers of constraints have been specified
assert(isfield(i,'nE') & length(i.nE) == 1 & isscalarinteger(i.nE),'SLQP-GS: Number of equality constraints, i.nE, must be specified as a scalar integer.');
assert(isfield(i,'nI') & length(i.nI) == 1 & isscalarinteger(i.nI),'SLQP-GS: Number of inequality constraints, i.nI, must be specified as a scalar integer.');

% Assert that numbers of sample points for constraints have been specified
if i.nE > 0, assert(isfield(i,'pE') & length(i.pE) == i.nE & isvectorinteger(i.pE),'SLQP-GS: Numbers of sample points for equality constraints, i.pE, must be specified as a vector of integers of length i.nE.'); end;
if i.nI > 0, assert(isfield(i,'pI') & length(i.pI) == i.nI & isvectorinteger(i.pI),'SLQP-GS: Numbers of sample points for inequality constraints, i.pI, must be specified as a vector of integers of length i.nI.'); end;

% Assert that constraint data have been specified
if i.nE > 0
  assert(isfield(i,'cE'),'SLQP-GS: Equality constraint function handle, i.cE, must be specified as a string.');
  assert(isfield(i,'JE'),'SLQP-GS: Equality constraint gradient handle, i.JE, must be specified as a string.');
end
if i.nI > 0
  assert(isfield(i,'cI'),'SLQP-GS: Inequality constraint function handle, i.cI, must be specified as a string.');
  assert(isfield(i,'JI'),'SLQP-GS: Inequality constraint gradient handle, i.JI, must be specified as a string.');
end

% Assert that constraint data have been specified as strings
if i.nE > 0
  assert(ischar(i.cE),'SLQP-GS: Equality constraint function handle, i.cE, must be specified as a string.');
  assert(ischar(i.JE),'SLQP-GS: Equality constraint gradient handle, i.JE, must be specified as a string.');
end
if i.nI > 0
  assert(ischar(i.cI),'SLQP-GS: Inequality constraint function handle, i.cI, must be specified as a string.');
  assert(ischar(i.cI),'SLQP-GS: Inequality constraint gradient handle, i.JI, must be specified as a string.');
end

% Run optimization algorithm
r = run_optimization(i);

% Function for asserting scalar integers
function b = isscalarinteger(a)

% Check length
if length(a) > 1, b = 0; return; end;

% Evaluate boolean
b = (isnumeric(a) & isscalar(a) & round(a) == a);

% Function for asserting vector of integers
function b = isvectorinteger(a)

% Loop through elements
for i = 1:length(a), b = isscalarinteger(a(i)); if b == 0, break; end; end;
