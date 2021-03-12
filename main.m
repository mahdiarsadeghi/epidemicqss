% Computation program of the research paper "Long
% -term regulation of prolonged epidemic outbreaks in 
% large populations via adaptive control: a singular 
% perturbation approach", by Muhammad Ali Al-Radhawi, 
% Mahdiar Sadeghi, Eduardo Sontag.

% Make sure to add path the bin folder and stay on
% the main folder for running this code. 

% Close all;
clear all;
clc

% Fitting Epidemic QSS Model
newyork                            
disp('Fitted Parameters (g,K,a,k0) for NY:')
disp(q(1:4))

unitedkingdom                            
disp('Fitted Parameters (g,K,a,k0) for UK:')
disp(q(1:4))

germany                           
disp('Fitted Parameters (g,K,a,k0) for Germany:')
disp(q(1:4))