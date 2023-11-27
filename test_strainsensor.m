clear, clc % Clear the workspace and command window to start fresh
close all % Close all open figure windows

a = arduino(); % Establish a connection with the Arduino board
iteration = 500; % Set the number of iterations for data collection
v1 = zeros(iteration,3); % Preallocate a matrix to store voltage readings from 3 channels
t = zeros(iteration,1); % Preallocate a vector to store time/iteration indices
tic; % Start a timer to measure the duration of data collection

% Begin a loop that runs for the specified number of iterations
for i = 1: iteration
    fprintf('i: %d\n', i) % Display the current iteration number

    % Read and store the voltage from the first channel (A0) of the Arduino
    v1(i,1) = readVoltage(a, 'A0');

    % Read and store the voltage from the second channel (A1)
    v1(i,2) = readVoltage(a, 'A1');

    % Read and store the voltage from the third channel (A2)
    v1(i,3) = readVoltage(a, 'A2');

    % Store the current iteration number in the time vector
    t(i,1) = i;
end % End of the loop

toc; % Stop the timer and display the elapsed time

save("strain_calib_90.mat") % Save the collected data to a MATLAB data file for later use
load("strain_calib_45.mat") % Load the data file containing the variables 't' and 'v1'

figure() % Create a new figure for plotting
plot(t, v1) % Plot the voltage readings 'v1' against the iterations 't'
hold on % Hold the current plot to add more plots on the same figure

% Plot a line representing the mean voltage at intervals of 100 iterations
% with a red line and a line width of 3
plot(0:100:iteration, ones(51) * mean(v1), 'r', 'LineWidth', 3)

sum = 0; % Initialize a variable to calculate the sum for RMSE

% Begin a loop to calculate the sum of squared differences from the mean
for i = 1: iteration
    sum = sum + ((mean(v1) - v1(i))^2) / iteration; % Update sum with squared difference
end % End of the loop

rmse = sqrt(sum); % Calculate the root mean square error (RMSE)

% Set the title of the plot
title('strain sensor calibration at displacement = 0')

% Label the x-axis as 'iteration (n)'
xlabel('iteration (n)')

% Label the y-axis as 'voltage (v)'
ylabel('voltage (v)')

% Add a legend to the plot with labels for each data series
legend('Experimental Data', 'Mean=1.33 v')

