%kalman consensus filter (sub-optimal)
function [X_hat,P_M,X_bar,P_P,X_plus,X_min] = kalman_consensus(R,Q,H,x0,P0,time,A_dis,B_dis,X_tar,X_sen)
         Ki=zeros(4,2,time+1);P_M(:,:,1)=P0;
        % compute R(k) with respect to distance
         d0=norm(X_tar([1 2],1)-X_sen([1 2]));
         Rtr=(d0*R)^2;
         theta=atan2(X_tar(2,1)-X_sen(2),X_tar(1,1)-X_sen(1));
         Rxy = Rrt2Rxy_2(Rtr, theta);
         
         Ki(:,:,1)=P_M(:,:,1)*H'*inv(Rxy);
         X_hat(:,1)=x0;X_bar(:,1)=[0;0;0;0];P_P(:,:,1)=zeros(4,4);
         X_plus(:,1)=X_hat(:,1)+sqrt(diag(P0));
         X_min(:,1)= X_hat(:,1)-sqrt(diag(P0));
    for i=1:time
     for n=1:4 % number of UAVs
       % prior update
       X_bar(n,:,i+1)=A_dis*X_hat(n,:,i);
    
       P_P(:,:,i+1)=A_dis*P_M(:,:,i)*A_dis'+B_dis*Q*B_dis';
     end
    % post update
    d=norm(X_tar([1 2],i+1)-X_sen([1 2])); % distance between target and sensor
    Rtr=(d*R)^2;
    theta=atan2(X_tar(2,i+1)-X_sen(2),X_tar(1,i+1)-X_sen(1));
    Rxy = Rrt2Rxy_2(Rtr, theta); %real time covirance matrix of w
    Z(:,i+1)=X_tar([1 2],i+1)+[normrnd(0,Rxy(1,1));normrnd(0,Rxy(2,2))]; % measurement is modeled as X_tar+w
 
     Ki(:,:,i+1)=P_P(:,:,i+1)*H'*inv(Rxy+H*P_P(:,:,i+1)*H'); 
    for n=1:4 
   
    X_hat(n,:,i+1)=X_bar(n,:,i+1)+Ki(:,:,i+1)*(Z(:,i+1)-H*X_bar(:,i+1))+Ci*();
    end
    F=eye(4)-Ki*H;  % F=I-K*H
    P_M(:,:,i+1)=F*P_P(:,:,i+1)*F'+Ki(:,:,i+1)*Rxy*Ki(:,:,i+1)';
    X_plus(:,i+1)=X_hat(:,i+1)+sqrt(diag(P_M(:,:,i+1)));
    X_min(:,i+1)= X_hat(:,i+1)-sqrt(diag(P_M(:,:,i+1)));
    end
end