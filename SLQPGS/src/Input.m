% Input class
classdef Input < handle
  
  % Class properties (private set access)
  properties (SetAccess = private)

    algorithm  % Algorithm option
    sp_problem % Subproblem option
    sp_solver  % Subproblem solver handle
    sp_options % Subproblem solver options
    stat_tol   % Stationarity tolerance
    feas_tol   % Feasibility violation tolerance
    iter_max   % Iteration limit
    nV         % Number of variables
    nE         % Number of equality constraints
    nI         % Number of inequality constraints
    pO         % Number of sample points for objective
    pE         % Numbers of sample points for equality constraints
    pI         % Numbers of sample points for inequality constraints
    f          % Problem function handle
    d          % Data to pass to function/gradient evaluators
    x          % Initial primal point
    
  end
  
  % Class methods
  methods
    
    % Constructor
    function i = Input(dir)
      
      % Assert that problem function directory has been provided as a string
      assert(ischar(dir),'SLQP-GS: Problem function folder, dir, must be specified as a string.');

      % Print directory
      fprintf('SLQP-GS: Adding to path the directory "%s"\n',dir);
      
      % Add problem function directory to path
      addpath(dir);

      % Assert that slqpgs_inputs.m exists in problem function directory
      assert(exist(sprintf('%s/slqpgs_inputs.m',dir),'file')~=0,sprintf('SLQP-GS: Problem input file, %s, does not exist.',sprintf('%s/slqpgs_inputs.m',dir)));

      % Print inputs file
      fprintf('SLQP-GS: Loading inputs from "%s"\n',which('slqpgs_inputs'));
      
      % Read problem data
      in = feval('slqpgs_inputs');
      
      % Set data for functions
      if isfield(in,'algorithm'),  i.algorithm  = in.algorithm;  else i.algorithm  = 0;                         end;
      if isfield(in,'sp_problem'), i.sp_problem = in.sp_problem; else i.sp_problem = 0;                         end;
      if isfield(in,'sp_solver'),  i.sp_solver  = in.sp_solver;  else i.sp_solver  = 'quadprog';                end;
      if isfield(in,'sp_options'), i.sp_options = in.sp_options; else i.sp_options = optimset('Display','off'); end;

      % Set data for functions
      if isfield(in,'stat_tol'), i.stat_tol = in.stat_tol; else i.stat_tol = 1e-06; end;
      if isfield(in,'feas_tol'), i.feas_tol = in.feas_tol; else i.feas_tol = 1e-04; end;
      if isfield(in,'iter_max'), i.iter_max = in.iter_max; else i.iter_max = 1e+03; end;

      % Assert that numbers of variables and constraints has been specified
      assert(isfield(in,'nV') & length(in.nV) == 1 & i.isscalarinteger(in.nV),'SLQP-GS: Number of variables, i.nV, must be specified as a scalar integer.');
      assert(isfield(in,'nE') & length(in.nE) == 1 & i.isscalarinteger(in.nE),'SLQP-GS: Number of equality constraints, i.nE, must be specified as a scalar integer.');
      assert(isfield(in,'nI') & length(in.nI) == 1 & i.isscalarinteger(in.nI),'SLQP-GS: Number of inequality constraints, i.nI, must be specified as a scalar integer.');
      
      % Set number of variables
      i.nV = in.nV; i.nE = in.nE; i.nI = in.nI;

      % Assert that number of sample points for objective has been specified
                   assert(isfield(in,'pO') & length(in.pO) ==    1 & i.isscalarinteger(in.pO),'SLQP-GS: Number of sample points for objective, i.pO, must be specified as a scalar integer.');
      if i.nE > 0, assert(isfield(in,'pE') & length(in.pE) == i.nE & i.isvectorinteger(in.pE),'SLQP-GS: Numbers of sample points for equality constraints, i.pE, must be specified as a vector of integers of length i.nE.'); end;
      if i.nI > 0, assert(isfield(in,'pI') & length(in.pI) == i.nI & i.isvectorinteger(in.pI),'SLQP-GS: Numbers of sample points for inequality constraints, i.pI, must be specified as a vector of integers of length i.nI.'); end;

      % Set number of sample points for objective
                   i.pO = in.pO;
      if i.nE > 0, i.pE = in.pE; end;
      if i.nI > 0, i.pI = in.pI; end;
      
      % Assert that problem function has been specified
      assert(isfield(in,'f') & ischar(in.f),'SLQP-GS: Problem functions handle, i.f, must be specified as a string.');
      
      % Set problem function handle
      i.f = in.f;
      
      % Set data for functions
      if isfield(in,'d'), i.d = in.d; else i.d = []; end;
      
      % Assert that initial point has been specified
      assert(isfield(in,'x') & length(in.x) == i.nV,'SLQP-GS: Initial point, i.x, must be specified as a vector of length i.nV');
      
      % Set initial point
      i.x = in.x;
      
      % Print success message
      fprintf('SLQP-GS: Inputs appear loaded successfully\n');
      fprintf('SLQP-GS: Problem to be read from "%s"\n',which(i.f));
      fprintf('SLQP-GS: Use "S.optimize" to run optimizer\n');
      fprintf('SLQP-GS: Output to be printed to slqpgs.out\n');
      fprintf('SLQP-GS: Use "S.getSolution" to return final iterate\n');
      fprintf('SLQP-GS: (After optimizing and getting iterate, advised to "clear S" before loading new problem)\n');
      
    end
  
    % Function for asserting vector of integers
    function b = isvectorinteger(i,a)

      % Loop through elements
      for j = 1:length(a), b = i.isscalarinteger(a(j)); if b == 0, break; end; end;
      
    end
    
  end
  
  % Class methods (static)
  methods (Static)
    
    % Function for asserting scalar integers
    function b = isscalarinteger(a)

      % Check length
      if length(a) > 1, b = 0; return; end;

      % Evaluate boolean
      b = (isnumeric(a) & isscalar(a) & round(a) == a);
      
    end
    
  end
  
end
