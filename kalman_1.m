
function [X_hat,P_M,X_bar,P_P,X_plus,X_min] = kalman_1(Z,R,Q,H,x0,P0,time,A_dis)
         K=zeros(4,2,time+1);P_M(:,:,1)=P0;
         K(:,:,1)=P_M(:,:,1)*H'*inv(R);
         X_hat(:,1)=x0;X_bar(:,1)=[0;0;0;0];P_P(:,:,1)=zeros(4,4);
         X_plus(:,1)=X_hat(:,1)+sqrt(diag(P0));
         X_min(:,1)= X_hat(:,1)-sqrt(diag(P0));
    for i=1:time
    % prior update
    X_bar(:,i+1)=A_dis*X_hat(:,i);
    P_P(:,:,i+1)=A_dis*P_M(:,:,i)*A_dis'+Q;
    % post update
    P_M(:,:,i+1)=inv(inv(P_P(:,:,i+1))+H'*inv(R)*H);
    K(:,:,i+1)=P_M(:,:,i+1)*H'*inv(R);
    X_hat(:,i+1)=X_bar(:,i+1)+K(:,:,i+1)*(Z(:,i+1)-H*X_bar(:,i+1));
    X_plus(:,i+1)=X_hat(:,i+1)+sqrt(diag(P_M(:,:,i+1)));
    X_min(:,i+1)= X_hat(:,i+1)-sqrt(diag(P_M(:,:,i+1)));
    end
end