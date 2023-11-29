clear, clc % Clear the workspace and command window to start fresh
close all % Close all open figure windows

a = arduino(); % Establish a connection with the Arduino board
iteration = 500; % Set the number of iterations for data collection
v = zeros(iteration,1); % Preallocate a matrix to store voltage readings from 3 channels
t = zeros(iteration,1); % Preallocate a vector to store time/iteration indices
tic; % Start a timer to measure the duration of data collection

% Begin a loop that runs for the specified number of iterations
for i = 1: iteration
    fprintf('i: %d\n', i) % Display the current iteration number

    % Read and store the voltage from the third channel (A2)
    v(i,1) = readVoltage(a, 'A2');

    % Store the current iteration number in the time vector
    t(i,1) = i;
end % End of the loop

toc; % Stop the timer and display the elapsed time
% Plot a line representing the mean voltage at intervals of 100 iterations
% with a red line and a line width of 3
figure()
plot(t,v, 'LineWidth', 2.5)
hold on
plot(0:10:iteration, ones(51) * mean(v), 'r', 'LineWidth', 2.5)

sum = 0; % Initialize a variable to calculate the sum for RMSE

% Begin a loop to calculate the sum of squared differences from the mean
for i = 1: iteration
    sum = sum + ((mean(v) - v(i))^2) / iteration; % Update sum with squared difference
end % End of the loop

rmse = sqrt(sum) % Calculate the root mean square error (RMSE)

% Set the title of the plot
title('Strain sensor calibration at 80 deg', 'FontSize',15)

% Label the x-axis as 'iteration (n)'
xlabel('Iteration (n)', 'FontSize',13)

% Label the y-axis as 'voltage (v)'
ylabel('Voltage (V)', 'FontSize',13)

% Add a legend to the plot with labels for each data series
legend({'Experimental Data', 'Mean = 0.3067V (RMSE = 0.0015V)'}, 'FontSize',12, 'Location','southeast')

save('flex1_80.mat')