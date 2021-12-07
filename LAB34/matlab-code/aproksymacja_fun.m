function E = aproksymacja_fun(T)
pom_3 = load('lab2_pomiary.mat').pom_3;
imax = 300;
Ypp = 32.52;
dU= 50 - 27;
d1 = 14;
s=zeros(1,imax-d1);
for k=1:imax-d1
    s(k)=(pom_3(k+d1)-Ypp)/(dU);
end

% aproksymacja
T1 = T(1);
T2 = T(2);
K = T(3);

Td = 0;

alfa1 = exp(-1/T1);
alfa2 = exp(-1/T2);

a1 = -alfa1 - alfa2;
a2 = alfa1*alfa2;

b1 = K/(T1-T2)*(T1*(1-alfa1) - T2*(1-alfa2));
b2 = K/(T1-T2)*(alfa1*T1*(1-alfa2) - alfa2*T1*(1-alfa1));

E = 0;

s_opt = zeros(1,imax-d1);
u(1:imax-d1)=1;

for k=Td+3:imax-d1
   
    s_opt(k) = b1* u(k-Td-1) + b2*u(k-Td-2) - a1*s_opt(k-1) - a2*s_opt(k-2);
    
    E = E + (s_opt(k) - s(k))^2;
end
end