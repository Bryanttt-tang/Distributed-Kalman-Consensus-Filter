%kalman consensus filter (sub-optimal)
% the number of UAV is n_sen+1
% we output X_hat as a tensor, which contains estimate from all the sensors
%X_tar is still 1d, X_sen is n_sen dimensional
function [X_hat,P_M,X_bar,P_P,X_plus,X_min] = kalman_consensus(R,Q,H,x0,P0,time,A_dis,X_tar,X_sen,n_sen)
         Ki=zeros(4,2,time+1,n_sen); gamma=0.1;
        % compute R(k) with respect to distance
         d0=[norm(X_tar([1 2],1)-X_sen([1 2],1,1));norm(X_tar([1 2],1)-X_sen([1 2],1,2));norm(X_tar([1 2],1)-X_sen([1 2],1,3))];
%          Rtr=(d0*R)^2;
%          theta=atan2(X_tar(2,1)-X_sen(2),X_tar(1,1)-X_sen(1));
%          Rxy = Rrt2Rxy_2(Rtr, theta);
      
% initialization
% P_M(:,:,1,1)=P0;P_M(:,:,1,2)=P0;P_M(:,:,1,3)=P0;
% Ki(:,:,1,1)=P_M(:,:,1,1)*H'*inv(R);Ki(:,:,1,2)=P_M(:,:,1,2)*H'*inv(R);Ki(:,:,1,3)=P_M(:,:,1,3)*H'*inv(R);
%  X_hat(:,1,1)=x0; X_hat(:,1,2)=x0;  X_hat(:,1,3)=x0;
 for n=1:n_sen
     P_M(:,:,1,n)=P0;
     Ki(:,:,1,n)=P_M(:,:,1,n)*H'*inv(R);
     X_hat(:,1,n)=x0; X_bar(:,1,n)=[0;0;0;0];P_P(:,:,1,n)=zeros(4,4);
     X_plus(:,1,n)=X_hat(:,1,n)+sqrt(diag(P0));
     X_min(:,1,n)= X_hat(:,1,n)-sqrt(diag(P0));
 end        
 % update loop
  for i=1:time
     for n=1:n_sen % assume the target cannot sense its own state
       % prior update
       X_bar(:,i+1,n)=A_dis*X_hat(:,i,n);
       sumX_bar=sum(X_bar,3);% sum of all sensor's X_bar 
       P_P(:,:,i+1,n)=A_dis*P_M(:,:,i,n)*A_dis'+Q;
     
    % post update
%     d=norm(X_tar([1 2],i+1)-X_sen([1 2])); % distance between target and sensor
%     Rtr=(d*R)^2;
%     theta=atan2(X_tar(2,i+1)-X_sen(2),X_tar(1,i+1)-X_sen(1));
%     Rxy = Rrt2Rxy_2(Rtr, theta); %real time covirance matrix of w
    Z(:,i+1,n)=X_tar([1 2],i+1)+[normrnd(0,R(1,1));normrnd(0,R(2,2))]; % measurement is modeled as X_tar+w
 
     Ki(:,:,i+1,n)=P_P(:,:,i+1,n)*H'*inv(R+H*P_P(:,:,i+1,n)*H'); 
     Ci(:,:,n)=gamma*P_P(:,:,i+1,n);
    end
    for n=1:n_sen
   
    X_hat(:,i+1,n)=X_bar(:,i+1,n)+Ki(:,:,i+1,n)*(Z(:,i+1,n)-H*X_bar(:,i+1,n))+Ci(:,:,n)*(sumX_bar(:,i+1)-(n_sen+1)*X_bar(:,i+1,n));
    
    F(:,:,n)=eye(4)- Ki(:,:,i+1,n)*H;  % F=I-K*H
    P_M(:,:,i+1,n)=F(:,:,n)*P_P(:,:,i+1,n)*F(:,:,n)'+Ki(:,:,i+1,n)*R*Ki(:,:,i+1,n)';
    X_plus(:,i+1,n)=X_hat(:,i+1,n)+sqrt(diag(P_M(:,:,i+1,n)));
    X_min(:,i+1,n)= X_hat(:,i+1,n)-sqrt(diag(P_M(:,:,i+1,n)));
    end
  end
end