clear;
Upp = 0.9;
Ypp = 3;
Umin = 0.6;
Umax = 1.2;
Tp = 0.5;
imax = 150;
U(1:imax)=Upp;
Y(1:imax)=0;
Y(1:11)=Ypp;


%Wyznaczenie ró¿nych odpowiedzi skokowych
for i=1:1:5
    dU=i*0.05; %skoki o 0.05 bo przy 0.1 nie widaæ ró¿nicy przy 3 ostatnich
    U(15:imax)=Upp+dU;
    for k = 12:imax
        Y(k) = symulacja_obiektu2Y_p1(U(k-10), U(k-11), Y(k-1), Y(k-2));
    end

    subplot(2,1,1);
    stairs(U);
    
    hold on;
    subplot(2,1,2);
    stairs(Y);
    hold on;

    hold on;
end
subplot(2,1,1);
xlabel('k');
ylabel('U');
subplot(2,1,2);
xlabel('k');
ylabel('Y');
legend({'U=0,95','U=1,00','U=1,05','U=1,10','U=1,15'})

%Wyznaczanie charakterystki statycznej
% Ustat=zeros(1,100);
% Ystat=zeros(1,100);
% for i=1:100
%     dU=(i-1)*(0.25/100);
%     U(15:imax)=Upp+dU;
%     for k=12:imax
%         Y(k)=symulacja_obiektu2Y_p1(U(k-10),U(k-11),Y(k-1),Y(k-2));
%     end
%     Ustat(i)=U(imax);
%     Ystat(i)=Y(imax);
% end
% 
% plot(Ustat,Ystat);
% xlabel('U');
% ylabel('Y');
% title('Charakterystyka statyczna Y(U)');
% 
% %Wzmocnienie statyczne
% Kstat=(Ystat(100)-Ystat(1))/(Ustat(100)-Ustat(1))