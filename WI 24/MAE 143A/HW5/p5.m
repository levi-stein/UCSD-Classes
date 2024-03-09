clear; close all; clc;
f = 2*(1-cos(pi/10))/((pi/10)*sin(pi/10));
C = 2/(f*pi/10);
D = RR_tf([(-C - 1) (C-1)],[(3*C+2) (-3*C +2)]);