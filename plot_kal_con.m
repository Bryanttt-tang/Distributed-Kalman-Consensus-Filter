function plot_kal_con(t_vec,X_real,X_hat,X_plus,X_min,n_sen)
% average the estimate of all sensors
X_ave=sum(X_hat,3)/n_sen; X_plus_ave=sum(X_plus,3)/n_sen; X_min_ave=sum(X_min,3)/n_sen;
figure(3)
subplot(2,2,1)
plot(t_vec,X_real(1,:));
hold on
plot(t_vec,X_ave(1,:),':');
hold on
plot(t_vec,X_plus_ave(1,:),'--','Color','r');
hold on
plot(t_vec,X_min_ave(1,:),'--','Color','r');
grid on
xlabel('Time[s]') 
ylabel('$\mathbf{x}$-Position', 'Interpreter', 'latex')
xlim([0 30])
legend({'$x_{real}$','$\hat{x}$','$\hat{x}$ +/-1 STD'}, 'Interpreter', 'latex')

subplot(2,2,2)
plot(t_vec,X_real(2,:));
hold on
plot(t_vec,X_ave(2,:),':');
plot(t_vec,X_plus_ave(2,:),'--','Color','r');
hold on
plot(t_vec,X_min_ave(2,:),'--','Color','r');
grid on
xlabel('Time[s]') 
ylabel('$\mathbf{y}$-Position', 'Interpreter', 'latex')
xlim([0 30])
legend({'$x_{real}$','$\hat{x}$','$\hat{x}$ +/-1 STD'}, 'Interpreter', 'latex')

subplot(2,2,3)
plot(t_vec,X_real(3,:));
hold on
plot(t_vec,X_ave(3,:),':');
plot(t_vec,X_plus_ave(3,:),'--','Color','r');
hold on
plot(t_vec,X_min_ave(3,:),'--','Color','r');
grid on
xlabel('Time[s]') 
ylabel('$\mathbf{x}$-Velocity','Interpreter', 'latex')
xlim([0 30])
legend({'$x_{real}$','$\hat{x}$','$\hat{x}$ +/-1 STD'}, 'Interpreter', 'latex')

subplot(2,2,4)
plot(t_vec,X_real(4,:));
hold on
plot(t_vec,X_ave(4,:),':');
plot(t_vec,X_plus_ave(4,:),'--','Color','r');
hold on
plot(t_vec,X_min_ave(4,:),'--','Color','r');
grid on
xlabel('Time[s]') 
ylabel('$\mathbf{y}$-Velocity','Interpreter', 'latex')
xlim([0 30])
legend({'$x_{real}$','$\hat{x}$','$\hat{x}$ +/-1 STD'}, 'Interpreter', 'latex')

%sgtitle('Estimation using suboptimal KCF','FontSize', 16)
end