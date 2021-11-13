clear;
Upp = 0.9;
Ypp = 3;
Umin = 0.6;
Umax = 1.2;
Tp = 0.5;
imax = 250;
Us = 1.05;
T = 1:imax;
Y = zeros(1, imax);
Y(1:12) = Ypp; %Od razu wprowadzenie PP. Bez tego punktu poakzujemy stabilizacjê z Y(0)=0 do Y=Ypp
U(15:imax)=Us; %zmiana sygna³u z PP
U(1:15)=Upp;

%Opowiedzi skokowe dla DMC
for k=12:imax
    Y(k)=symulacja_obiektu2Y_p1(U(k-10),U(k-11),Y(k-1),Y(k-2));
end

%Rysowanie wykresu odpowiedzi skokowej 
subplot(2,1,1);
stairs(U);
xlabel('k');
ylabel('U');
title('Sterowanie')
subplot(2,1,2);
stairs(Y);
xlabel('k');
ylabel('Y');
title('Odpowiedz skokowa')

%Wyznaczenie zestawu liczb odpowiedzi skokowej dla DMC
%Dla 25 kroku nastêpowa³a pierwsza zmiana warto¶ci, a ostatnia dla 131
%(dok³adno¶æ 0,001), D= 106
%26 156
s=zeros(1,imax-26);
for k=1:imax-26
    s(k)=(Y(k+26)-Ypp)/(;
end
figure()
stairs(s);
xlabel('k');
ylabel('s');