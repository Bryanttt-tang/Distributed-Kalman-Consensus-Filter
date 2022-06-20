Cx=1; Cy=0.5; dt=0.1; T=100; time=T/dt; m=1.2; n=4; % m is mass, n is the number of UAVs
t_vec=0:dt:T;
x_ref1=[-1;1;0;0]; x_ref2=[-1;-1;0;0]; x_ref3=[1;1;0;0];x_ref4=[1;-1;0;0]; %referenece position and velocity in cartisian coordinate[x;y]
%X1=zeros(4,time+1);X2=zeros(4,time+1);X3=zeros(4,time+1);
A=[0 0 1 0;0 0 0 1; 0 0 -Cx 0; 0 0 0 -Cy]; B=[0 0;0 0;1/m 0;0 1/m];
C=[1 0 0 0;0 1 0 0];
%rng('default'); s = rng;  rng(s); % fix random seed
[A_dis,X1] = dynamics(A,B,C,dt,x_ref1,time);
[A_dis,X2] = dynamics(A,B,C,dt,x_ref2,time);
[A_dis,X3] = dynamics(A,B,C,dt,x_ref3,time);
[A_dis,X4]= dynamics(A,B,C,dt,x_ref4,time); %A_dis are assumed to be the same for all quadrators
555555
figure(1)
plot(X1(1,:),X1(2,:));
grid on
% hold on
% plot(X2(1,:),X2(2,:),'--');
% hold on
% plot(X3(1,:),X3(2,:),':');
% hold on
% plot(X4(1,:),X3(2,:),'-.');
title('Real Dynamics')
% legend('X1','X2','X3','X4')
% hold off

%% Kalman filtering with GPS measurement
H=[1 0 0 0; 0 1 0 0]; % Zi=H*xi+w, we measure the x,y position
% X1_bar=zeros(2,time+1);X2_bar=zeros(2,time+1);X3_bar=zeros(2,time+1); % prior update
% X1_hat=zeros(2,time+1);X2_hat=zeros(2,time+1);X3_hat=zeros(2,time+1); % posterior update
% P_P1=zeros(2,2,time+1);P_P2=zeros(2,2,time+1);P_P3=zeros(2,2,time+1);% prior covirance
% P_M1=zeros(2,2,time+1);P_M2=zeros(2,2,time+1);P_M3=zeros(2,2,time+1);% post covirance
% P_M1(:,:,1)=0.01*eye(2);P_M2(:,:,1)=0.01*eye(2);P_M3(:,:,1)=0.01*eye(2);%initial covirance
% X1_hat(:,1)=X1(:,1); X2_hat(:,1)=X2(:,1);X3_hat(:,1)=X3(:,1);%initial x0
Q=0.01*eye(4); % process noise covirance
R=0.005*eye(2); %measurement noise covirance, w is 2*1 dimension

% estimation of X1
x01=x_ref1+10*[normrnd(0,0.01);normrnd(0,0.01);normrnd(0,0.01);normrnd(0,0.01)];P01=0.01*eye(4);
Z1=X1([1 2],:)+normrnd(0,0.005,[2,time+1]); % measurement 2*1 dimension
[X_hat21,P_M21,X_bar21,P_P21,X_plus21,X_min21] = kalman_1(Z1,R,Q,H,x01,P01,time,A_dis);
[X_hat31,P_M31,X_bar31,P_P31,X_plus31,X_min31] = kalman_1(Z1,R,Q,H,x01,P01,time,A_dis);
[X_hat41,P_M41,X_bar41,P_P41,X_plus41,X_min41] = kalman_1(Z1,R,Q,H,x01,P01,time,A_dis);
%err21 = immse(X1,X_hat21); err31 = immse(X1,X_hat31); err41 = immse(X1,X_hat41);
plot_k1(t_vec,X1,X_hat21,X_plus21,X_min21);
plot_diff_sensor(t_vec,X1,X_hat21,X_hat31,X_hat41);