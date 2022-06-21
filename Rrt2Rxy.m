% convert variance matrix from polar to cartesian
% param:  sigma_r, deviation in distance (0.02d)
%         sigma_t, deviation in angle (0.01d)
%         theta, relative angle between target and sensor (dy/dx)


function Rxy = Rrt2Rxy(Rrt, theta)
%c11 = cos(theta)^2/sigma_r^2 + sin(theta)^2/sigma_r^2;
%c22 = sin(theta)^2/sigma_r^2 + cos(theta)^2/sigma_r^2;
%c12 = cos(theta)*sin(theta)*(1/sigma_r^2 - 1/sigma_t^2);
%Rxy = [1/c11, 1/c12;1/c12, 1/c22];

R = [cos(theta), -sin(theta); sin(theta), cos(theta)];
Rxy = R*Rrt*R';
end
