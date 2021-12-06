zad4_s; % s1, s2, s3, ... 

addpath('D:\SerialCommunication'); % add a path to the functions
initSerialControl COM3 % initialise com port
imax = 1200;

D = max([D1, D2, D3]);
N = D; Nu = D;
lambda = 1;

% pp
Upp = 27;
Ypp = 32.12;
% ogr
Umin = 0 - Upp; Umax = 100 - Upp; dUmax = 20;

% init
Y = zeros(imax, 1);
% U = zeros(imax, 1);
U = Upp * ones(imax, 1);
Yzad = Ypp * ones(N, 1);
M1 = zeros(N, Nu);
M2 = zeros(N, Nu);
M3 = zeros(N, Nu);
Mp1 = zeros(N, D-1);
Mp2 = zeros(N, D-1);
Mp3 = zeros(N, D-1);
dUp = zeros(D-1, 1);
dU = zeros(Nu, 1);
Y01 = zeros(N, 1);
Y02 = zeros(N, 1);
Y03 = zeros(N, 1);
I = eye(Nu);
% - - -

Yzad(1:300) = Ypp;
Yzad(301:600) = Ypp + 5;
Yzad(601:900) = Ypp + 15;
Yzad(901:imax) = Ypp;

yzad = Yzad - Ypp;
u = U - Upp;
y = zeros(imax, 1);
e = zeros(imax ,1);

Ydmc = zeros(N,1);
Ydmc_zad = zeros(N,1);

% M

for i = 1:Nu
    M1(i:N,i) = s1(1:N-i+1);
end

for i = 1:Nu
    M2(i:N,i) = s2(1:N-i+1);
end

for i = 1:Nu
    M3(i:N,i) = s3(1:N-i+1);
end

% - - -


% Mp

for i=1:(D-1)
    Mp1(1:N,i)=s1(i+1:N+i)-s1(i);
end

for i=1:(D-1)
    Mp2(1:N,i)=s2(i+1:N+i)-s2(i);
end

for i=1:(D-1)
    Mp3(1:N,i)=s3(i+1:N+i)-s3(i);
end

% - - -

K1 = (M1'*M1 + lambda*I)^-1*M1';
K2 = (M2'*M2 + lambda*I)^-1*M2';
K3 = (M3'*M3 + lambda*I)^-1*M3';

k = 2;
U(1) = Upp;
U(2) = Upp;
Y(1) = Ypp;


while(k < imax)
    Y(k) = readMeasurements(1);
    readMeasurements(1)
    
    y(k) = Y(k) - Ypp;
    e(k) = Yzad(k) - Y(k);
    
    Ydmc_zad(1:N) = yzad(k);
    Ydmc(1:N) = y(k);
    
    us1 = Umin;
    us2 = Umax/2;
    us3 = Umax;
    w1 = gbellmf(U(k-1), [(Umax - Umin)/3 2 us1]);
    w2 = gbellmf(U(k-1), [(Umax - Umin)/3 2 us2]);
    w3 = gbellmf(U(k-1), [(Umax - Umin)/3 2 us3]);
       
    w = w1 + w2 + w3;
    
    Ydmc(1:N) = y(k);
    
    Y01 = Ydmc + Mp1*dUp;
    Y02 = Ydmc + Mp2*dUp;
    Y03 = Ydmc + Mp3*dUp;
    dU = K1*(Ydmc_zad - Y01)*w1 + K2*(Ydmc_zad - Y02)*w2 + K3*(Ydmc_zad - Y03)*w3;
    du = dU(1)/w;    
    
    
    % ogr du
    if du > dUmax
        du = dUmax;
    end
    
    if du < -dUmax
        du = -dUmax;
    end

    for n = D-1:-1:2
      dUp(n,1) = dUp(n-1,1);
    end
    dUp(1) = du;
    
    u(k) = u(k-1) + du;
    
    % ogr umin, umax
    
    if u(k) > Umax
        u(k) = Umax;
        dUp(1) = u(k) - u(k-1);
    end
    if u(k) < Umin
        u(k) = Umin;
        dUp(1) = u(k) - u(k-1);
    end
    
    U(k) = u(k) + Upp;
    
    sendControls([ 1, 5],[ 50, U(k)]);
    
    k = k + 1;
    
    waitForNewIteration();
    
    subplot(2,1,1);
    plot(U);
    title('u(k)');
    xlabel('k');
    ylabel('u');

    subplot(2,1,2);
    plot(Y);
    hold on

    title('Y(k) i Y_z_a_d');
    stairs(Yzad);
    drawnow;
    hold off
end
% Uw = 0:0.5:100;
% wekt_w1 = gbellmf(Uw, [(Umax - Umin)/6 2 0]);
% wekt_w2 = gbellmf(Uw, [(Umax - Umin)/6 2 50]);
% wekt_w3 = gbellmf(Uw, [(Umax - Umin)/6 2 100]);
% hold on
% plot(Uw, wekt_w1)
% plot(Uw, wekt_w2)
% plot(Uw, wekt_w3)
% hold off
E = (norm(e))^2;
