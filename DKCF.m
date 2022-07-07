%DKCF (sub-optimal)
% the number of UAV is n_sen+1
% we output X_hat as a tensor, which contains estimate from all the sensors
%X_tar is still 1d, X_sen is n_sen dimensional

function [X_hat,P_M_sta,X_bar,P_P_sta,X_plus,X_min] = DKCF(R,Q_til,H,x0,P0,time,A_dis,X_tar,X_sen,n_sen,gamma)
         Ki=zeros(4,2,time+1,n_sen);
         H_sta=blkdiag(H,H,H); A_til=kron(eye(n_sen),A_dis);
        d0=[norm(X_tar([1 2],1)-X_sen([1 2],1,1));norm(X_tar([1 2],1)-X_sen([1 2],1,2));norm(X_tar([1 2],1)-X_sen([1 2],1,3))];
%initialization
 for n=1:n_sen
     P_M_sta(:,:,1)=blkdiag(P0,P0,P0); 
     % compute R(k) with respect to distance
     Rtr(:,:,n)=(d0(n)*R)^2;
     theta(n)=atan2(X_tar(2,1)-X_sen(2,1,n),X_tar(1,1)-X_sen(1,1,n));
         Rxy(:,:,n) = Rrt2Rxy_2(Rtr(:,:,n), theta(n));
      
     %Ki(:,:,1,n)=P_M(:,:,1,n)*H'*inv(Rxy(:,:,n));
     X_hat([4*n-3:4*n],1)=x0; X_bar([4*n-3:4*n],1)=[0;0;0;0];P_P_sta(:,:,1)=zeros(4*n_sen,4*n_sen);
      
 end  
      X_plus(:,1)=X_hat(:,1)+sqrt(diag(P_M_sta(:,:,1)));
      X_min(:,1)= X_hat(:,1)-sqrt(diag(P_M_sta(:,:,1)));
 % update loop
  for i=1:time
     
       % prior update
       X_bar(:,i+1)=A_til*X_hat(:,i);
       %X_bar([4*n-3:4*n],i+1)=A_dis*X_hat([4*n-3:4*n],i); % X_bar, X_hat stacked column-wise
%        sumX_bar=sum(X_bar,3);% sum of all sensor's X_bar 
       P_P_sta(:,:,i+1)=A_til*P_M_sta(:,:,i)*A_til'+Q_til;
     
    % post update
    %calculate time-varying distance
    for n=1:n_sen % assume the target cannot sense its own state
      d(n)=norm(X_tar([1 2],i+1)-X_sen([1 2],i+1,n)); % distance between target and sensor
      Rtr(:,:,n)=(d(n)*R)^2;
      theta(n)=atan2(X_tar(2,i+1)-X_sen(2,i+1,n),X_tar(1,i+1)-X_sen(1,i+1,n));
      Rxy(:,:,n) = Rrt2Rxy_2(Rtr(:,:,n), theta(n)); %real time covirance matrix of w
      Z([2*n-1:2*n],i+1)=X_tar([1 2],i+1)+[normrnd(0,Rxy(1,1,n));normrnd(0,Rxy(2,2,n))]; % measurement is modeled as X_tar+w
      R_sta=blkdiag(Rxy(:,:,1),Rxy(:,:,2),Rxy(:,:,3)); 
    
    
  %  Ki(:,:,i+1,n)=P_P(:,:,i+1,n)*H'*inv(Rxy(:,:,n)+H*P_P(:,:,i+1,n)*H'); 
     end
    Lg=con_fil(d', 4, n_sen);
    K(:,:,i+1)=P_P_sta(:,:,i+1)*H_sta'*inv(R_sta+H_sta*P_P_sta(:,:,i+1)*H_sta'); %R_sta is 2n*2n matrix
    X_hat(:,i+1)=X_bar(:,i+1)+K(:,:,i+1)*(Z(:,i+1)-H_sta*X_bar(:,i+1))-gamma*Lg*X_bar(:,i+1);
    
    F=eye(4*n_sen)- K(:,:,i+1)*H_sta;  % F=I-K*H
    P_M_sta(:,:,i+1)=F*P_P_sta(:,:,i+1)*F'+K(:,:,i+1)*R_sta*K(:,:,i+1)';
    X_plus(:,i+1)=X_hat(:,i+1)+sqrt(diag(P_M_sta(:,:,i+1)));
    X_min(:,i+1)= X_hat(:,i+1)-sqrt(diag(P_M_sta(:,:,i+1)));
   
  end
end