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

temp_prediction(a);


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% During this coursework, I developed a system that uses MATLAB and Arduino to monitor temperature and control LEDs in real time. In the test part,the green LED was accidentally damaged by me. This was because the resistor was not properly connected. One of the main challenges I faced was setting up the hardware correctly, especially the temperature sensor. At the beginning, I obtained unrealistic temperature values(above 100 degC), which I later realised were caused by incorrect wiring. After fixing the connections, the readings became stable and matched the expected room temperature range.

% Another difficulty was implementing the continuous monitoring functions in Task 2 and Task 3. Managing the timing for data acquisition, plotting and LED control at the same time required careful use of loops and pause functions. I also needed to ensure that the plot updated smoothly using drawnow without slowing down the program.

% A strength of my project is that the system works reliably in real time. The temperature data can be visualised clearly, and the LED indicators respond correctly under different conditions. In Task 3, I implemented a simple method to estimate the rate of temperature change and predict future temperature values. Although the method is basic, it is effective and easy to understand.

% However, there are some limitations. The temperature readings can still be affected by noise, and the prediction assumes a constant rate of change, which may not be accurate in real situations. In addition, the system relies on simple threshold-based logic and does not consider more advanced control strategies.

% For future improvements, I would consider applying filtering techniques to reduce noise and using more advanced prediction methods. It would also be interesting to integrate data logging with visualisation in a single interface or develop a more user-friendly display system.