Upp=0;
Ypp=0;
Zskok=1;
imax = 250;

%Parametry dobrane eksperymentalnie
D=120; %D z poprzedniego podpunktu
N=25; 
Nu=1; %szczegolnie wazna jest mala liczba Nu
lambda=0.18; %po zmniejszeniu Lambdy lepiej dziala na szum 

% init
Y = zeros(imax, 1);
U = zeros(imax, 1);
Yzad = zeros(imax,1);
Z = zeros(imax,1);
M = zeros(N, Nu);
Mp = zeros(N, D-1);
dUp = zeros(D-1, 1);
dU = zeros(Nu, 1);
Y0 = zeros(N, 1);
I = eye(Nu);
U(1:11) = Upp;
Yzad(1:9)=0;
Yzad(10:imax)=1;

% Do Zad. 5:
% Z(10:imax) = Zskok;

% Do Zad. 6:
Z(10:imax)=  Zskok + 0.1*sin(20*linspace(0,1,imax-9));

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

K = (M'*M + lambda*I)^(-1)*M';

for k = 10:imax
    Y(k)=symulacja_obiektu2y_p2(U(k-5),U(k-6),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
    y(k) = Y(k) - Ypp;
    e(k) = Yzad(k) - Y(k);
   
    Ydmc_zad(1:N) = Yzad(k);
    Ydmc(1:N) = y(k);
    
    Y0 = Ydmc + Mp*dUp;
    
    dU = K*(Ydmc_zad - Y0);
    du = dU(1);
    
    for n = D-1:-1:2
      dUp(n,1) = dUp(n-1,1);
    end
    dUp(1) = du;
    
    u(k) = u(k-1) + du;
    
    U(k) = u(k) + Upp;
    
end

E = (norm(e))^2

f9 = figure;
subplot(3,1,1);
stairs(U);
title('u(k)');
xlabel('k');
ylabel('u');
subplot(3,1,2);
stairs(Z);
title('Z(k)');
xlabel('k');
ylabel('Z');
subplot(3,1,3);
stairs(Y);
title('Y(k) i Y_z_a_d');
hold on;
stairs(Yzad);
xlabel('k');
legend('y','y_z_a_d','Location','southeast');

f10 = figure;
stairs(Z);
title('Pomiar zak³óceñ');
xlabel('k');
ylabel('Z');


