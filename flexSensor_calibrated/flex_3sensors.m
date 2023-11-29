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
