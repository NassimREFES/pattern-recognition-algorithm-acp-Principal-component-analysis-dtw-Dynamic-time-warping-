clear all;
clc;

T = [5 6 2 1 4; 5 4 4 0 6];
A = [2 3 4; 3 3.5 4];
B = [6 5;8 7]; 

% A=[1 0 0; 0 1 0; 0 0 1];
% B=[1 0 1 ; 0 1 1 ; 1 1 0];
% T=[1 0 1 ; 0 1 0 ; 0 1 1 ];

disp(sprintf('taux de dissemblance = %.2f\n', taux_de_dissemblance(T, A)));
disp(sprintf('taux de dissemblance = %.2f', taux_de_dissemblance(T, B)));

  