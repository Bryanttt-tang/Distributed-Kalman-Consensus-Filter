%compare the result of different sensors on the same target
function plot_variance(t_vec,P_M21,P_M31,P_M41,P_M,P_M_sta,k,eps,gamma)
% variance of DKCF
M_1x=zeros(1,length(t_vec));M_1y=zeros(1,length(t_vec));M_1vx=zeros(1,length(t_vec));M_1vy=zeros(1,length(t_vec));
M_2x=zeros(1,301);M_1y=zeros(1,length(t_vec));M_1vx=zeros(1,length(t_vec));M_1vy=zeros(1,length(t_vec));
M_3x=zeros(1,301);M_1y=zeros(1,length(t_vec));M_1vx=zeros(1,length(t_vec));M_1vy=zeros(1,length(t_vec));
for i =1:length(t_vec)
  M_1x(i)=P_M_sta(1,1,i);M_1y(i)=P_M_sta(2,2,i);M_1vx(i)=P_M_sta(3,3,i);M_1vy(i)=P_M_sta(4,4,i);
  M_2x(i)=P_M_sta(5,5,i);M_2y(i)=P_M_sta(6,6,i);M_2vx(i)=P_M_sta(7,7,i);M_2vy(i)=P_M_sta(8,8,i);
  M_3x(i)=P_M_sta(9,9,i);M_3y(i)=P_M_sta(10,10,i);M_3vx(i)=P_M_sta(11,11,i);M_3vy(i)=P_M_sta(12,12,i);
end 
% variance of Kalman consensus
M1x=zeros(1,length(t_vec));M1y=zeros(1,length(t_vec));M1vx=zeros(1,length(t_vec));M1vy=zeros(1,length(t_vec));
M2x=zeros(1,301);M1y=zeros(1,length(t_vec));M1vx=zeros(1,length(t_vec));M1vy=zeros(1,length(t_vec));
M3x=zeros(1,301);M1y=zeros(1,length(t_vec));M1vx=zeros(1,length(t_vec));M1vy=zeros(1,length(t_vec));
for i =1:length(t_vec)
  M1x(i)=P_M(1,1,i,1);M1y(i)=P_M(2,2,i,1);M1vx(i)=P_M(3,3,i,1);M1vy(i)=P_M(4,4,i,1);
  M2x(i)=P_M(1,1,i,2);M2y(i)=P_M(2,2,i,2);M2vx(i)=P_M(3,3,i,2);M2vy(i)=P_M(4,4,i,2);
  M3x(i)=P_M(1,1,i,3);M3y(i)=P_M(2,2,i,3);M3vx(i)=P_M(3,3,i,3);M3vy(i)=P_M(4,4,i,3);
end 
figure(7)

if k==1 % plot comparison of kalman filter
subplot(2,2,1)
%  plot(t_vec,X_real(1,:),'o');
%  hold on
plot(t_vec,X_hat21(1,:),':','color','b');
hold on
plot(t_vec,X_hat31(1,:),'--','color','g');
hold on
plot(t_vec,X_hat41(1,:),'.-','color','r');
grid on
xlabel('Time(s)') 
ylabel('Position-x')
ylim([-2 2]);
legend('$\hat{X}_{21}$','X-hat31','X-hat41', 'Interpreter', 'latex')
{'$X_{real}$','$\hat{X}$','$\hat{X}$ +/-1 STD'}, 'Interpreter', 'latex'

subplot(2,2,2)
% plot(t_vec,X_real(2,:),'o');
% hold on
plot(t_vec,X_hat21(2,:),':','color','b');
hold on
plot(t_vec,X_hat31(2,:),'--','color','g');
hold on
plot(t_vec,X_hat41(2,:),'.-','color','r');
grid on
xlabel('Time(s)') 
ylabel('Position-y')
ylim([-2 2]);
legend('X-hat21','X-hat31','X-hat41')

subplot(2,2,3)
% plot(t_vec,X_real(3,:),'o');
% hold on
plot(t_vec,X_hat21(3,:),':','color','b');
hold on
plot(t_vec,X_hat31(3,:),'--','color','g');
hold on
plot(t_vec,X_hat41(3,:),'.-','color','r');
grid on
xlabel('Time(s)') 
ylabel('Velocity-x')
ylim([-2 2]);
legend('X-hat21','X-hat31','X-hat41')

