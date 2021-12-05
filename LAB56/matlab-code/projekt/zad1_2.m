clear all;
n=300;
Upp=0;
Ypp=0;
U(1:n)=Upp;
Y(1:n)=Ypp;
Ustat(1:101)=0;
Ystat(1:101)=0;


%1 - Wyznaczenie ró¿nych odpowiedzi skokowych dla zmiany sygna³u steruj¹cego
%2 - Wyznaczanie charakterystki statycznej Y(U)

%Poprawnoœæ Upp, Ypp
% for k=7:n
%     Y(k)=symulacja_obiektu2y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2));
% end

% subplot(2,1,1);
% stairs(U);
% xlabel('k');
% ylabel('U');
% hold on;
% subplot(2,1,2);
% stairs(Y);
% xlabel('k');
% ylabel('Y');
% hold on;

% %Wyznaczenie ró¿nych odpowiedzi skokowych

% for i=1:1:5
%     if i==1
%         U(10:n)=-0.8;
%     elseif i==2
%         U(10:n)=-0.3;
%     elseif i==3
%         U(10:n)=0.2;
%     elseif i==4
%         U(10:n)=0.6;
%     else
%         U(10:n)=1;
%     end
%     for k = 7:n
%         Y(k)=symulacja_obiektu2y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2));
%     end
% 
%     subplot(2,1,1);
%     stairs(U);
%     xlabel('k');
%     ylabel('U');
%     hold on;
%     subplot(2,1,2);
%     stairs(Y);
%     xlabel('k');
%     ylabel('Y');
%     hold on;
% end
% legend('U=-0.8','U=-0.3','U=0,2','U=0.6','U=1')
% 
% % Wyznaczanie charakterystki statycznej
%
% for i=1:101
%     dU=(i-1)*0.02;
%     U(10:n)=-1+dU;
%     for k=7:n
%         Y(k)=symulacja_obiektu2y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2));
%     end
%     Ustat(i)=U(n);
%     Ystat(i)=Y(n);
% end
% plot(Ustat,Ystat);
% xlabel('U');
% ylabel('Y');
% title('Charakterystyka statyczna Y(U)');