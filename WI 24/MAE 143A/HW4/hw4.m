clear all; close all; clc;
%% Problem 1
F = RR_tf([1 -1],[1 1]); figure(1); RR_bode(F); figure(2); RR_step(F);
%% Problem 2
w = 1;
F2a = RR_tf([w^2],[1 .77*w w^2]); figure(3); RR_bode(F2a);
F2b = RR_tf([w^2],[1 1.85*w w^2]); figure(4); RR_bode(F2b);
F4 = F2a*F2b;
figure(5);
RR_step(F4);
figure(6); RR_bode(F4);