subplot(2,2,4)
% plot(t_vec,X_real(4,:),'o');
% hold on
plot(t_vec,X_hat21(4,:),':','color','b');
hold on
plot(t_vec,X_hat31(4,:),'--','color','g');
hold on
plot(t_vec,X_hat41(4,:),'.-','color','r');
grid on
xlabel('Time(s)') 
ylabel('Velocity-y')
ylim([-2 2]);
legend('X-hat21','X-hat31','X-hat41')
sgtitle('estimation error of different sensors-kalman filter')


elseif k==0 % plot comparison of kalman consensus filter
subplot(2,2,1)
plot(t_vec,sqrt(M1x))
hold on
plot(t_vec,sqrt(M2x))
hold on 
plot(t_vec,sqrt(M3x))
grid on
xlabel('Time[s]') 
ylabel('Variance')
xlim([0 30])
%ylim([-1.4 -0.5]);
legend('P_M21','P_M31','P_M41')

subplot(2,2,2)
plot(t_vec,sqrt(M1y))
hold on
plot(t_vec,sqrt(M2y))
hold on 
plot(t_vec,sqrt(M3y))
grid on
xlabel('Time(s)') 
ylabel('Variance-y')
xlim([0 8])
%ylim([-1.4 -0.5]);
legend('P_M21','P_M31','P_M41')

subplot(2,2,3)
plot(t_vec,M1vx)
hold on
plot(t_vec,M2vx)
hold on 
plot(t_vec,M3vx)
grid on
xlabel('Time(s)') 
ylabel('Variance-vx')
xlim([0 8])
%ylim([-1.4 -0.5]);
legend('P_M21','P_M31','P_M41')

subplot(2,2,4)
plot(t_vec,sqrt(M1vy))
hold on
plot(t_vec,sqrt(M2vy))
hold on 
plot(t_vec,sqrt(M3vy))
grid on
xlabel('Time(s)') 
ylabel('Variance-vy')
xlim([0 8])
%ylim([-1.4 -0.5]);
legend('P_M21','P_M31','P_M41')
str_1 = sprintf('estimation of different sensors using KCF, eps = %d', eps);
sgtitle(str_1)


else % plot comparison of DKCF
subplot(2,2,1)
plot(t_vec,sqrt(M_1x))
hold on
plot(t_vec,sqrt(M_2x))
hold on 
plot(t_vec,sqrt(M_3x))
grid on
xlabel('Time[s]') 
ylabel('$\mathbf{x}$-Standard Deviation', 'Interpreter', 'latex')
xlim([0 30])
%ylim([-1.4 -0.5]);
legend('\sigma_M,1','\sigma_M,2','\sigma_M,3')

subplot(2,2,2)
plot(t_vec,sqrt(M_1y))
hold on
plot(t_vec,sqrt(M_2y))
hold on 
plot(t_vec,sqrt(M_3y))
grid on
xlabel('Time[s]') 
ylabel('$\mathbf{y}$-Standard Deviation', 'Interpreter', 'latex')
xlim([0 30])
%ylim([-1.4 -0.5]);
legend('\sigma_M,1','\sigma_M,2','\sigma_M,3')

subplot(2,2,3)
plot(t_vec,sqrt(M_1vx))
hold on
plot(t_vec,sqrt(M_2vx))
hold on 
plot(t_vec,sqrt(M_3vx))
grid on
xlabel('Time[s]') 
ylabel('$\dot{\mathbf{x}}$-Standard Deviation', 'Interpreter', 'latex')
xlim([0 30])
%ylim([-1.4 -0.5]);
legend('\sigma_M,1','\sigma_M,2','\sigma_M,3')

subplot(2,2,4)
plot(t_vec,sqrt(M_1vy))
hold on
plot(t_vec,sqrt(M_2vy))
hold on 
plot(t_vec,sqrt(M_3vy))
grid on
xlabel('Time[s]') 
ylabel('$\dot{\mathbf{y}}$-Standard Deviation', 'Interpreter', 'latex')
xlim([0 30])
%ylim([-1.4 -0.5]);
legend('\sigma_M,1','\sigma_M,2','\sigma_M,3')
%str_2 = sprintf('Comparison of different sensors using DKCF, gamma = ',num2str(gamma));
%sgtitle(['Comparison of different sensors using DKCF, gamma = ',num2str(gamma)],'FontSize', 16)

end
end
