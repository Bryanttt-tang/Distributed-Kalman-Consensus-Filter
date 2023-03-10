%compare the result of different sensors on the same target
function plot_R(t_vec,X_real,X_hat,k,eps,gamma)
if k==1 % plot comparison of kalman filter
    

elseif k==0 % plot comparison of kalman consensus filter
    figure (6)
 subplot(2,2,1)
plot(t_vec,X_real(1,:),'color','k');
hold on
plot(t_vec,X_hat(1,:,1),':','color','b');
hold on
plot(t_vec,X_hat(1,:,2),'--','color',[0.1,0.7,0.2]);
hold on
plot(t_vec,X_hat(1,:,3),'-.','color','r');
grid on
xlabel('Time[s]','fontsize', 22) 
ylabel('$\mathbf{x}$-Position', 'Interpreter', 'latex','fontsize', 22)
ylim([-0.8 -0]);
yticks([-0.8:0.2:0]);
a = get(gca,'XTickLabel');  
set(gca,'XTickLabel',a,'fontsize',18)
set(gca,'XTickLabelMode','auto')
legend({'$x_{real}$','$\hat{x}_{1}$','$\hat{x}_{2}$','$\hat{x}_{3}$'}, 'Interpreter', 'latex','fontsize', 18)

subplot(2,2,2)
plot(t_vec,X_real(2,:),'color','k');
hold on
plot(t_vec,X_hat(2,:,1),':','color','b');
hold on
plot(t_vec,X_hat(2,:,2),'--','color',[0.1,0.7,0.2]);
hold on
plot(t_vec,X_hat(2,:,3),'-.','color','r');
grid on
xlabel('Time[s]','fontsize', 22) 
ylabel('$\mathbf{y}$-Position', 'Interpreter', 'latex','fontsize', 22)
xlim([0 30])
ylim([0.2 1.8]);
yticks([0.2:0.4:1.8])
a = get(gca,'XTickLabel');  
set(gca,'XTickLabel',a,'fontsize',18)
set(gca,'XTickLabelMode','auto')
legend({'$x_{real}$','$\hat{x}_{1}$','$\hat{x}_{2}$','$\hat{x}_{3}$'}, 'Interpreter', 'latex','fontsize', 18)

subplot(2,2,3)
plot(t_vec,X_real(3,:),'color','k');
hold on
plot(t_vec,X_hat(3,:,1),':','color','b');
hold on
plot(t_vec,X_hat(3,:,2),'--','color',[0.1,0.7,0.2]);
hold on
plot(t_vec,X_hat(3,:,3),'-.','color','r');
grid on
xlabel('Time[s]','fontsize', 22) 
ylabel('$\mathbf{x}$-Velocity','Interpreter', 'latex','fontsize', 22)
xlim([0 30])
%ylim([-0.45 0.45]);
a = get(gca,'XTickLabel');  
set(gca,'XTickLabel',a,'fontsize',18)
set(gca,'XTickLabelMode','auto')
legend({'$x_{real}$','$\hat{x}_{1}$','$\hat{x}_{2}$','$\hat{x}_{3}$'}, 'Interpreter', 'latex','fontsize', 18)

subplot(2,2,4)
plot(t_vec,X_real(4,:),'color','k');
hold on
plot(t_vec,X_hat(4,:,1),':','color','b');
hold on
plot(t_vec,X_hat(4,:,2),'--','color',[0.1,0.7,0.2]);
hold on
plot(t_vec,X_hat(4,:,3),'-.','color','r');
grid on
xlabel('Time[s]','fontsize', 22) 
ylabel('$\mathbf{y}$-Velocity','Interpreter', 'latex','fontsize', 22)
xlim([0 30])
%ylim([-0.45 0.45]);
a = get(gca,'XTickLabel');  
set(gca,'XTickLabel',a,'fontsize',18)
set(gca,'XTickLabelMode','auto')
legend({'$x_{real}$','$\hat{x}_{1}$','$\hat{x}_{2}$','$\hat{x}_{3}$'}, 'Interpreter', 'latex','fontsize', 18)
% str_1 = sprintf('Estimation of different sensors using KCF, eps = %d', eps);
% sgtitle(str_1)
set(gcf, 'Position',  [0, 0, 600, 250])

