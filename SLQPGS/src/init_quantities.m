function q = init_quantities(i)

% function q = init_quantities(i)
%
% Author       : Frank E. Curtis
% Description  : Initializes quantities including problem size, indicators
%                for smooth/nonsmooth functions, sampling size, subproblem
%                quantities, and subproblem solver options.
% Input        : i ~ input values
% Output       : q ~ quantities
% Last revised : 28 October 2009

% Set problem size
q.n = i.n;
q.m = i.m;

% Indicate smooth functions
q.vf  = i.v(1);
q.vfs = sum(q.vf==1);
q.vfn = sum(q.vf==0);
q.vc  = i.v(2:end);
q.vcs = sum(q.vc==1);
q.vcn = sum(q.vc==0);

% Set sampling size (default: 2*n)
if isfield(i,'p'), q.p = i.p; else q.p = 2*q.n; end;

% Set number of auxiliary variables
q.a = q.m+1;

% Initialize subproblem constraint Jacobian
q.A = sparse(q.vfs+q.vcs+(q.p+1)*(q.vfn+q.vcn),q.n+q.a);

% Place auxiliary variable coefficients for objective
q.A(1:q.vf+(1-q.vf)*(q.p+1),q.n+1) = -ones(q.vf+(1-q.vf)*(q.p+1),1);

% Initialize row marker
row = q.vf+(1-q.vf)*(q.p+1);

% Loop through constraints
for j = 1:q.m

  % Place auxiliary variable coefficients for constraint
  q.A(row+1:row+q.vc(j)+(1-q.vc(j))*(q.p+1),q.n+1+j) = -ones(q.vc(j)+(1-q.vc(j))*(q.p+1),1);

  % Increment row marker
  row = row + q.vc(j)+(1-q.vc(j))*(q.p+1);

end

% Initialize subproblem constraint right-hand-side
q.b = sparse(q.vfs+q.vcs+(q.p+1)*(q.vfn+q.vcn),1);

% Set bounds
q.l = [-inf*ones(q.n+1,1);   sparse(q.a-1,1)];
q.u = [ inf*ones(q.n+1,1); inf*ones(q.a-1,1)];

% Set subproblem solver options (default: no display)
if isfield(i,'options'), q.options = i.options; else q.options = optimset('Display','off'); end;

% Set eigs options (default: no display)
if isfield(i,'eigs_options'), q.eigs_options = i.eigs_options; else q.eigs_options.disp = 0; end;