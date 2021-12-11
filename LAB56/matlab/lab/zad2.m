hold on
plot(pom1)
plot(pom2)
plot(pom3)
plot(pom4)
xlabel("k")
ylabel("Y")
xlim([0 600])
legend("U = 20", "U = 40", "U = 60", "U = 80")
hold off

U = [20, 40, 60, 80];
Y = [pom1(300), pom2(300), pom3(300), pom4(300)];
plot(U,Y, "o");
lsline
xlabel("U")
ylabel("Y")

Kstat=(Y(4)-Y(1))/(U(4)-U(1))