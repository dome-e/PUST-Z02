s=zeros(1,400);
Ypp=32.52;
du=50-27;
for k=1:400
    s(k)=(pom_3(k)-Ypp)/(du);
end
stairs(s);
title("zad3: skok jedn. przeskalowany, G1 = 50");
xlabel("k");
ylabel("T[C]");

T1 = 0;
T2 = 0;
K = 0;
Td = 14;

alfa1 = e^(-1/T1);
alfa2 = e^(-1/T2);

a1 = -alfa1 - alfa2;
a2 = alfa1*alfa2;

b1 = K/(T1-T2)*(T1*(1-alfa1) - T2*(1-alfa2));
b2 = K/(T1-T2)*(alfa1*T1*(1-alfa2) - alfa2*T1*(1-alfa1));

E = 0;
s_opt = zeros(1:400);

for k=Td+3:400
   
    s_opt(k) = b1* pom_3(k-Td-1) + b2*u(k-Td-2) - a1*s(k-1) - a2*y(k-2);
    
    E = E + (s_opt(k) - s(k))^2;
    
end


 