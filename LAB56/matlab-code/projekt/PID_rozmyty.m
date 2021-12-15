clear all;

%Punkty p racy
Upp=0;
Ypp=0;

%Ograniczenia
u_max=1;
u_min=-1;

%Iloœæ regulatorów lokalnych
regulator=3; %2 slabo; 3 w miare; 4 dziala; 5 slaby
typ_regulatora = 'PID';
y_przedzial = rozklad(regulator, typ_regulatora);
if regulator==2
    K=[-0.172946 0.191360];
    Ti=[-1.070829 8.028027];
    Td=[-4.981247 0.769607];
elseif regulator==3
    K=[-0.172946 -0.018484 0.191360];
    Ti=[-2.055129 -10.214840 8.028027];
    Td=[-4.981247 15.489054 0.769607];
elseif regulator==4
    K=[-0.172946 0.132199 -0.018484 0.191360];
    Ti=[-2.055129 3.637091 -10.214840 8.028027];
    Td=[-4.981247 0.107170 15.489054 0.769607];
elseif regulator==5
    K=[-0.172946 -0.027008 -0.018484 -0.131081 0.191360];
    Ti=[-2.055129 -3.995364 -10.214840 -4.333814 8.028027];
    Td=[-4.981247 26.380217 15.489054 -6.294312 0.769607];
end

Ts(1:regulator)=0.5;

%Parametry regulatorów
r2=K.*Td./Ts;
r1=K.*(Ts./(2.*Ti)-2.*Td./Ts - 1);
r0=K.*(1+Ts./(2.*Ti) + Td./Ts);


n=1000; %Okres symulacji
U(1:n)=Upp;
Y(1:n)=Ypp;
Y_zad(1:10)=Ypp;
Y_zad(11:250)=1;
Y_zad(251:500)=3.5;
Y_zad(501:750)=2;
Y_zad(750:1000)=0;
u=U-Upp;
y_zad=Y_zad-Ypp;
y(1:n)=0;
e(1:n)=0;


for k=7:n
    Y(k)=symulacja_obiektu2y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2));
    y(k)=Y(k)-Ypp;
    e(k)=y_zad(k)-y(k); %Uchyb
    
    %Poziom przynale¿noœci aktualnego Y do poszczegónych przedzia³ów
    %rozmytych
    
    
    %Suma wa¿ona
    du=0;
    przedzial_suma = sum(y_przedzial(:,floor((y(k)/0.05)+5)));
    for j=1:regulator
        du=du+y_przedzial(j,floor((y(k)/0.05)+5))*(r2(j)*e(k-2)+r1(j)*e(k-1)+r0(j)*e(k))/przedzial_suma;
    end
       
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