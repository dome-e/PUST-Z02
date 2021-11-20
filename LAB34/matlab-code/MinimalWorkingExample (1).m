    addpath('D:\SerialCommunication'); % add a path to the functions
    initSerialControl COM3 % initialise com port
    
    imax = 1000;
    i = 1;
    
    W1 = 0;
    G1 = 0;
    Z = 0;
    pom3 = zeros(1, 1000);
    figure(1)
    while(i < imax + 1)
       
        %% obtaining measurements
        measurements1 = readMeasurements(1); % read measurements from 1 to 7
        measurements3 = readMeasurements(3);
        %% processing of the measurements and new control values calculation

        %% sending new values of control signals
        sendControls(1, W1);
                 
        sendControlsToG1AndDisturbance(G1, Z);
        
         measurement = readMeasurements(1:1)
         pom3(i) = measurement;
         i = i + 1;
         
         plot(pom3);
         drawnow;
        %% synchronising with the control process
        waitForNewIteration(); % wait for new batch of measurements to be ready
    end