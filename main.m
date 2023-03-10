close all;
set(0,'defaultfigurecolor','w');
<<<<<<< HEAD
Cx=1; Cy=1; dt=0.01; T=30; time=T/dt; m=1; n=4; n_sen=3; % m is mass, n is the number of UAVs
=======
Cx=1; Cy=1; dt=0.01; T=30; time=T/dt; m=1.2; n=4; n_sen=3; % m is mass, n is the number of UAVs
>>>>>>> 53ae29eda74d2817b0963c46f455d83441d6e821
t_vec=0:dt:T;
x_ref1=[-1/2;1/2;0;0]; x_ref2=[-1/2;-1/2;0;0]; x_ref3=[1/2;1/2;0;0];x_ref4=[1/2;-1/2;0;0]; %referenece position and velocity in cartisian coordinate[x;y]
%X1=zeros(4,time+1);X2=zeros(4,time+1);X3=zeros(4,time+1);
A=[0 0 1 0;0 0 0 1; 0 0 -Cx 0; 0 0 0 -Cy]; B=[0 0;0 0;1/m 0;0 1/m];
C=[1 0 0 0;0 1 0 0];
L=[-2 0 -0.5 0; 0 -2 0 -0.5]; %controller gain u=Lx
<<<<<<< HEAD
vu=0.05  ;   % actuation noise 
R=[0.4, 0; 0, 0.2]; %measurement noise covirance, w is 2*1 dimension
rng('default'); s = rng;  rng(s); % fix random seed
omg = 32*pi;
amp = 0.2;
=======
vu=0.1  ;   % actuation noise 
R=[0.2, 0; 0, 0.1]; %measurement noise covirance, w is 2*1 dimension
rng('default'); s = rng;  rng(s); % fix random seed
omg = 32*pi;
amp = 0.4;
>>>>>>> 53ae29eda74d2817b0963c46f455d83441d6e821
% compute discrete system for sanity check
sysc=ss(A,B,C,[]);
sysd = c2d(sysc,dt);
Ad = sysd.A;
Bd = sysd.B;
A_til = Ad+Bd*L;
Q = Bd*[vu 0;0 vu]*Bd';            % process noise due to input noise
H=[1 0 0 0; 0 1 0 0]; % Zi=H*xi+w, we measure the x,y position
% real work

[A_dis,B_dis,X1,u_vec1] = dynamics(A,B,C,dt,x_ref1,time,vu,L,omg,amp);
[A_dis,B_dis,X2,u_vec2] = dynamics(A,B,C,dt,x_ref2,time,vu,L,omg,amp);
[A_dis,B_dis,X3,u_vec3] = dynamics(A,B,C,dt,x_ref3,time,vu,L,omg,amp);
[A_dis,B_dis,X4,u_vec4] = dynamics(A,B,C,dt,x_ref4,time,vu,L,omg,amp); %A_dis are assumed to be the same for all quadrators

% figure(1)
% plot(X1(1,:),X1(2,:));
% grid on
% hold on
% plot(X1(1,1),X1(2,1),'b*')
% hold on
% plot(X2(1,:),X2(2,:),'--');
% hold on
% plot(X2(1,1),X2(2,1),'y*')
% hold on
% plot(X3(1,:),X3(2,:),':');
% hold on
% plot(X3(1,1),X3(2,1),'g*')
% hold on
% plot(X4(1,:),X4(2,:),'-.');
% hold on
% plot(X4(1,1),X4(2,1),'r*')
% %title('Real Dynamics')
% xlabel('$\mathbf{x}$-Position', 'Interpreter', 'latex') 
% ylabel('$\mathbf{y}$-Position', 'Interpreter', 'latex')
% %xlim([-3 3])
% %legend('X1','X1_0','X2','X2_0','X3','X3_0','X4','X4_0')
% hold off

