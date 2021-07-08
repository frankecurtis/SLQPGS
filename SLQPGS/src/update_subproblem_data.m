function q = update_subproblem_data(q,z)

% function q = update_subproblem_data(q,z)
%
% Author       : Frank E. Curtis
% Description  : Updates data for the subproblem including linear
%                inequality constraint matrix and right-hand-side.
% Input        : q ~ quantities
%                z ~ iterate
% Output       : q ~ updated quantities
% Last revised : 28 October 2009

% Place objective quantities
q.A(1:q.vf+(1-q.vf)*(q.p+1),1:q.n) =  z.g';
q.b(1:q.vf+(1-q.vf)*(q.p+1))       = -z.f ;

% Initialize row marker
row = q.vf+(1-q.vf)*(q.p+1);

% Loop through constraints
for k = 1:q.m

  % Loop through sample points
  for j = 1:1+q.p*(1-q.vc(k))

    % Place constraint quantities
    q.A(row+1,1:q.n) =  z.J(k,:,j);
    q.b(row+1)       = -z.c(k);

    % Increment row marker
    row = row + 1;

  end

end