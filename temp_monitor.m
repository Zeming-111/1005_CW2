function temp_monitor(a)

% temp_monitor
% simple function to read temperature and control LEDs

% pins
tempPin = "A0";
greenLED = "D8";
yellowLED = "D9";
redLED = "D10";

% MCP9700A constants
V0 = 0.5;
TC = 0.01;

% storage for plotting
timeData = [];
tempData = [];

t = 0;

figure;

while true
    
    % read voltage
    v = readVoltage(a, tempPin);
    
    % convert to temperature
    T = (v - V0)/TC;
    
    % store data
    timeData(end+1) = t;
    tempData(end+1) = T;
    
    % update plot
    plot(timeData, tempData, 'LineWidth', 1.5);
    xlabel('Time (s)');
    ylabel('Temperature (C)');
    grid on;
    
    xlim([max(0,t-50) t+1]);
    
    drawnow;
    
    % LED control
    if T >= 18 && T <= 24
        
        % green ON
        writeDigitalPin(a, greenLED, 1);
        writeDigitalPin(a, yellowLED, 0);
        writeDigitalPin(a, redLED, 0);
        
        pause(1);
        
    elseif T < 18
        
        % yellow blink 0.5s
        writeDigitalPin(a, greenLED, 0);
        writeDigitalPin(a, redLED, 0);
        
        writeDigitalPin(a, yellowLED, 1);
        pause(0.5);
        writeDigitalPin(a, yellowLED, 0);
        pause(0.5);
        
    else
        
        % red blink 0.25s
        writeDigitalPin(a, greenLED, 0);
        writeDigitalPin(a, yellowLED, 0);
        
        writeDigitalPin(a, redLED, 1);
        pause(0.25);
        writeDigitalPin(a, redLED, 0);
        pause(0.25);
        
    end
    
    t = t + 1;
    
end

end