clear all;

%Punkty pracy
Upp=0;
Ypp=0;
Tp=0.5;

%Ograniczenia
u_max=1;
u_min=-1;

%Inicjalizacja macierzy
n=300; %Okres symulacji
U(1:n)=Upp;
Y(1:n)=Ypp;
Y_zad(1:10)=Ypp;
Y_zad(11:300)=1;
% Y_zad(251:500)=3.5;
% Y_zad(501:750)=2;
% Y_zad(750:1000)=0;
u=U-Upp;
y_zad=Y_zad-Ypp;
y(1:n)=0;
e(1:n)=0;

K=0.82*0.5; Ti=20.4; Td=0.38;
K=0.132199; Ti=3.637091; Td=0.107170;
%Ku = 0.82 
%Metoda inzynierska K=Ku/2, Ti=20.4, Td-0.38

r0 = K*(1 + Tp/(2*Ti) + Td/Tp);
r1 = K*(-1 + Tp/(2*Ti) - 2*Td/Tp);
r2 = K*Td/Tp;
for k=7:n
    Y(k)=symulacja_obiektu2y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2));
    y(k)=Y(k)-Ypp;
    e(k)=y_zad(k)-y(k); %Uchyb
    
    
    %PID
    du = r2*e(k-2)+r1*e(k-1)+r0*e(k);  % u(k) - u(k-1)

       
    u(k)=u(k-1)+du;
    
    if u(k)>u_max
        u(k)=u_max;
    end
    if u(k)<u_min
        u(k)=u_min;
    end
    
    U(k)=u(k)+Upp;
end
 
E=(norm(e))^2 %WskaŸnik jakoœci regulacji

subplot(2,1,1);
stairs(U);
title('u(k)');
xlabel('k');
ylabel('u');
subplot(2,1,2);
stairs(Y);
title('Y(k) i Y_z_a_d');
hold on;
stairs(Y_zad);
xlabel('k');
legend('y','y_z_a_d','Location','southeast');