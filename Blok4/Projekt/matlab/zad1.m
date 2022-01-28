clear all;
n=300;
Upp=0;
Ypp=0;
U1(1:n)=Upp;
U2(1:n)=Upp;
U3(1:n)=Upp;
U4(1:n)=Upp;
Y1(1:n)=Ypp;
Y2(1:n)=Ypp;
Y3(1:n)=Ypp;

for k=7:n
    [Y1(k),Y2(k),Y3(k)]=symulacja_obiektu2_p4(U1(k-1),U1(k-2),U1(k-3),U1(k-4), U2(k-1),U2(k-2),U2(k-3),U2(k-4), U3(k-1),U3(k-2),U3(k-3),U3(k-4), U4(k-1),U4(k-2),U4(k-3),U4(k-4), Y1(k-1),Y1(k-2),Y1(k-3),Y1(k-4), Y2(k-1),Y2(k-2),Y2(k-3),Y2(k-4), Y3(k-1),Y3(k-2),Y3(k-3),Y3(k-4));
end

figure(1)
subplot(2,1,1);
stairs(U1);
xlabel('k');
ylabel('U');
hold on;
stairs(U2);
stairs(U3);
stairs(U4);
hold off
legend("U1", "U2", "U3", "U4")
subplot(2,1,2);
stairs(Y1);
hold on
stairs(Y2);
stairs(Y3);
legend("Y1", "Y2", "Y3")
xlabel('k');
ylabel('Y');
hold off;