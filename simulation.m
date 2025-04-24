close all;
clc;
clear;

% -------------------------------------------------------------------------
% Load CSV data with only X and Y positions
filename = "imu_trajectory.csv";
data = readmatrix(filename);  % Assumes two columns: [x, y]

% Extract X and Y, assign Z = 0 for flat plane
x = data(:,1);
y = data(:,2);
z = zeros(size(x));
posPlot = [x y z];

% Dummy unit quaternions for flat path (no orientation)
quatPlot = repmat([1 0 0 0], length(x), 1);

% Animation settings
sampleRate = 100;              % Hz
samplePeriod = 1 / sampleRate;
SamplePlotFreq = 1;            % Ultra slow
Spin = 10;                     % Gentle camera movement

% -------------------------------------------------------------------------
% Infinite loop for repeating animation
while true
    SixDofAnimation(posPlot, quatern2rotMat(quatPlot), ...
        'SamplePlotFreq', SamplePlotFreq, 'Trail', 'All', ...
        'Position', [300 100 800 600], ...
        'View', [(20:(Spin/(length(posPlot)-1)):(20+Spin))', 20*ones(length(posPlot), 1)], ...
        'AxisLength', 0.02, ...
        'ShowArrowHead', false, ...
        'Xlabel', 'X (m)', 'Ylabel', 'Y (m)', 'Zlabel', 'Z (m)', ...
        'ShowLegend', false, 'CreateAVI', false, ...
        'AVIfileNameEnum', false, 'AVIfps', ((1/samplePeriod) / SamplePlotFreq));
    
    % Optional pause between loops
    pause(1);  % Adjust or remove if not needed
    close(gcf); % Close the previous figure to reset
end
