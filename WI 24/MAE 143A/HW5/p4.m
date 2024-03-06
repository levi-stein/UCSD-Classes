close all; clear; clc;
G = RR_tf([-3 -2],[1 5 4 0]);
[p,d,k,n] = RR_partial_fraction_expansion(G);