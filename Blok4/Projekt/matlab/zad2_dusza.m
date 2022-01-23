%D=365, najwieksza ilosc pobranych skokow sterowania
clear all;
close all;
n=400;
U1pp=0;
U2pp=0;
U3pp=0;
U4pp=0;
Y1pp=0;
Y2pp=0;
Y3pp=0;
U1(1:n)=U1pp;
U2(1:n)=U2pp;
U3(1:n)=U3pp;
U4(1:n)=U4pp;
Y1(1:n)=Y1pp;
Y2(1:n)=Y2pp;
Y3(1:n)=Y3pp;
s11(1:n-10)=0;
s12(1:n-10)=0;
s13(1:n-10)=0;
s14(1:n-10)=0;
s21(1:n-10)=0;
s22(1:n-10)=0;
s23(1:n-10)=0;
s24(1:n-10)=0;
s31(1:n-10)=0;
s32(1:n-10)=0;
s33(1:n-10)=0;
s34(1:n-10)=0;

U1(10:n)=0;
U2(10:n)=0;
U3(10:n)=1;
U4(10:n)=0;
for k=5:n
    [Y1(k),Y2(k),Y3(k)]=symulacja_obiektu2_p4(U1(k-1),U1(k-2),U1(k-3),U1(k-4),...
                                            U2(k-1),U2(k-2),U2(k-3),U2(k-4),...
                                            U3(k-1),U3(k-2),U3(k-3),U3(k-4),...
                                            U4(k-1),U4(k-2),U4(k-3),U4(k-4),...
                                            Y1(k-1),Y1(k-2),Y1(k-3),Y1(k-4),...
                                            Y2(k-1),Y2(k-2),Y2(k-3),Y2(k-4),...
                                            Y3(k-1),Y3(k-2),Y3(k-3),Y3(k-4));
end

figure(3)
subplot(2,1,1);
stairs(U1);
xlabel('k');
ylabel('U');
hold on;
stairs(U2);
stairs(U3);
stairs(U4);
legend("U1", "U2", "U3", "U4")
subplot(2,1,2);
stairs(Y1);
hold on
stairs(Y2);
stairs(Y3);
legend("Y1", "Y2", "Y3")
% axis([0 150 -200 0])
xlabel('k');
ylabel('Y');
hold off;