function E = fun_PID(X)

Upp=0;
Ypp=wynik_y(Upp);

%Do jakiej wartoœci skaczemy
y_skok=0.45;

%Ograniczenia
u_max=1;
u_min=-1;

Ts=0.5;
K=X(1); Ti=X(2); Td=X(3);
 
r2 = K*Td/Ts;
r1 = K*(Ts/(2*Ti)-2*Td/Ts - 1);
r0 = K*(1+Ts/(2*Ti) + Td/Ts);
 
n=3400; %okres symulacji wyd³u¿ony by pozbyæ siê oscylacji
U(1:n)=Upp;
Y(1:14)=Ypp;
Y_zad(1:14)=Ypp;
Y_zad(15:3000)=y_skok;
Y_zad(3000:3400)=Ypp;
u=U-Upp;
y_zad=Y_zad-Ypp;
y(1:n)=0;
e(1:n)=0;

for k=15:n
    Y(k)=symulacja_obiektu2y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2));
    y(k)=Y(k)-Ypp;
    e(k)=y_zad(k)-y(k); %Uchyb
    
    du=r2*e(k-2)+r1*e(k-1)+r0*e(k); %Regulator PID
    
    u(k)=u(k-1)+du;
    
    if u(k)>u_max
        u(k)=u_max;
    end
    if u(k)<u_min
        u(k)=u_min;
    end
    
    U(k)=u(k)+Upp;   
end
 
E=(norm(e))^2; %WskaŸnik jakoœæi regulacji

end