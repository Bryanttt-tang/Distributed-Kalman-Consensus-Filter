function plot_k1(t_vec,X_real,X_hat,X_plus,X_min)
figure(2)
subplot(2,2,1)
plot(t_vec,X_real(1,:));
hold on
plot(t_vec,X_hat(1,:),':');
hold on
plot(t_vec,X_plus(1,:),'--','Color','r');
hold on
plot(t_vec,X_min(1,:),'--','Color','r');
grid on
xlabel('Time(s)') 
ylabel('Position-x')
xlim([0 50])
legend('X-real','X-hat','X-hat +/-1 STD')

subplot(2,2,2)
plot(t_vec,X_real(2,:));
hold on
plot(t_vec,X_hat(2,:),':');
plot(t_vec,X_plus(2,:),'--','Color','r');
hold on
plot(t_vec,X_min(2,:),'--','Color','r');
grid on
xlabel('Time(s)') 
ylabel('Position-y')
xlim([0 50])
legend('X-real','X-hat','X-hat +/-1 STD')

subplot(2,2,3)
plot(t_vec,X_real(3,:));
hold on
plot(t_vec,X_hat(3,:),':');
plot(t_vec,X_plus(3,:),'--','Color','r');
hold on
plot(t_vec,X_min(3,:),'--','Color','r');
grid on
xlabel('Time(s)') 
ylabel('Velocity-x')
xlim([0 50])
legend('X-real','X-hat','X-hat +/-1 STD')

subplot(2,2,4)
plot(t_vec,X_real(4,:));
hold on
plot(t_vec,X_hat(4,:),':');
plot(t_vec,X_plus(4,:),'--','Color','r');
hold on
plot(t_vec,X_min(4,:),'--','Color','r');
grid on
xlabel('Time(s)') 
ylabel('Velocity-y')
xlim([0 50])
legend('X-real','X-hat','X-hat +/-1 STD')

sgtitle('Estimation of target dynamics using local Kalman filter')
end
