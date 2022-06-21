%dynamics: x_dot=A*x+B*u+v
%we use u=kx as controller
%v is 4*1 process noise
function [A_dis,X_real] = dynamics(A,B,C,dt,x_ref,time,Q,K)
sysc=ss(A,B,C,[]);
sysd = c2d(sysc,dt);
A_dis=sysd.A;
B_dis=sysd.B;
x0=x_ref+[normrnd(0,1);0;normrnd(0,1);0];% initial condition
X_real(:,1)=x0;
for i=1:time
    % if x_desired = x_ref, we let u=K*(x-x_ref)
    %so the dynamics becomes x_k+1=A*x_k + B*k*(x_k-x_ref) + v
    X_real(:,i+1)=A_dis*X_real(:,i)+B_dis*K*(X_real(:,i)-x_ref)+mvnrnd([0 0 0 0],Q,1)';   
end
end