zad4_s; % s1, s2, s3, ... 

imax = 1500;

N1 = D1; Nu1 = D1;
N2 = D2; Nu2 = D2;
N3 = D3; Nu3 = D3;
lambda = 1;

% pp
Upp = 27;
Ypp = 31.81;
% ogr
Umin = 0 - Upp; Umax = 100 - Upp; dUmax = 5;

% init
Y = zeros(imax, 1);
U = zeros(imax, 1);
Yzad1 = Ypp * ones(N1, 1);
Yzad2 = Ypp * ones(N2, 1);
Yzad3 = Ypp * ones(N3, 1);
M1 = zeros(N1, Nu1);
M2 = zeros(N2, Nu2);
M3 = zeros(N3, Nu3);
Mp1 = zeros(N, D1-1);
Mp2 = zeros(N, D2-1);
Mp3 = zeros(N, D3-1);
dUp1 = zeros(D1-1, 1);
dUp2 = zeros(D2-1, 1);
dUp3 = zeros(D3-1, 1);
dU1 = zeros(Nu1, 1);
dU2 = zeros(Nu2, 1);
dU3 = zeros(Nu3, 1);
Y01 = zeros(N1, 1);
Y02 = zeros(N2, 1);
Y03 = zeros(N3, 1);
I1 = eye(Nu1);
I2 = eye(Nu2);
I3 = eye(Nu3);
% - - -

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

Ydmc1 = zeros(N1,1);
Ydmc_zad1 = zeros(N1,1);
Ydmc2 = zeros(N2,1);
Ydmc_zad2 = zeros(N2,1);
Ydmc3 = zeros(N3,1);
Ydmc_zad3 = zeros(N3,1);

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
    Mp1(1:N,i)=s(i+1:N+i)-s(i);
end

for i=1:(D-1)
    Mp1(1:N,i)=s(i+1:N+i)-s(i);
end

% - - -

K1 = (M1'*M1 + lambda*I1)^-1*M1';
K2 = (M2'*M2 + lambda*I2)^-1*M2';
K3 = (M3'*M3 + lambda*I3)^-1*M3';

k = 2;
U(1) = Upp;
Y(1) = Ypp;

while(k < imax)
    Y(k) = readMeasurements(1);
    readMeasurements(1)
    
    y(k) = Y(k) - Ypp;
    e(k) = Yzad(k) - Y(k);
    
    % U <0, 40)
    if u(k) < 40
        Ydmc_zad1(1:N1) = yzad(k);
        Ydmc1(1:N1) = y(k);
        
        Y01 = Ydmc1 + Mp1*dUp1;
        dU1 = K1*(Ydmc_zad1 - Y01);
        du = dU1(1); 
    end
    
    % U <40, 60)
    
    if u(k) >= 40 && u(k) < 60
        Ydmc_zad2(1:N2) = yzad(k);
        Ydmc2(1:N2) = y(k);
        
        Y02 = Ydmc2 + Mp2*dUp2;
        dU2 = K2*(Ydmc_zad2 - Y02);
        du = dU2(1);          
    end
   
    % U <60, 100>
   
    if u(k) >= 60
        Ydmc_zad3(1:N3) = yzad(k);
        Ydmc3(1:N3) = y(k);
 
        Y03 = Ydmc3 + Mp3*dUp3;
        dU3 = K3*(Ydmc_zad3- Y03);
        du = dU3(1);          
    end
    
    % ogr du
    if du > dUmax
        du = dUmax;
    end
    
    if du < -dUmax
        du = -dUmax;
    end
    
    if u(k) < 40
      for n = D1-1:-1:2
        dUp1(n,1) = dUp1(n-1,1);
      end
      dUp1(1) = du;
    end

    if u(k) >= 40 && u(k) < 60
      for n = D2-1:-1:2
        dUp2(n,1) = dUp2(n-1,1);
      end
      dUp2(1) = du;
    end
        
    if u(k) >= 60
      for n = D3-1:-1:2
        dUp3(n,1) = dUp3(n-1,1);
      end
      dUp3(1) = du;
    end

%     for n = D-1:-1:2
%       dUp(n,1) = dUp(n-1,1);
%     end
%     dUp(1) = du;
    
    u(k) = u(k-1) + du;
    
    % ogr umin, umax
    
    if u(k) > Umax
        u(k) = Umax;
        dUp1(1) = u(k) - u(k-1);
        dUp2(1) = u(k) - u(k-1);
        dUp3(1) = u(k) - u(k-1);
    end
    if u(k) < Umin
        u(k) = Umin;
        dUp1(1) = u(k) - u(k-1);
        dUp2(1) = u(k) - u(k-1);
        dUp3(1) = u(k) - u(k-1);
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

E = (norm(e))^2;
