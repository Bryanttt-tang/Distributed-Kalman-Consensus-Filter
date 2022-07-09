%kalman filter for stationary sensors
function [X_hat,P_M,X_bar,P_P,X_plus,X_min] = kalman_1(R,Q,H,x0,P0,time,A_dis,X_tar,X_sen)
         K=zeros(4,2,time+1);P_M(:,:,1)=P0;
         % d0=norm(X_tar([1 2],1)-X_sen([1 2],1));
         Rtr=(R)^2;
         %dydx=(X_tar(2,1)-X_sen(2))/(X_tar(1,1)-X_sen(1)); %dy/dx
         theta=atan2(X_tar(2,1)-X_sen(2,1),X_tar(1,1)-X_sen(1,1));
         Rxy = Rrt2Rxy_2(Rtr, theta);
         K(:,:,1)=P_M(:,:,1)*H'*inv(Rxy);
         X_hat(:,1)=x0;X_bar(:,1)=[0;0;0;0];P_P(:,:,1)=zeros(4,4);
         X_plus(:,1)=X_hat(:,1)+sqrt(diag(P0));
         X_min(:,1)= X_hat(:,1)-sqrt(diag(P0));
    for i=1:time
    % prior update
    X_bar(:,i+1)=A_dis*X_hat(:,i);
    P_P(:,:,i+1)=A_dis*P_M(:,:,i)*A_dis'+Q;
    % post update
    %d=norm(X_tar([1 2],i+1)-X_sen([1 2],i+1)); % distance between target and sensor
    Rtr=(R)^2;
    theta=atan2(X_tar(2,i+1)-X_sen(2,i+1),X_tar(1,i+1)-X_sen(1,i+1));
    Rxy = Rrt2Rxy_2(Rtr, theta); %real time covirance matrix of w
    Z(:,i+1)=X_tar([1 2],i)+[normrnd(0,Rxy(1,1));normrnd(0,Rxy(2,2))]; % measurement is modeled as X_tar+w
    P_M(:,:,i+1)=inv(inv(P_P(:,:,i+1))+H'*inv(Rxy)*H);
    K(:,:,i+1)=P_M(:,:,i+1)*H'*inv(Rxy);
    X_hat(:,i+1)=X_bar(:,i+1)+K(:,:,i+1)*(Z(:,i+1)-H*X_bar(:,i+1));
    X_plus(:,i+1)=X_hat(:,i+1)+sqrt(diag(P_M(:,:,i+1)));
    X_min(:,i+1)= X_hat(:,i+1)-sqrt(diag(P_M(:,:,i+1)));
    end
end