Upp = 0.9;
Ypp = 3;
Umin = 0.6;
Umax = 1.2;
Tp = 0.5;
imax = 150;
T = 1:imax;
Y = zeros(1, imax);
Y(1:12) = Ypp; %Od razu wprowadzenie PP. Bez tego punktu poakzujemy stabilizacjê z Y(0)=0 do Y=Ypp
U(1:imax)=Upp;
for i = 12:imax
    Y(i) = symulacja_obiektu2Y_p1(U(i-10), U(i-11), Y(i-1), Y(i-2));
end
subplot(2,1,1);
stairs(U);
xlabel('k');
ylabel('U');
hold on;
subplot(2,1,2);
stairs(Y);
xlabel('k');
ylabel('Y');
hold on;

