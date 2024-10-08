close all
clear all
clc

training_data_path = "..\Ball_And_Beam\System_Identification\Matlab_Scripts\Black_Box\TestData.csv";
validatio_data_path = "..\Ball_And_Beam\System_Identification\Matlab_Scripts\Black_Box\ValidationData.csv";

T = readtable(training_data_path, 'ReadVariableNames', true);
training_data = iddata(T.Angles, T.PWM, 0.01);


net = cascadeforwardnet([2,3,4,3,2]);
N2 = neuralnet(net);
sys = nlarx(training_data, [4 4 0], N2);
disp('Estimation is done')

% Validate against test data
figure(1);
compare(training_data, sys);

figure(2);
resid(training_data, sys);


% Validate against validation data
T = readtable(validatio_data_path, 'ReadVariableNames', true);
validatio_data = iddata(T.Angles, T.PWM, 0.01);

figure(3);
compare(validatio_data, sys);

figure(4);
resid(validatio_data, sys);
