
%Patrze na macierz wzmocnienia W przy wyznaczaniu relacji U-Y
clear all; close all;

W=[1.4986    0.4953    1.8691;
    0.7500    2.4999    0.8000;
    0.4000    1.1000    1.3000;
    1.0000    0.5000    1.0500]

%Numer wejscia ktorego nie bierzemy pod uwage
regulator=4;

%Punkty pracy
U1pp=0;
U2pp=0;
U3pp=0;
U4pp=0;
Y1pp=0;
Y2pp=0;
Y3pp=0;

    K1=0; Ti1=inf; Td1=0; Ts=0.5;
    K2=0; Ti2=inf; Td2=0;
    K3=0; Ti3=inf; Td3=0; 
    
if regulator==1
     K1=12.03/3; Ti1=3; Td1=0.01; Ts=0.5;
     K2=11.2/3; Ti2=3; Td2=0.01;  
    K3=6.18/3; Ti3=5; Td3=0.03;

elseif regulator==2   
    K1=12.03/2.5; Ti1=15; Td1=0.01; Ts=0.5;
    K2=10.94/3.5; Ti2=5; Td2=0.01;
    K3=35.8/3.5; Ti3=4; Td3=0.01; 
elseif regulator==3   
     K1=12.03/5; Ti1=14; Td1=0.01; Ts=0.5;
     K2=11.2/3; Ti2=5; Td2=0.01;  
     K3=6.18/2.5; Ti3=15; Td3=0.03;
elseif regulator==4   
     K1=26.67/3; Ti1=5; Td1=0.01; Ts=0.5;
     K2=11.2/3; Ti2=5; Td2=0.01;  
    K3=6.18/2.5; Ti3=5; Td3=0.01;
end

r12 = K1*Td1/Ts;
r11 = K1*(Ts/(2*Ti1)-2*Td1/Ts - 1);
r10 = K1*(1+Ts/(2*Ti1) + Td1/Ts);

r22 = K2*Td2/Ts;
r21 = K2*(Ts/(2*Ti2)-2*Td2/Ts - 1);
r20 = K2*(1+Ts/(2*Ti2) + Td2/Ts);

r32 = K3*Td3/Ts;
r31 = K3*(Ts/(2*Ti3)-2*Td3/Ts - 1);
r30 = K3*(1+Ts/(2*Ti3) + Td3/Ts);

n=1600; %Okres symulacji
U1(1:n)=U1pp;
U2(1:n)=U2pp;
U3(1:n)=U3pp;
U4(1:n)=U4pp;
Y1(1:n)=Y1pp;
Y2(1:n)=Y2pp;
Y3(1:n)=Y3pp;

Y1_zad(1:14)=Y1pp;
Y1_zad(15:300)=2;
Y1_zad(301:800)=0.5;
Y1_zad(801:1300)=1.5;
Y1_zad(1301:1600)=1;

Y2_zad(1:14)=Y2pp;
Y2_zad(15:400)=1;
Y2_zad(401:900)=0.5;
Y2_zad(901:1200)=1;
Y2_zad(1201:1600)=1.5;

Y3_zad(1:14)=Y3pp;
Y3_zad(15:500)=0.5;
Y3_zad(501:800)=1.5;
Y3_zad(801:1200)=0.5;
Y3_zad(1201:1600)=1;

u1=U1-U1pp;
u2=U2-U2pp;
u3=U3-U3pp;
u4=U4-U4pp;
y1_zad=Y1_zad-Y1pp;
y2_zad=Y2_zad-Y2pp;
y3_zad=Y3_zad-Y3pp;
y1(1:n)=0;
y2(1:n)=0;
y3(1:n)=0;
du1=0;
du2=0;
du3=0;
du4=0;
Ey=zeros(3,n);

