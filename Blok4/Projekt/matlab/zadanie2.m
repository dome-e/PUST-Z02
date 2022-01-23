close all;
n=150;
Upp=0;
Ypp=0;
U1(1:n)=Upp;
U2(1:n)=Upp;
U3(1:n)=Upp;
U4(1:n)=Upp;
Y1(1:n)=Ypp;
Y2(1:n)=Ypp;
Y3(1:n)=Ypp;

% U1 = 1
U1(10:n)=1;
U2(1:n)=0;
U3(1:n)=0;
U4(1:n)=0;
for k=5:n
    [Y1(k),Y2(k),Y3(k)]=symulacja_obiektu2_p4(U1(k-1),U1(k-2),U1(k-3),U1(k-4),...
                                            U2(k-1),U2(k-2),U2(k-3),U2(k-4),...
                                            U3(k-1),U3(k-2),U3(k-3),U3(k-4),...
                                            U4(k-1),U4(k-2),U4(k-3),U4(k-4),...
                                            Y1(k-1),Y1(k-2),Y1(k-3),Y1(k-4),...
                                            Y2(k-1),Y2(k-2),Y2(k-3),Y2(k-4),...
                                            Y3(k-1),Y3(k-2),Y3(k-3),Y3(k-4));
end
Y1 = Y1(11:n);
Y2 = Y2(11:n);
Y3 = Y3(11:n);
figure(1)
subplot(2,1,1);
% stairs(U1);
% xlabel('k');
% ylabel('U');
% hold on;
% stairs(U2);
% stairs(U3);
% stairs(U4);
% legend("U1", "U2", "U3", "U4")
% subplot(2,1,2);
stairs(0:length(Y1)-1, Y1);
% title("U1")
hold on
stairs(0:length(Y2)-1, Y2);
stairs(0:length(Y3)-1, Y3);
legend("s^1^,^1", "s^1^,^2", "s^1^,^3")
axis([0 80 0 2.8])
xlabel('k');
ylabel('s');
hold off;

% U2 = 1
U1(1:n)=0;
U2(10:n)=1;
U3(1:n)=0;
U4(1:n)=0;
Y1(1:n)=Ypp;
Y2(1:n)=Ypp;
Y3(1:n)=Ypp;
for k=5:n
    [Y1(k),Y2(k),Y3(k)]=symulacja_obiektu2_p4(U1(k-1),U1(k-2),U1(k-3),U1(k-4),...
                                            U2(k-1),U2(k-2),U2(k-3),U2(k-4),...
                                            U3(k-1),U3(k-2),U3(k-3),U3(k-4),...
                                            U4(k-1),U4(k-2),U4(k-3),U4(k-4),...
                                            Y1(k-1),Y1(k-2),Y1(k-3),Y1(k-4),...
                                            Y2(k-1),Y2(k-2),Y2(k-3),Y2(k-4),...
                                            Y3(k-1),Y3(k-2),Y3(k-3),Y3(k-4));
end
Y1 = Y1(11:n);
Y2 = Y2(11:n);
Y3 = Y3(11:n);
figure(2)
subplot(2,1,1);
% stairs(U1);
% xlabel('k');
% ylabel('U');
% hold on;
% stairs(U2);
% stairs(U3);
% stairs(U4);
% legend("U1", "U2", "U3", "U4")
% subplot(2,1,2);
stairs(0:length(Y1)-1, Y1);
% title("U2")
hold on
stairs(0:length(Y2)-1, Y2);
stairs(0:length(Y3)-1, Y3);
legend("s^2^,^1", "s^2^,^2", "s^2^,^3")
axis([0 80 0 2.8])
xlabel('k');
ylabel('s');
hold off;

% U3 = 1
U1(1:n)=0;
U2(1:n)=0;
U3(10:n)=1;
U4(1:n)=0;
Y1(1:n)=Ypp;
Y2(1:n)=Ypp;
Y3(1:n)=Ypp;
for k=5:n
    [Y1(k),Y2(k),Y3(k)]=symulacja_obiektu2_p4(U1(k-1),U1(k-2),U1(k-3),U1(k-4), U2(k-1),U2(k-2),U2(k-3),U2(k-4), U3(k-1),U3(k-2),U3(k-3),U3(k-4), U4(k-1),U4(k-2),U4(k-3),U4(k-4), Y1(k-1),Y1(k-2),Y1(k-3),Y1(k-4), Y2(k-1),Y2(k-2),Y2(k-3),Y2(k-4), Y3(k-1),Y3(k-2),Y3(k-3),Y3(k-4));
end
Y1 = Y1(11:n);
Y2 = Y2(11:n);
Y3 = Y3(11:n);
figure(3)
subplot(2,1,1);
% stairs(U1);
% xlabel('k');
% ylabel('U');
% hold on;
% stairs(U2);
% stairs(U3);
% stairs(U4);
% legend("U1", "U2", "U3", "U4")
% subplot(2,1,2);
stairs(0:length(Y1)-1, Y1);
% title("U3")
hold on
stairs(0:length(Y2)-1, Y2);
stairs(0:length(Y3)-1, Y3);
legend("s^3^,^1", "s^3^,^2", "s^3^,^3")
axis([0 80 0 2.8])
xlabel('k');
ylabel('s');
hold off;

% U4 = 1
U1(1:n) = Upp;
U2(1:n) = Upp;
U3(1:n) = Upp;
U4(10:n) = 1;
Y1(1:n)=Ypp;
Y2(1:n)=Ypp;
Y3(1:n)=Ypp;
for k=5:n
    [Y1(k),Y2(k),Y3(k)]=symulacja_obiektu2_p4(U1(k-1),U1(k-2),U1(k-3),U1(k-4), U2(k-1),U2(k-2),U2(k-3),U2(k-4), U3(k-1),U3(k-2),U3(k-3),U3(k-4), U4(k-1),U4(k-2),U4(k-3),U4(k-4), Y1(k-1),Y1(k-2),Y1(k-3),Y1(k-4), Y2(k-1),Y2(k-2),Y2(k-3),Y2(k-4), Y3(k-1),Y3(k-2),Y3(k-3),Y3(k-4));
end
Y1 = Y1(11:n);
Y2 = Y2(11:n);
Y3 = Y3(11:n);
figure(4)
subplot(2,1,1);
% stairs(U1);
% xlabel('k');
% ylabel('U');
% hold on;
% stairs(U2);
% stairs(U3);
% stairs(U4);
% legend("U1", "U2", "U3", "U4")
% subplot(2,1,2);
stairs(0:length(Y1)-1, Y1);
% title("U4")
hold on
stairs(0:length(Y2)-1, Y2);
stairs(0:length(Y3)-1, Y3);
legend("s^4^,^1", "s^4^,^2", "s^4^,^3")
axis([0 80 0 2.8])
xlabel('k');
ylabel('s');
hold off;