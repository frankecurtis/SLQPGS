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
% Last revised : 28 October 2009

% Evaluate linear objective term
term = -inf;
for k = 1:1+(1-q.vf)*q.p
  piece = z.rho*(z.f + z.g(:,k)'*d.x); if piece > term, term = piece; end;
end
d.m = term;

% Evaluate linear term
for j = 1:q.m
  term = 0;
  for k = 1:1+(1-q.vc(j))*q.p
    piece = max(z.c(j)+z.J(j,:,k)*d.x,0); if piece > term, term = piece; end;
  end
  d.m = d.m + term;
end

% Evaluate quadratic term
if strcmp(p.alg,'SQPGS') == 1, d.m = d.m + (1/2)*d.x'*z.H*d.x; end;

% Evaluate merit model reduction
d.m_red = z.phi - d.m;

% Check for numerical error
if sum(isnan([d.m;d.m_red])) > 0 | sum(isinf([d.m;d.m_red])) > 0, d.m = z.phi; d.m_red = 0; end;