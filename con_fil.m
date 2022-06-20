% Consensus Filter
% Param:  d_vec,  n-vector of measured distances
%         m,      dimension of state space
%         n,      number of sensors (n+1 robots)
% Output: Lg,     Complete consensus gain matrix in Laplacian form, mn x mn
% Note x = x + K(z - Hx) - gamma*Lg*x

function Lg = con_fil(d_vec, m, n)
f_tilde = sum(cosh(d_vec));
F = diag(cosh(d_vec));

C = F\(ones(n)*F - f_tilde*eye(n));
Lg = -kron(C, eye(m));
end
