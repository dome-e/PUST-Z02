clear all;

n=500; %Okres symulacji
Upp=0;
Ypp=0;
Us=1;
U(1:n)=Upp;
Y(1:n)=Ypp;


U(1:n)=Upp;
Y(1:n)=Ypp;
Y_zad(1:10) = Ypp;
Y_zad(10:100) = 4;
Y_zad(101:200) = 2;
Y_zad(201:300)= 0.5;
Y_zad(301:400)= 4.5;
Y_zad(401:500)= 3;
s=odp_skok(Us);

D=30;
N=21;
Nu=3;
lambda=0.17;

M = zeros(N, Nu);
Mp = zeros(N, D-1);
dUp = zeros(D-1, 1);
dU = zeros(Nu, 1);
Y0 = zeros(N, 1);
I = eye(Nu);
U(1:11) = Upp;

u = U - Upp;
y = zeros(n, 1);
e = zeros(n ,1);


Ydmc = zeros(N,1);
Ydmc_zad = zeros(N,1);

for i = 1:Nu
    M(i:N,i) = s(1:N-i+1);
end

for i=1:(D-1)
    Mp(1:N,i)=s(i+1:N+i)-s(i);
end

K = (M'*M + lambda*I)^(-1)*M';

for k = 10:n
    Y(k)=symulacja_obiektu2y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2));
    y(k) = Y(k) - Ypp;
    e(k) = Y_zad(k) - Y(k);
    Ydmc_zad(1:N) = Y_zad(k);
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


subplot(2,1,1);
stairs(U);
% title('u(k)');
xlabel('k');
ylabel('U');
subplot(2,1,2); 
stairs(Y);
% title('Y(k) i Y_z_a_d');
hold on;
stairs(Y_zad);
xlabel('k');
ylabel('Y');
legend('y','y_z_a_d','Location','southeast');
hold off