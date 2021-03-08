clc
clear all

J = 0.01;
b = 0.1;
K = 0.01;
R = 1;
L = 0.5;

A = [-b/J   K/J
    -K/L   -R/L];
B = [0
    1/L];
C = [1   0];
D = 0;
motor_ss = ss(A,B,C,D);

% 步长
h = 0.001;
% 仿真步数
L = 10/h;

u = 1*ones(L+1,1);
u0 = 0;
xrk0 = zeros(2,1);
xer0 = zeros(2,1);

I = eye(2);

for i = 1:L
    time(i) = i*h;
    
    % 后向欧拉法，更新单步
    %xer = xer0 + h * (A * xer0 + B * u0);
    xer = inv(I - h*A) * (xer0 + h * B * u(i));
    yer(i) = C * xer;
    
    % 更新数据，将当前值作为初值，便于下一次更新
    xer0 = xer;
    u0 = u(i);
end


for i = 1:L
    time(i) = i*h;
    
    % runge_kutta龙格库塔法迭代公式
    k1 = A * xrk0 + B * u0;
    k2 = A * (xrk0 + h * k1/2) + B * u0;
    k3 = A * (xrk0 + h * k2/2) + B * u0;
    k4 = A * (xrk0 + h * k3) + B * u(i);
    xrk = xrk0 + h * (k1 + 2 * k2 + 2 * k3 + k4)/6;
    yrk(i) = C * xrk;
    
    % 更新数据
    xrk0 = xrk;
    u0 = u(i);
end

plot(time,yer,'b',time,yrk,'r');