%% Kalman filtering with GPS measurement
% H=[1 0 0 0; 0 1 0 0]; % Zi=H*xi+w, we measure the x,y position
% X1_bar=zeros(2,time+1);X2_bar=zeros(2,time+1);X3_bar=zeros(2,time+1); % prior update
% X1_hat=zeros(2,time+1);X2_hat=zeros(2,time+1);X3_hat=zeros(2,time+1); % posterior update
% P_P1=zeros(2,2,time+1);P_P2=zeros(2,2,time+1);P_P3=zeros(2,2,time+1);% prior covirance
% P_M1=zeros(2,2,time+1);P_M2=zeros(2,2,time+1);P_M3=zeros(2,2,time+1);% post covirance
% P_M1(:,:,1)=0.01*eye(2);P_M2(:,:,1)=0.01*eye(2);P_M3(:,:,1)=0.01*eye(2);%initial covirance
% X1_hat(:,1)=X1(:,1); X2_hat(:,1)=X2(:,1);X3_hat(:,1)=X3(:,1);%initial x0
%lamda=0.02; % covariance=(lamda*d)^2*R;

% estimation of X1
x01=x_ref1+2*[normrnd(0,0.1);normrnd(0,0.1);0;0];P01=1*eye(4);
<<<<<<< HEAD
% rng(s);
% [X_hat21,P_M21,X_bar21,P_P21,X_plus21,X_min21,Z21] = kalman_1(R,Q,H,x01,P01,time,A_dis,X1,X2);
% rng(1);
% [X_hat31,P_M31,X_bar31,P_P31,X_plus31,X_min31,Z31] = kalman_1(R,Q,H,x01,P01,time,A_dis,X1,X3);
% rng(2);
% [X_hat41,P_M41,X_bar41,P_P41,X_plus41,X_min41,Z41] = kalman_1(R,Q,H,x01,P01,time,A_dis,X1,X4);
% %plot_k1(t_vec,X1,X_hat21,X_plus21,X_min21);

%plot_k1(t_vec,X1,X_hat21,X_plus21,X_min21);
=======
rng(s);
[X_hat21,P_M21,X_bar21,P_P21,X_plus21,X_min21,Z21] = kalman_1(R,Q,H,x01,P01,time,A_dis,X1,X2);
rng(1);
[X_hat31,P_M31,X_bar31,P_P31,X_plus31,X_min31,Z31] = kalman_1(R,Q,H,x01,P01,time,A_dis,X1,X3);
rng(2);
[X_hat41,P_M41,X_bar41,P_P41,X_plus41,X_min41,Z41] = kalman_1(R,Q,H,x01,P01,time,A_dis,X1,X4);
%plot_k1(t_vec,X1,X_hat21,X_plus21,X_min21);

plot_k1(t_vec,X1,X_hat21,X_plus21,X_min21);
>>>>>>> 53ae29eda74d2817b0963c46f455d83441d6e821
%plot_diff_sensor(t_vec,X1,X_hat21,X_hat31,X_hat41);

%% estimation of X1 using consensus filter
X_sen_1= cat(3,X2,X3,X4);
[X_hat_1,P_M_1,X_bar_1,P_P_1,X_plus_1,X_min_1] = kalman_consensus(R,Q,H,x01,P01,time,A_dis,B_dis,u_vec1,X1,X_sen_1,n_sen,omg,amp);

%plot_kal_con(t_vec,X1,X_hat_1,X_plus_1,X_min_1,n_sen);
% k=0;% k=1 means plot kalman; while k=0 means plot kalman consensus; whereas k=2 means DKCF
% plot_diff_sensor(t_vec,X1,X_hat21,X_hat31,X_hat41,X_hat_1,k,3,0.4);
%% estimation of X1 using DKCF
%rng(s);
Bd_til=cat(1,Bd,Bd,Bd);
Q_til = Bd_til*[vu 0;0 vu]*Bd_til';
<<<<<<< HEAD
gamma=0.3;
=======
gamma=0.15;
>>>>>>> 53ae29eda74d2817b0963c46f455d83441d6e821
[X_hat_sta,P_M_sta,X_bar,P_P_sta,X_plus_sta,X_min_sta] = DKCF(R,Q_til,H,x01,P01,time,A_dis,B_dis,u_vec1,X1,X_sen_1,n_sen,gamma);
k=2;% k=1 means plot kalman; while k=0 means plot kalman consensus; whereas k=2 means DKCF
%plot_diff_sensor(t_vec,X1,X_hat_sta,k,3,gamma);
%plot_R(t_vec,X1,X_hat_sta,k,3,gamma); % comparison when R is/not constant

%plot_DKCF(t_vec,X1,X_hat_sta,X_plus_sta,X_min_sta,n_sen);
plot_variance(t_vec,P_M_1,P_M_sta,k,eps,gamma)