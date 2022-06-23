%dynamics: x_dot=A*x+B*u+v
%we use u=kx as controller
%v is 4*1 process noise
function [A_dis,B_dis,X_real] = dynamics(A,B,C,dt,x_ref,time,vu,L)
sysc=ss(A,B,C,[]);
sysd = c2d(sysc,dt);
A_dis=sysd.A;
B_dis=sysd.B;
x0=x_ref+2*[normrnd(0,0.1);normrnd(0,0.1);0;0];% initial condition
X_real(:,1)=x0;
u_pre = [0;0];
c0 = 1;               % low-pass filter: u_real(k) = c0*u(k) + (1-c0)*u(k-1)
Vu = vu*eye(2);
for i=1:time
    % if x_desired = x_ref, we let u=K*(x-x_ref)
    %so the dynamics becomes x_k+1=A*x_k + B*k*(x_k-x_ref) + v
    ui = c0*L*(X_real(:,i)-x_ref) + (1-c0)*u_pre + mvnrnd([0 0],Vu,1)';
    X_real(:,i+1)= A_dis*X_real(:,i) + B_dis*ui;
    u_pre = ui;
end
end