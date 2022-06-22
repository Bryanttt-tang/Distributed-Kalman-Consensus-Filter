Cx=1; Cy=1; dt=0.1; T=100; time=T/dt; m=1.2; n=4; % m is mass, n is the number of UAVs
t_vec=0:dt:T;
x_ref1=[-1;1;0;0]; x_ref2=[-1;-1;0;0]; x_ref3=[1;1;0;0];x_ref4=[1;-1;0;0]; %referenece position and velocity in cartisian coordinate[x;y]
%X1=zeros(4,time+1);X2=zeros(4,time+1);X3=zeros(4,time+1);
A=[0 0 1 0;0 0 0 1; 0 0 -Cx 0; 0 0 0 -Cy]; B=[0 0;0 0;1/m 0;0 1/m];
C=[1 0 0 0;0 1 0 0];
K=[-1 0 -0.5 0; 0 -1 0 -0.5]; %controller gain u=Kx
vu=0.5;   % actuation noise 
R=[0.2, 0; 0, 0.1]; %measurement noise covirance, w is 2*1 dimension
rng('default'); s = rng;  rng(s); % fix random seed

% compute discrete system for sanity check
sysc=ss(A,B,C,[]);
sysd = c2d(sysc,dt);
Ad = sysd.A;
Bd = sysd.B;
A_til = Ad+Bd*K;
Q = Bd*vu*Bd';            % process noise due to input noise
% real work

[A_dis,B_dis,X1] = dynamics(A,B,C,dt,x_ref1,time,vu,K);
[A_dis,B_dis,X2] = dynamics(A,B,C,dt,x_ref2,time,vu,K);
[A_dis,B_dis,X3] = dynamics(A,B,C,dt,x_ref3,time,vu,K);
[A_dis,B_dis,X4]= dynamics(A,B,C,dt,x_ref4,time,vu,K); %A_dis are assumed to be the same for all quadrators

figure(1)
plot(X1(1,:),X1(2,:));
grid on
hold on
plot(X2(1,:),X2(2,:),'--');
hold on
plot(X3(1,:),X3(2,:),':');
hold on
plot(X4(1,:),X4(2,:),'-.');
title('Real Dynamics')
legend('X1','X2','X3','X4')
hold off
%%
%   d0=norm(X1([1 2],1)-x_ref2([1 2]));
%          Rtr=(d0*R)^2;
%          %dydx=(X_tar(2,1)-X_sen(2))/(X_tar(1,1)-X_sen(1)); %dy/dx
%          theta=atan2(X1(2,1)-x_ref2(2),X1(1,1)-x_ref2(1));
%          Rxy = Rrt2Rxy(Rtr, theta);

%% Kalman filtering with GPS measurement
H=[1 0 0 0; 0 1 0 0]; % Zi=H*xi+w, we measure the x,y position
% X1_bar=zeros(2,time+1);X2_bar=zeros(2,time+1);X3_bar=zeros(2,time+1); % prior update
% X1_hat=zeros(2,time+1);X2_hat=zeros(2,time+1);X3_hat=zeros(2,time+1); % posterior update
% P_P1=zeros(2,2,time+1);P_P2=zeros(2,2,time+1);P_P3=zeros(2,2,time+1);% prior covirance
% P_M1=zeros(2,2,time+1);P_M2=zeros(2,2,time+1);P_M3=zeros(2,2,time+1);% post covirance
% P_M1(:,:,1)=0.01*eye(2);P_M2(:,:,1)=0.01*eye(2);P_M3(:,:,1)=0.01*eye(2);%initial covirance
% X1_hat(:,1)=X1(:,1); X2_hat(:,1)=X2(:,1);X3_hat(:,1)=X3(:,1);%initial x0
%lamda=0.02; % covariance=(lamda*d)^2*R;

% estimation of X1
x01=x_ref1+10*[normrnd(0,0.01);normrnd(0,0.01);normrnd(0,0.01);normrnd(0,0.01)];P01=1*eye(4);
rng(s);
[X_hat21,P_M21,X_bar21,P_P21,X_plus21,X_min21] = kalman_1(R,Q,H,x01,P01,time,A_dis,X1,X2);
rng(1);
[X_hat31,P_M31,X_bar31,P_P31,X_plus31,X_min31] = kalman_1(R,Q,H,x01,P01,time,A_dis,X1,X3);
rng(2);
[X_hat41,P_M41,X_bar41,P_P41,X_plus41,X_min41] = kalman_1(R,Q,H,x01,P01,time,A_dis,X1,X4);
plot_k1(t_vec,X1,X_hat21,X_plus21,X_min21);
%plot_diff_sensor(t_vec,X1,X_hat21,X_hat31,X_hat41);

