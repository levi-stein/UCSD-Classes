clear all; close all; clc;
%% Problem 1
% F = RR_tf([1 -1],[1 1]); figure(1); RR_bode(F);
%% Problem 2
w = 1;
F2a = RR_tf([w^2],[1 .77*w w^2]);
F2b = RR_tf([w^2],[1 1.85*w w^2]);
F4 = F2a*F2b;
RR_step(F4)

%% Problem 3
