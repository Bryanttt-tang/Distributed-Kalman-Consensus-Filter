%DKCF (sub-optimal)
% the number of UAV is n_sen+1
% we output X_hat as a tensor, which contains estimate from all the sensors
%X_tar is still 1d, X_sen is n_sen dimensional
K,P_P,P_M的更新还没写好
function [X_hat,P_M,X_bar,P_P,X_plus,X_min] = DKCF(R,Q_til,H,x0,P0,time,A_dis,X_tar,X_sen,n_sen)
         Ki=zeros(4,2,time+1,n_sen); gamma=0.5;
        H_sta=blkdiag((H,H,H); A_til=kron(eye(n_sen),A_dis);
        d0=[norm(X_tar([1 2],1)-X_sen([1 2],1,1));norm(X_tar([1 2],1)-X_sen([1 2],1,2));norm(X_tar([1 2],1)-X_sen([1 2],1,3))];
%initialization
 for n=1:n_sen
     P_M(:,:,1,n)=P0;
     % compute R(k) with respect to distance
     Rtr(:,:,n)=(d0(n)*R)^2;
     theta(n)=atan2(X_tar(2,1)-X_sen(2,1,n),X_tar(1,1)-X_sen(1,1,n));
         Rxy(:,:,n) = Rrt2Rxy_2(Rtr(:,:,n), theta(n));
      
     %Ki(:,:,1,n)=P_M(:,:,1,n)*H'*inv(Rxy(:,:,n));
     X_hat([4*n-3:4*n],1)=x0; X_bar([4*n-3:4*n],1)=[0;0;0;0];P_P(:,:,1,n)=zeros(4,4);
%      X_plus(:,1,n)=X_hat(:,1,n)+sqrt(diag(P0));
%      X_min(:,1,n)= X_hat(:,1,n)-sqrt(diag(P0));
 end        
 % update loop
  for i=1:time
     for n=1:n_sen % assume the target cannot sense its own state
       % prior update
       X_bar([4*n-3:4*n],i+1)=A_dis*X_hat([4*n-3:4*n],i); % X_bar, X_hat stacked column-wise
%        sumX_bar=sum(X_bar,3);% sum of all sensor's X_bar 
       P_P(:,:,i+1,n)=A_til*P_M(:,:,i,n)*A_til'+Q_til;
     
    % post update
    d(n)=norm(X_tar([1 2],i+1)-X_sen([1 2],i+1,n)); % distance between target and sensor
    Rtr(:,:,n)=(d(n)*R)^2;
    theta(n)=atan2(X_tar(2,i+1)-X_sen(2,i+1,n),X_tar(1,i+1)-X_sen(1,i+1,n));
    Rxy(:,:,n) = Rrt2Rxy_2(Rtr(:,:,n), theta(n)); %real time covirance matrix of w
    Z([2*n-1:2*n],i+1)=X_tar([1 2],i+1)+[normrnd(0,Rxy(1,1,n));normrnd(0,Rxy(2,2,n))]; % measurement is modeled as X_tar+w
 
     
    Ki(:,:,i+1,n)=P_P(:,:,i+1,n)*H'*inv(Rxy(:,:,n)+H*P_P(:,:,i+1,n)*H'); 
  %   Ci(:,:,n)=gamma*P_P(:,:,i+1,n);
     end
    Lg=con_fil(d', 4, n_sen);
    for n=1:n_sen
    X_hat([4*n-3:4*n],i+1)=X_bar([4*n-3:4*n],i+1)+Ki(:,:,i+1,n)*(Z([2*n-1:2*n],i+1)-H*X_bar([4*n-3:4*n],i+1))-gamma*Lg*X_bar([4*n-3:4*n],i+1);
    
    F=eye(4*n_sen)- Ki(:,:,i+1,n)*H_sta;  % F=I-K*H
    P_M(:,:,i+1,n)=F(:,:,n)*P_P(:,:,i+1,n)*F(:,:,n)'+Ki(:,:,i+1,n)*Rxy(:,:,n)*Ki(:,:,i+1,n)';
%     X_plus(:,i+1,n)=X_hat(:,i+1,n)+sqrt(diag(P_M(:,:,i+1,n)));
%     X_min(:,i+1,n)= X_hat(:,i+1,n)-sqrt(diag(P_M(:,:,i+1,n)));
    end
  end
end