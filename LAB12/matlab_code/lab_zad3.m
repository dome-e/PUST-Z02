% dla G1 = 50
d1 = 14;
d2 = 180;
imax = 300;
dU = 50 - 27;
s = zeros(1,imax-d1);
Ypp = 32.52;
y = zeros(1, imax);
u(1:450)=1;
for k = 1:imax-d1
    s(k)=(pom_3(k+d1)-Ypp)/dU;
end

figure()
subplot(2,1,1);
stairs(0:length(s)-1, s);
axis([0 250 0 0.4]);
xlabel('k');
ylabel('s');

% aproksymacja

T1 = 10.6829;
T2 = 35.3386;
K = 9.6416;
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
   
    s_opt(k) = b1*u(k - Td -1)+b2*u(k-Td-2)-a1*y(k-1)- a2*y(k-2);
    
    E = E + (s_opt(k) - s(k))^2;
end
hold on;
plot(0:length(s_opt)-1, s_opt);