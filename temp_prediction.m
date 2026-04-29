function temp_prediction(a)

% temp_prediction
% read temperature, estimate rate, predict future temp and control LEDs

tempPin = "A0";

greenLED = "D8";
yellowLED = "D9";
redLED = "D10";

% sensor constants
V0 = 0.5;
TC = 0.01;

timeData = [];
tempData = [];

t = 0;

while true
    
    % read voltage
    v = readVoltage(a, tempPin);
    
    % convert to temperature
    T = (v - V0)/TC;
    
    % store data
    timeData(end+1) = t;
    tempData(end+1) = T;
    
    % calculate rate (simple smoothing)
    if length(tempData) > 5
        
        dT = tempData(end) - tempData(end-5);
        dt = timeData(end) - timeData(end-5);
        
        rate = dT/dt;    % C/s
        
    else
        rate = 0;
    end
    
    % convert to C/min
    rate_min = rate * 60;
    
    % predict after 5 minutes (300 s)
    T_pred = T + rate * 300;
    
    % print info
    fprintf('T = %.2f C\n', T);
    fprintf('Rate = %.2f C/min\n', rate_min);
    fprintf('Predicted (5 min) = %.2f C\n\n', T_pred);
    
    % LED logic
    if rate_min > 4
        
        % fast increase
        writeDigitalPin(a, redLED, 1);
        writeDigitalPin(a, yellowLED, 0);
        writeDigitalPin(a, greenLED, 0);
        
    elseif rate_min < -4
        
        % fast decrease
        writeDigitalPin(a, redLED, 0);
        writeDigitalPin(a, yellowLED, 1);
        writeDigitalPin(a, greenLED, 0);
        
    elseif T >= 18 && T <= 24
        
        % stable and comfortable
        writeDigitalPin(a, redLED, 0);
        writeDigitalPin(a, yellowLED, 0);
        writeDigitalPin(a, greenLED, 1);
        
    else
        
        % out of range but not changing fast
        writeDigitalPin(a, redLED, 0);
        writeDigitalPin(a, yellowLED, 0);
        writeDigitalPin(a, greenLED, 0);
        
    end
    
    pause(1);
    
    t = t + 1;
    
end

end