for k=5:n    
    [Y1(k),Y2(k),Y3(k)]=symulacja_obiektu2_p4(U1(k-1),U1(k-2),U1(k-3),U1(k-4),...
                                            U2(k-1),U2(k-2),U2(k-3),U2(k-4),...
                                            U3(k-1),U3(k-2),U3(k-3),U3(k-4),...
                                            U4(k-1),U4(k-2),U4(k-3),U4(k-4),...
                                            Y1(k-1),Y1(k-2),Y1(k-3),Y1(k-4),...
                                            Y2(k-1),Y2(k-2),Y2(k-3),Y2(k-4),...
                                            Y3(k-1),Y3(k-2),Y3(k-3),Y3(k-4));
    
    
    y1(k)=Y1(k)-Y1pp;
    y2(k)=Y2(k)-Y2pp;
    y3(k)=Y3(k)-Y3pp;
    %Blad dla Y
    Ey(1,k)=y1_zad(k)-y1(k);
    Ey(2,k)=y2_zad(k)-y2(k);
    Ey(3,k)=y3_zad(k)-y3(k);
    
    if regulator==1
        du1=0; 
        du2=r22*Ey(2,k-2)+r21*Ey(2,k-1)+r20*Ey(2,k); %regulator PID U2 dla Y2
        du3=r32*Ey(3,k-2)+r31*Ey(3,k-1)+r30*Ey(3,k); %regulator PID U3 dla Y3
        du4=r12*Ey(1,k-2)+r11*Ey(1,k-1)+r10*Ey(1,k); %regulator PID U4 dla Y1
     elseif regulator==2
        du1=r32*Ey(3,k-2)+r31*Ey(3,k-1)+r30*Ey(3,k); %regulator PID U1 dla Y3
        du2=0; 
        du3=r22*Ey(2,k-2)+r21*Ey(2,k-1)+r20*Ey(2,k); %regulator PID U3 dla Y2
        du4=r12*Ey(1,k-2)+r11*Ey(1,k-1)+r10*Ey(1,k); %regulator PID U4 dla Y1
     elseif regulator==3
        du1=r32*Ey(3,k-2)+r31*Ey(3,k-1)+r30*Ey(3,k); %regulator PID U1 dla Y3
        du2=r22*Ey(2,k-2)+r21*Ey(2,k-1)+r20*Ey(2,k);%regulator PID U2 dla Y2 
        du3=0; %regulator PID U3 dla Y2
        du4=r12*Ey(1,k-2)+r11*Ey(1,k-1)+r10*Ey(1,k); %regulator PID U4 dla Y1
     elseif regulator==4
        du1=r12*Ey(1,k-2)+r11*Ey(1,k-1)+r10*Ey(1,k); %regulator PID U1 dla Y1
        du2=r22*Ey(2,k-2)+r21*Ey(2,k-1)+r20*Ey(2,k);%regulator PID U2 dla Y2 
        du3=r32*Ey(3,k-2)+r31*Ey(3,k-1)+r30*Ey(3,k); %regulator PID U3 dla Y3
        du4=0;
    end
       
    u1(k)=u1(k-1)+du1;
    u2(k)=u2(k-1)+du2;
    u3(k)=u3(k-1)+du3;
    u4(k)=u4(k-1)+du4;
    
    U1(k)=u1(k)+U1pp;
    U2(k)=u2(k)+U2pp;
    U3(k)=u3(k)+U3pp;
    U4(k)=u4(k)+U3pp;
    
end

EY=norm(Ey)^2   

% figure;
% subplot(2,2,1);
% stairs(U1);
% xlabel('k');
% ylabel('U1');
% subplot(2,2,2);
% stairs(U2);
% xlabel('k');
% ylabel('U2');
% subplot(2,2,3);
% stairs(U3);
% xlabel('k');
% ylabel('U3');
% subplot(2,2,4);
% stairs(U4);
% xlabel('k');
% ylabel('U4');
% figure
% subplot(3,1,1);
% stairs(Y1);
% xlabel('k');
% ylabel('Y1');
% hold on;
% stairs(Y1_zad);
% hold off;
% subplot(3,1,2);
% stairs(Y2);
% xlabel('k');
% ylabel('Y2');
% hold on;
% stairs(Y2_zad);
% hold off;
% subplot(3,1,3);
% stairs(Y3);
% xlabel('k');
% ylabel('Y3');
% hold on;
% stairs(Y3_zad);
% hold off;