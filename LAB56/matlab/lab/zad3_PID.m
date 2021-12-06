addpath('D:\SerialCommunication'); % add a path to the functions
initSerialControl COM3 % initialise com port



Upp = 27; % G1
Ypp = 31.81 ; % T1  % jednak inn niz 32.52 bo inny dzien

Umax = 100;
Umin = 0;

n = 800;

delta_Umax = 20;

U = zeros(1,n);
Y = zeros(1,n);
Y(1, 1:n) = Ypp;



% Y zadane
Yzad(1:200) = Ypp;
Yzad(201:400) = Ypp + 5;
Yzad(401:600) = Ypp + 15;
Yzad(601:n) = Ypp;

u = U - Upp;
yzad = Yzad - Ypp;

y = zeros(1,n);
y(1, 1:n) = Ypp;
e = zeros(1,n);

%
K = 24;
Ti = inf;
Td = 0;
%
Tp = 1;

r0 = K*(1 + Tp/(2*Ti) + Td/Tp);
r1 = K*(-1 + Tp/(2*Ti) - 2*Td/Tp);
r2 = K*Td/Tp;
figure(1);


k = 3;
Y(1,1:2) = readMeasurements(1);

while(1)
    Y(k) = readMeasurements(1);
    readMeasurements(1)
  
    y(k) = Y(k) - Ypp;
    e(k) = yzad(k) - y(k); %Uchyb

    delta_U = r2*e(k-2)+r1*e(k-1)+r0*e(k);  % u(k) - u(k-1)
     
    if delta_U > delta_Umax
        delta_U = delta_Umax;
    end
    if delta_U < -delta_Umax
        delta_U = -delta_Umax;
    end
    
    u(k) = delta_U + u(k-1); 
    
    if u(k) > Umax
        u(k) = Umax;
    end
    if u(k) < Umin
        u(k) = Umin;
    end
    
    U(k) = u(k) + Upp; % u=U-Upp
    
    sendControls( 1, 50);
    sendNonlinearControls(U(k)),

    waitForNewIteration(); % wait for new batch of measurements to be ready
    
    % E = E + (norm(e(k)))^2; % wskaznik regulacji
    
    k = k + 1;
   
    subplot(2,1,1);
    plot(U);
    title('u(k)');
    xlabel('k');
    ylabel('u');
    
    subplot(2,1,2);
    plot(Y);

    title('Y(k) i Y_z_a_d');
    % stairs(Yzad);
    %xlabel('k');
    %legend('y','y_z_a_d','Location','southeast');
    drawnow;
end


    
