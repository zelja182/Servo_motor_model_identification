close all
clear all
clc

test_data = "..\Ball_And_Beam\System_Identification\Matlab_Scripts\Black_Box\TestData.csv";
validatio_data = "..\Ball_And_Beam\System_Identification\Matlab_Scripts\Black_Box\ValidationData.csv";

T = readtable(test_data, 'ReadVariableNames', true);
tst_data = iddata(T.Angles, T.PWM, 0.01);

net = cascadeforwardnet([2,3,4,3,2]);
N2 = neuralnet(net);
sys = nlarx(tst_data, [4 4 0], N2);
disp('Estimation is done')

% Validate against test data
figure(1);
compare(tst_data, sys);

figure(2);
resid(tst_data, sys);


% Validate against validation data
T = readtable(validatio_data, 'ReadVariableNames', true);
val_data = iddata(T.Angles, T.PWM, 0.01);

figure(3);
compare(val_data, sys);

figure(4);
resid(val_data, sys);

