lab2_zad3_z; % s1, s2, s3, ... i s1_z, s2_z, s3_z, ...

imax = 1500;
% param
% N = 40; Nu = 1; lambda = 10;
% param opt
N = 32; Nu = 1; lambda = 0.01;
D = 300;

% proba 1
% N = 32; Nu = 1; lambda = 0.01;
% D = 300;

% pp
Upp = 27; Ypp = 27.75;
% ogr
Umin = 0 - Upp; Umax = 100 - Upp; dUmax = 5;

% init
Yzad = Ypp * ones(N, 1);
Y = zeros(imax, 1);
U = zeros(imax, 1);
M = zeros(N, Nu);
Mp = zeros(N, D-1);
dUp = zeros(D-1, 1);
dU = zeros(Nu, 1);
Y0 = zeros(N, 1);
I = eye(Nu);

Yzad(1:11) = Ypp;
Yzad(12:300) = 29;
Yzad(301:600) = 30;
Yzad(601:900) = 29;
Yzad(901:1200) = 27;
Yzad(1201:imax) = Ypp;

yzad = Yzad - Ypp;
u = U - Upp;
y = zeros(imax, 1);
e = zeros(imax ,1);

Ydmc = zeros(N,1);
Ydmc_zad = zeros(N,1);

for i = 1:Nu
    M(i:N,i) = s(1:N-i+1);
end

for i=1:(D-1)
    Mp(1:N,i)=s(i+1:N+i)-s(i);
end

K = (M'*M + lambda*I)^-1*M';

k = 2;
U(1) = Upp;
Y(1) = Ypp;

while(k < imax)
    Y(k) = readMeasurements(1);
    readMeasurements(1)
    
    y(k) = Y(k) - Ypp;
    e(k) = Yzad(k) - Y(k);
   
    Ydmc_zad(1:N) = yzad(k);
    Ydmc(1:N) = y(k);
    
    Y0 = Ydmc + Mp*dUp;
    dU = K*(Ydmc_zad - Y0);
    du = dU(1);
    
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
    
    waitForNewIteration(); % wait for new batch of measurements to be ready
    
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
    %xlabel('k');
    %legend('y','y_z_a_d','Location','southeast');
    drawnow;
    hold off
end

E = (norm(e))^2;
