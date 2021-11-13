function E = pro_dmc(P)
odp_skokowa_DMC;

imax = 1500;
% param
N = P(1); Nu = P(2);
lambda = P(3);
% pp
Upp = 0.9; Ypp = 3;
% ogr
Umin = 0.6 - Upp; Umax = 1.2 - Upp; dUmax = 0.1;

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
U(1:11) = Upp;
Y(1:11) = Ypp;

Yzad(1:11) = Ypp;
Yzad(12:300) = 3.5;
Yzad(301:600) = 3.1;
Yzad(601:900) = 2.9;
Yzad(901:1200) = 2.5;
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

for k = 12:imax
    Y(k) = symulacja_obiektu2Y_p1(U(k-10), U(k-11), Y(k-1), Y(k-2));
    y(k) = Y(k) - Ypp;
    % e(k) = yzad(k)-y(k);
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
    
end

E = (norm(e))^2;

subplot(2,1,1)
stairs(U);
xlabel("k");
ylabel("U");
subplot(2,1,2)
stairs(Yzad);
hold on
stairs(Y);
xlabel("k");
ylabel("Y");
legend("Yzad", "Y")
hold off
end

