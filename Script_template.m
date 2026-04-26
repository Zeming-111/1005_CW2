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
tempPin = "A0";

% TASK 1(b) - Using duration to control time when recording temperature
% Acquisition duration in seconds
duration = 600;     %10min

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

disp("Temperature data acquisition completed.");

% Calculate statistics
maxTemp = max(tempData);
minTemp = min(tempData);
avgTemp = mean(tempData);

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Insert answers here


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [30 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert answers here