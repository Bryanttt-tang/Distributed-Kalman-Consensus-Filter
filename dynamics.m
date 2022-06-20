function [A_dis,X_real] = dynamics(A,B,C,dt,x_ref,time)
sysc=ss(A,B,C,[]);
sysd = c2d(sysc,dt);
A_dis=sysd.A;
B_dis=sysd.B;
x0=x_ref+10*[normrnd(0,0.01);normrnd(0,0.01);normrnd(0,0.01);normrnd(0,0.01)];
X_real(:,1)=x0;
for i=1:time
    X_real(:,i+1)=A_dis*(X_real(:,i)-x_ref)+B_dis*[normrnd(0,0.01);normrnd(0,0.01)]+x_ref;   
end
end