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

% 12 torow

% U1 = 1
U1(5:n) = 1;
for k=7:n
    [Y1(k),Y2(k),Y3(k)]=symulacja_obiektu2_p4(U1(k-1),U1(k-2),U1(k-3),U1(k-4), U2(k-1),U2(k-2),U2(k-3),U2(k-4), U3(k-1),U3(k-2),U3(k-3),U3(k-4), U4(k-1),U4(k-2),U4(k-3),U4(k-4), Y1(k-1),Y1(k-2),Y1(k-3),Y1(k-4), Y2(k-1),Y2(k-2),Y2(k-3),Y2(k-4), Y3(k-1),Y3(k-2),Y3(k-3),Y3(k-4));
end
figure(2)
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
axis([0 300 -100 0])
xlabel('k');
ylabel('Y');
hold off;
for k=11:n
    s11(k-5)=Y1(k); %165
    s21(k-5)=Y2(k); %288
    s31(k-5)=Y3(k); %272
end
% U2 = 1
U1(5:n) = 0;
U2(5:n) = 1;
for k=7:n
    [Y1(k),Y2(k),Y3(k)]=symulacja_obiektu2_p4(U1(k-1),U1(k-2),U1(k-3),U1(k-4), U2(k-1),U2(k-2),U2(k-3),U2(k-4), U3(k-1),U3(k-2),U3(k-3),U3(k-4), U4(k-1),U4(k-2),U4(k-3),U4(k-4), Y1(k-1),Y1(k-2),Y1(k-3),Y1(k-4), Y2(k-1),Y2(k-2),Y2(k-3),Y2(k-4), Y3(k-1),Y3(k-2),Y3(k-3),Y3(k-4));
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
axis([0 300 -100 0])
xlabel('k');
ylabel('Y');
hold off;
for k=11:n
    s12(k-5)=Y1(k); %161
    s22(k-5)=Y2(k); %269
    s32(k-5)=Y3(k); %239
end
% U3 = 1
U2(5:n) = 0;
U3(5:n) = 1;
for k=7:n
    [Y1(k),Y2(k),Y3(k)]=symulacja_obiektu2_p4(U1(k-1),U1(k-2),U1(k-3),U1(k-4), U2(k-1),U2(k-2),U2(k-3),U2(k-4), U3(k-1),U3(k-2),U3(k-3),U3(k-4), U4(k-1),U4(k-2),U4(k-3),U4(k-4), Y1(k-1),Y1(k-2),Y1(k-3),Y1(k-4), Y2(k-1),Y2(k-2),Y2(k-3),Y2(k-4), Y3(k-1),Y3(k-2),Y3(k-3),Y3(k-4));
end
figure(4)
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
axis([0 300 -100 0])
xlabel('k');
ylabel('Y');
hold off;
for k=11:n
    s13(k-5)=Y1(k); %124
    s23(k-5)=Y2(k); %284
    s33(k-5)=Y3(k); %215
end
% U4 = 1
U3(5:n) = 0;
U4(5:n) = 1;
for k=7:n
    [Y1(k),Y2(k),Y3(k)]=symulacja_obiektu2_p4(U1(k-1),U1(k-2),U1(k-3),U1(k-4), U2(k-1),U2(k-2),U2(k-3),U2(k-4), U3(k-1),U3(k-2),U3(k-3),U3(k-4), U4(k-1),U4(k-2),U4(k-3),U4(k-4), Y1(k-1),Y1(k-2),Y1(k-3),Y1(k-4), Y2(k-1),Y2(k-2),Y2(k-3),Y2(k-4), Y3(k-1),Y3(k-2),Y3(k-3),Y3(k-4));
end
figure(5)
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
axis([0 300 -100 0])
xlabel('k');
ylabel('Y');
hold off;
for k=11:n
    s14(k-5)=Y1(k); % 190
    s24(k-5)=Y2(k); %262
    s34(k-5)=Y3(k); %238
end
figure;
stairs(s11);
xlabel('k');
ylabel('s');
title('S1');
hold on
stairs(s21);
xlabel('k');
stairs(s31);
xlabel('k');
legend("Y1", "Y2", "Y3")
hold off;

figure;
stairs(s12);
xlabel('k');
ylabel('s');
title('S2');
hold on
stairs(s22);
xlabel('k');
stairs(s32);
xlabel('k');
legend("Y1", "Y2", "Y3")
hold off;

figure;
stairs(s13);
xlabel('k');
ylabel('s');
title('S3');
hold on
stairs(s23);
xlabel('k');
stairs(s33);
xlabel('k');
legend("Y1", "Y2", "Y3")
hold off;

figure;
stairs(s14);
xlabel('k');
ylabel('s');
title('S4');
hold on
stairs(s24);
xlabel('k');
stairs(s34);
xlabel('k');
legend("Y1", "Y2", "Y3")
hold off;