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

% Insert answers here

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Insert answers here


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [30 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert answers here