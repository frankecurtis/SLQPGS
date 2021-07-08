function d = eval_model(p,q,z,d)

% function d = eval_model(p,q,z,d)
%
% Author       : Frank E. Curtis
% Description  : Evaluates model of merit function and model reduction
%                along computed search direction.
% Input        : p ~ parameters
%                q ~ quantites
%                z ~ iterate
%                d ~ direction
% Output       : d ~ updated direction
% Last revised : 1 February 2011

% Initialize linear term for objective
d.l = max(z.rho*(z.f+z.g'*d.x));

% Loop through equality constraints
for k = 1:q.nE
  
  % Initialize temporary term
  term = 0;
  
  % Loop through sample points for equality constraint k
  for j = 1:1+q.pE(k)
  
    % Evaluate linear term for equality constraint k
    piece = abs(z.cE(k) + z.JE(k,:,j)*d.x); if piece > term, term = piece; end;
    
  end
  
  % Update linear term for equality constraint k
  d.l = d.l + term;
  
end

% Loop through inequality constraints
for k = 1:q.nI
  
  % Initialize temporary term
  term = 0;
  
  % Loop through sample points for inequality constraint k
  for j = 1:1+q.pI(k)
  
    % Evaluate linear term for inequality constraint k
    piece = max(z.cI(k) + z.JI(k,:,j)*d.x,0); if piece > term, term = piece; end;
    
  end
  
  % Update linear term for inequality constraint k
  d.l = d.l + term;
  
end

% Evaluate linear model reduction
d.l_red = z.v - d.l;

% Evaluate quadratic term
if strcmp(p.algorithm,'SQPGS') == 1, d.q = d.l + (1/2)*d.x'*z.H*d.x; else d.q = d.l; end;

% Evaluate merit model reduction
d.q_red = z.phi - d.q;

% Check for numerical error
if sum(isnan([d.l;d.l_red])) > 0 | sum(isinf([d.l;d.l_red])) > 0, d.l = z.v;   d.l_red = 0; end;
if sum(isnan([d.q;d.q_red])) > 0 | sum(isinf([d.q;d.q_red])) > 0, d.q = z.phi; d.q_red = 0; end;
