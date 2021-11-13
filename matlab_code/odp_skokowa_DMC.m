Upp = 0.9;
Ypp = 3;
Umin = 0.6;
Umax = 1.2;
Tp = 0.5;
imax = 250;
Us = 1.2;
T = 1:imax;
Y = zeros(1, imax);
Y(1:11) = Ypp;
U(12:imax) = Us;
U(1:11) = Upp;

for k=12:imax
    Y(k)=symulacja_obiektu2Y_p1(U(k-10),U(k-11),Y(k-1),Y(k-2));
end

% subplot(2,1,1);
% stairs(0:length(U)-1,U);
% xlabel('k');
% ylabel('U');
% subplot(2,1,2);
% stairs(0:length(Y)-1, Y);
% xlabel('k');
% ylabel('Y');

d1 = 21;
d2 = 135;
D = 135 - 21;
dU = 1.2 - Upp;

s = zeros(1,imax-d1);
for k = 1:imax-d1
    s(k)=(Y(k+d1)-Ypp)/dU;
end

% figure()
% subplot(2,1,1);
% stairs(0:length(s)-1, s);
% axis([0 imax-d1 0 1.8]);
% xlabel('k');
% ylabel('s');