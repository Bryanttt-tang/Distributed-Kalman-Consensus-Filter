%dynamics: x_dot=A*x+B*u+v
%we use u=kx as controller
%v is 4*1 process noise
function [A_dis,B_dis,X_real,u_vec] = dynamics(A,B,C,dt,x_ref,time,vu,L,omg,amp)
sysc=ss(A,B,C,[]);
sysd = c2d(sysc,dt);
A_dis=sysd.A;
B_dis=sysd.B;
x0=x_ref+0.5*[normrnd(0,1);normrnd(0,1);0;0];% initial condition
X_real(:,1)=x0;
u_pre = [0;0];
Vu = vu*eye(2);

for i=1:time
    % if x_desired = x_ref, we let u=K*(x-x_ref)
    %so the dynamics becomes x_k+1=A*x_k + B*k*(x_k-x_ref) + v
    u_sin = amp*[sin(i/omg);cos(i/omg)];
    u_vec(:,i) = L*(X_real(:,i)-x_ref)  + mvnrnd([0 0],Vu,1)' + u_sin;
    X_real(:,i+1)= A_dis*X_real(:,i) + B_dis*u_vec(:,i);
end
end