%compare the result of different sensors on the same target
function plot_diff_sensor(t_vec,X_real,X_hat21,X_hat31,X_hat41)
figure(3)
subplot(2,2,1)
 plot(t_vec,X_real(1,:),'o');
 hold on
plot(t_vec,X_hat21(1,:),':','color','b');
hold on
plot(t_vec,X_hat31(1,:),'--','color','g');
hold on
plot(t_vec,X_hat41(1,:),'color','r');
grid on
xlabel('Time(s)') 
ylabel('Position-x')
legend('X-real','X-hat21','X-hat31','X-hat41')

subplot(2,2,2)
plot(t_vec,X_real(2,:),'o');
hold on
plot(t_vec,X_hat21(2,:),':','color','b');
hold on
plot(t_vec,X_hat31(2,:),'--','color','g');
hold on
plot(t_vec,X_hat41(2,:),'.-','color','r');
grid on
xlabel('Time(s)') 
ylabel('Position-y')
legend('X-real','X-hat21','X-hat31','X-hat41')

subplot(2,2,3)
plot(t_vec,X_real(3,:),'o');
hold on
plot(t_vec,X_hat21(3,:),':','color','b');
hold on
plot(t_vec,X_hat31(3,:),'--','color','g');
hold on
plot(t_vec,X_hat41(3,:),'.-','color','r');
grid on
xlabel('Time(s)') 
ylabel('Velocity-x')
legend('X-real','X-hat21','X-hat31','X-hat41')

subplot(2,2,4)
plot(t_vec,X_real(4,:),'o');
hold on
plot(t_vec,X_hat21(4,:),':','color','b');
hold on
plot(t_vec,X_hat31(4,:),'--','color','g');
hold on
plot(t_vec,X_hat41(4,:),'.-','color','r');
grid on
xlabel('Time(s)') 
ylabel('Velocity-y')
legend('X-real','X-hat21','X-hat31','X-hat41')

sgtitle('estimation error of different sensors')
