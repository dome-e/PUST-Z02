function E = zad3_opt(T)
pom_3 = load('lab1_pomiary').pom_3;
d1 = 14;
imax = 300;
dU = 50 - 27;
s = zeros(1,imax-d1);
Ypp = 32.52;
for k = 1:imax-d1
    s(k)=(pom_3(k+d1)-Ypp)/dU;
end

y = zeros(1, imax);
u(1:450)=1;

% aproksymacja
T1 = T(1);
T2 = T(2);
K = T(3);

Td = 14;

alfa1 = exp(-1/T1);
alfa2 = exp(-1/T2);

a1 = -alfa1 - alfa2;
a2 = alfa1*alfa2;

b1 = K/(T1-T2)*(T1*(1-alfa1) - T2*(1-alfa2));
b2 = K/(T1-T2)*(alfa1*T1*(1-alfa2) - alfa2*T1*(1-alfa1));

E = 0;

s_opt = zeros(1,400);

for k=Td+3:imax-d1
   
    s_opt(k) = b1* u(k-Td-1) + b2*u(k-Td-2) - a1*y(k-1) - a2*y(k-2);
    
    E = E + (s_opt(k) - s(k))^2;
end
end