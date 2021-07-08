function [c,z] = eval_gradients(i,c,p,q,z,opt)

% function [c,z] = eval_gradients(i,c,p,q,z,opt)
%
% Author       : Frank E. Curtis
% Description  : Evaluates objective and constraint gradients at current
%                and sample points; increments gradient evaluation counter.
% Input        : i   ~ inputs
%                c   ~ counters
%                p   ~ parameters
%                q   ~ quantities
%                z   ~ iterate
%                opt ~ 1 if evaluate all;
%                      0 if only at current point
% Output       : c   ~ updated counters
%                z   ~ updated iterate
% Last revised : 1 February 2011

% Initialize marker
mark = 1;

% Loop through sample points for objective
for j = 1:1+opt*q.pO
  
  % Evaluate objective gradient at sample point j
  if j == 1, z.g(:,j) = feval(i.g,i,z.x(:,1));        z.g_dist(j) = 0;
  else       z.g(:,j) = feval(i.g,i,z.x(:,mark+j-1)); z.g_dist(j) = norm(z.x(:,1)-z.x(:,mark+j-1)); end;

  % Check Lipschitz condition for objective for sample point j
  if norm(z.g(:,j)-z.g(:,1)) < p.Lipschitz*z.epsilon*z.g_dist(j), z.g(:,j) = zeros(q.nV,1); end;

end

% Increment marker
mark = mark + q.pO;

% Loop through equality constraints
for k = 1:q.nE

  % Loop through sample points for equality constraint k
  for j = 1:1+opt*q.pE(k)

    % Evaluate kth equality constraint gradient at sample point j
    if j == 1, z.JE(k,:,j) = feval(i.JE,i,k,z.x(:,1));        z.JE_dist(k,j) = 0;
    else       z.JE(k,:,j) = feval(i.JE,i,k,z.x(:,mark+j-1)); z.JE_dist(k,j) = norm(z.x(:,1)-z.x(:,mark+j-1)); end;

    % Check Lipschitz condition for equality constraint k for sample point j
    if norm(z.JE(k,:,j)-z.JE(k,:,1)) < p.Lipschitz*z.epsilon*z.JE_dist(k,j), z.JE(k,:,j) = zeros(q.nV,1)'; end;
    
  end
  
  % Increment marker
  mark = mark + q.pE(k);
  
end

% Loop through inequality constraints
for k = 1:q.nI

  % Loop through sample points for inequality constraint k
  for j = 1:1+opt*q.pI(k)
  
    % Evaluate kth inequality constraint gradient at sample point j
    if j == 1, z.JI(k,:,j) = feval(i.JI,i,k,z.x(:,1));        z.JI_dist(k,j) = 0;
    else       z.JI(k,:,j) = feval(i.JI,i,k,z.x(:,mark+j-1)); z.JI_dist(k,j) = norm(z.x(:,1)-z.x(:,mark+j-1)); end;

    % Check Lipschitz condition for inequality constraint k for sample point j
    if norm(z.JI(k,:,j)-z.JI(k,:,1)) < p.Lipschitz*z.epsilon*z.JI_dist(k,j), z.JI(k,:,j) = zeros(q.nV,1)'; end;

  end

  % Increment marker
  mark = mark + q.pI(k);

end

% Increment gradient evaluation counter
c.g = c.g + 1;