else % plot comparison of DKCF
    figure (7)
subplot(2,2,1)
plot(t_vec,X_real(1,:),'color','k');
hold on
plot(t_vec,X_hat(1,:),':','color','b');
hold on
plot(t_vec,X_hat(5,:),'--','color',[0.1,0.7,0.2]);
hold on
plot(t_vec,X_hat(9,:),'-.','color','r');
grid on
xlabel('Time[s]','fontsize', 22) 
ylabel('$\mathbf{x}$-Position', 'Interpreter', 'latex','fontsize', 22)
xlim([0 30])
ylim([-0.8 -0]);
yticks([-0.8:0.2:0]);
a = get(gca,'XTickLabel');  
set(gca,'XTickLabel',a,'fontsize',18)
set(gca,'XTickLabelMode','auto')
legend({'$x_{real}$','$\hat{x}_{1}$','$\hat{x}_{2}$','$\hat{x}_{3}$'}, 'Interpreter', 'latex','fontsize', 18)

subplot(2,2,2)
plot(t_vec,X_real(2,:),'color','k');
hold on
plot(t_vec,X_hat(2,:),':','color','b');
hold on
plot(t_vec,X_hat(6,:),'--','color',[0.1,0.7,0.2]);
hold on
plot(t_vec,X_hat(10,:),'-.','color','r');
grid on
xlabel('Time[s]','fontsize', 22) 
ylabel('$\mathbf{y}$-Position', 'Interpreter', 'latex','fontsize', 22)
xlim([0 30])
ylim([0.2 1.8]);
yticks([0.2:0.4:1.8])
a = get(gca,'XTickLabel');  
set(gca,'XTickLabel',a,'fontsize',18)
set(gca,'XTickLabelMode','auto')
legend({'$x_{real}$','$\hat{x}_{1}$','$\hat{x}_{2}$','$\hat{x}_{3}$'}, 'Interpreter', 'latex','fontsize', 18)

subplot(2,2,3)
plot(t_vec,X_real(3,:),'color','k');
hold on
plot(t_vec,X_hat(3,:),':','color',[0 0 1]);
hold on
plot(t_vec,X_hat(7,:),'--','color',[0.1,0.7,0.2]);
hold on
plot(t_vec,X_hat(11,:),'-.','color','r');
grid on
xlabel('Time[s]','fontsize', 22) 
ylabel('$\mathbf{x}$-Velocity','Interpreter', 'latex','fontsize', 22)
xlim([0 30])
%ylim([-0.45 0.45]);
a = get(gca,'XTickLabel');  
set(gca,'XTickLabel',a,'fontsize',18)
set(gca,'XTickLabelMode','auto')
legend({'$x_{real}$','$\hat{x}_{1}$','$\hat{x}_{2}$','$\hat{x}_{3}$'}, 'Interpreter', 'latex','fontsize', 18)

subplot(2,2,4)
plot(t_vec,X_real(4,:),'color','k');
hold on
plot(t_vec,X_hat(4,:),':','color','b');
hold on
plot(t_vec,X_hat(8,:),'--','color',[0.1,0.7,0.2]);
hold on
plot(t_vec,X_hat(12,:),'-.','color','r');
grid on
xlabel('Time[s]','fontsize', 22) 
ylabel('$\mathbf{y}$-Velocity','Interpreter', 'latex','fontsize', 22)
xlim([0 30])
%ylim([-0.45 0.45]);
a = get(gca,'XTickLabel');  
set(gca,'XTickLabel',a,'fontsize',18)
set(gca,'XTickLabelMode','auto')
legend({'$x_{real}$','$\hat{x}_{1}$','$\hat{x}_{2}$','$\hat{x}_{3}$'}, 'Interpreter', 'latex','fontsize', 18)
set(gcf, 'Position',  [0, 0, 600, 250])

%str_2 = sprintf('Comparison of different sensors using DKCF, gamma = ',num2str(gamma));
%sgtitle(['Comparison of different sensors using DKCF, gamma = ',num2str(gamma),'  --(no consensus)'],'FontSize', 16)
end
end
