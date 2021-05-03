% Computation program of the research paper "Long
% -term regulation of prolonged epidemic outbreaks in 
% large populations via adaptive control: a singular 
% perturbation approach", by Muhammad Ali Al-Radhawi, 
% Mahdiar Sadeghi, Eduardo Sontag.

% Make sure to add path the bin folder and stay on
% the main folder for running this code. 

clear all
clc

% American States
df  = readmatrix('US.csv');
txt = string(table2cell(readtable('US.csv')));

state = "New York";
n = 2;
population = 19.5/n;
maxdays = 200;
key = txt(:,7)==state;  
data = sum(df(key,12:end),1)/n;
q = qssfit(data, population, maxdays, state, n);
disp(join(['Fitted Parameters (g,K,a,u,I0,b0) for ' state]))
disp(q(1:6))

state = "New Jersey";
population = 8.88;
maxdays = 200;
key = txt(:,7)==state;  
data = sum(df(key,12:end),1);
q = qssfit(data, population, maxdays, state,1);
disp(join(['Fitted Parameters (g,K,a,u,I0,b0) for ' state]))
disp(q(1:6))

state = "Massachusetts";
population = 6.9;
maxdays = 230;
key = txt(:,7)==state;  
data = sum(df(key,12:end),1);
q = qssfit(data, population, maxdays, state,1);
disp(join(['Fitted Parameters (g,K,a,u,I0,b0) for ' state]))
disp(q(1:6))

state = "Arizona";
population = 7.27;
maxdays = 200;
key = txt(:,7)==state;  
data = sum(df(key,12:end),1);
q = qssfit(data, population, maxdays, state,1);
disp(join(['Fitted Parameters (g,K,a,u,I0,b0) for ' state]))
disp(q(1:6))

state = "South Dakota";
population = .88;
maxdays = 350;
key = txt(:,7)==state;  
data = sum(df(key,12:end),1);
q = qssfit(data, population, maxdays, state,1);
disp(join(['Fitted Parameters (g,K,a,u,I0,b0) for ' state]))
disp(q(1:6))

state = "North Dakota";
population = .76;
maxdays = 350;
key = txt(:,7)==state;  
data = sum(df(key,12:end),1);
q = qssfit(data, population, maxdays, state,1);
disp(join(['Fitted Parameters (g,K,a,u,I0,b0) for ' state]))
disp(q(1:6))

% Countries
df  = readmatrix('data.csv');
txt = string(table2cell(readtable('data.csv')));

country = "Germany";
n = 3;
population = 83/n;
maxdays = 160;
key = txt(:,2)==country;  
data = df(key,5:end)/n;
q = qssfit(data, population, maxdays, country, n);
disp(join(['Fitted Parameters (g,K,a,u,I0,b0) for ' country]))
disp(q(1:6))


country = "Belgium";
population = 11.5;
maxdays = 185;
key = txt(:,2)==country; 
data = df(key,5:end);
q = qssfit(data, population, maxdays, country,1);
disp(join(['Fitted Parameters (g,K,a,u,I0,b0) for ' country]))
disp(q(1:6))

country = "Qatar";
population = 2.8;
maxdays = 320;
key = txt(:,2)==country; 
data = df(key,5:end);
q = qssfit(data, population, maxdays, country, 1);
disp(join(['Fitted Parameters (g,K,a,u,I0,b0) for ' country]))
disp(q(1:6))

country = "Norway";
population = 5.3;
maxdays = 200;
key = txt(:,2)==country; 
data = df(key,5:end);
q = qssfit(data, population, maxdays, country,1);
disp(join(['Fitted Parameters (g,K,a,u,I0,b0) for ' country]))
disp(q(1:6))

country = "Finland";
population = 5.3;
maxdays = 200;
key = txt(:,2)==country; 
data = df(key,5:end);
q = qssfit(data, population, maxdays, country,1);
disp(join(['Fitted Parameters (g,K,a,u,I0,b0) for ' country]))
disp(q(1:6))

country = "New Zealand";
population = 4.9;
maxdays = 350;
key = txt(:,2)==country; 
data = df(key,5:end);
q = qssfit(data, population, maxdays, country,1);
disp(join(['Fitted Parameters (g,K,a,u,I0,b0) for ' country]))
disp(q(1:6))

country = "Chile";
population = 19;
maxdays = 150;
key = txt(:,2)==country; 
data = df(key,5:end);
q = qssfit(data, population, maxdays, country,1);
disp(join(['Fitted Parameters (g,K,a,u,I0,b0) for ' country]))
disp(q(1:6))

country = "Afghanistan";
n = 2;
population = 38/3;
maxdays = 200;
key = txt(:,2)==country;  
data = df(key,5:end)/n;
q = qssfit(data, population, maxdays, country, n);
disp(join(['Fitted Parameters (g,K,a,u,I0,b0) for ' country]))
disp(q(1:6))

country = "Egypt";
n = 5;
population = 100/n;
maxdays = 320;
key = txt(:,2)==country; 
data = df(key,5:end)/n;
q = qssfit(data, population, maxdays, country,n);
disp(join(['Fitted Parameters (g,K,a,u,I0,b0) for ' country]))
disp(q(1:6))

country = "Saudi Arabia";
n = 3;
population = 34.3/n;
maxdays = 350;
key = txt(:,2)==country; 
data = df(key,5:end)/n;
q = qssfit(data, population, maxdays, country, n);
disp(join(['Fitted Parameters (g,K,a,u,I0,b0) for ' country]))
disp(q(1:6))