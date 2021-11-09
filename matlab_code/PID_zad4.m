clear all;

Upp = 0.9;
Ypp = 3;

Umin = 0.6 - Upp;
Umax = 1.2 - Upp;
delta_Umax = 0.1;

Tp = 0.5;
imax = 1000;

Y = zeros(1, imax);
Y(1:12) = Ypp; 
U(1:imax) = Upp;


Yzad(13:imax) = 3.3;

p = imax/5;

% Yzad(1:12) = Ypp;
% Yzad(13:p) = 3.3;
% Yzad(p+1:2*p) = 2.7;
% Yzad(2*p+1:3*p) = 2.9;
% Yzad(3*p+1:4*p) = 3.4;
% Yzad(4*p+1:5*p) = 3.1;

u = U - Upp; 
yzad = Yzad - Ypp;

y(1:imax) = 0;
e(1:imax) = 0;

% nastawy do PID 

%     DOBIERAMY NASTAWY ZACZYNAJĄC OD P, POTEM PI I NA KOŃCU PID !!!!!


K = 2.02; Ti = inf; Td = 0; % Wzmocnienie krytyczne
Tkr = 138 - 86;
Kkr = 2.02;

% K = 0.5 * 2.02; Ti = inf; Td = 0; %  Regulator P

% K = 0.45 * Kkr;  Ti = Tkr/1.2; Td = 0; % Regulator PI

% K = 0.6 * Kkr; Ti = 0.5 * Tkr; Td = 0.125 * Tkr; % Regulator PID

% w sprawku trzeba napisać jakie powychodziły nastawy dla danego
% regulatora, i jakie były na końcu w PID i jak zostały dostrojone do tych
% ostatnich

% K = 1.1; Ti = 12; Td = 4; % Dostrojony PID metodą eksperymentalną

% TO-DO % dorobić jeszcze WSKAŹNIK JAKOŚCI REGULACJI, tak jak napisane w
% treści zadania projektowego


r0 = K*(1 + Tp/(2*Ti) + Td/Tp);
r1 = K*(-1 + Tp/(2*Ti) - 2*Td/Tp);
r2 = K*Td/Tp;

for k=12:imax
    Y(k) = symulacja_obiektu2Y_p1(U(k-10),U(k-11),Y(k-1),Y(k-2));
    
    y(k) = Y(k) - Ypp;
    e(k) = yzad(k) - y(k); %Uchyb
    
    %regulator PID
    delta_U = r2*e(k-2)+r1*e(k-1)+r0*e(k);  % u(k) - u(k-1)
    
    if delta_U > delta_Umax
        delta_U = delta_Umax;
    end
    if delta_U < -delta_Umax
        delta_U = -delta_Umax;
    end
    
    u(k) = delta_U + u(k-1);
    
    if u(k) > Umax
        u(k) = Umax;
    end
    if u(k) < Umin
        u(k) = Umin;
    end
    
    U(k) = u(k) + Upp; % u=U-Upp

end

subplot(2,1,1);
stairs(U);
ylim([0 1.3])
title('u(k)');
xlabel('k');
ylabel('u');
subplot(2,1,2);
stairs(Y);
ylim([0 4.3])
title('Y(k) i Y_z_a_d');
hold on;
stairs(Yzad);
xlabel('k');
legend('y','y_z_a_d','Location','southeast');