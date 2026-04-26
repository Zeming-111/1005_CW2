% Zeming WU
% ssyzw32@nottingham.edu.cn


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [5 MARKS]

% c) Arduino Communication
% My Arduino port is COM 8
clear a
a = arduino("COM8","Uno");

% Define LED digital pin
ledPin = "D8";

% Blink the LED at 0.5 s intervals
for i = 1:10
    writeDigitalPin(a, ledPin, 1);   % ON
    pause(0.5);

    writeDigitalPin(a, ledPin, 0);   % OFF
    pause(0.5);
end

% LED is off at the end
writeDigitalPin(a, ledPin, 0);

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

% TASK 1(a) - Define Arduino analogue pin for the MCP9700A temperature sensor
tempPin = "A0";     % use A0 for the temperature sensor

% TASK 1(b) - Using duration to control time when recording temperature
% Acquisition duration in seconds
duration = 600;     % 10min

% Create arrays for time, voltage and temperature
timeData = zeros(duration + 1, 1);
voltageData = zeros(duration + 1, 1);
tempData = zeros(duration + 1, 1);

% MCP9700A sensor constants
% According to MCP9700A typical output:
% V0 = 0.5 V at 0 degC
% Temperature coefficient = 0.01 V/degC
V0 = 0.5;      
TC = 0.01;     

% Start data acquisition
disp("Starting temperature data acquisition...");

for i = 1:(duration + 1)

    % Current time in seconds
    timeData(i) = i - 1;

    % Read voltage from sensor
    voltageData(i) = readVoltage(a, tempPin);

    % Convert voltage to temperature
    tempData(i) = (voltageData(i) - V0) / TC;

    % Wait approximately 1 second before next reading
    pause(1);
end

disp("Temperature Recording Finished");

% Calculate statistics
maxTemp = max(tempData);
minTemp = min(tempData);
avgTemp = mean(tempData);

% TASK 1(c) - Plot temperature vs time

figure;
plot(timeData, tempData, 'LineWidth', 1.5);
grid on;

xlabel('Time (s)');
ylabel('Temperature (C)');

% save figure
saveas(gcf, 'temperature_plot.png');

% TASK 1(d) - Print to command window

% Record location and time
location = 'Nottingham';
todayDate = datestr(now, 'dd/mm/yyyy'); 

outputText = sprintf('Data logging initiated - %s\n', todayDate);
outputText = [outputText sprintf('Location - %s\n\n', location)];

for m = 0:10
    
    idx = m*60 + 1;   % pick every minute
    
    outputText = [outputText sprintf('Minute %d\n', m)];
    outputText = [outputText sprintf('Temperature %.2f C\n\n', tempData(idx))];
    
end

outputText = [outputText sprintf('Max temp %.2f C\n', maxTemp)];
outputText = [outputText sprintf('Min temp %.2f C\n', minTemp)];
outputText = [outputText sprintf('Average temp %.2f C\n', avgTemp)];
outputText = [outputText sprintf('Data logging terminated\n')];

fprintf('%s', outputText);

% TASK 1(e) - Write to txt file

fileID = fopen('capsule_temperature.txt', 'w');

if fileID == -1
    error('File could not be opened.');
end

fprintf(fileID, '%s', outputText);

fclose(fileID);
%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

temp_monitor(a);


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [30 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert answers here