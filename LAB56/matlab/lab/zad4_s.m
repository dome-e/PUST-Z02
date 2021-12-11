imax = 600;

% R1
Ypp = 32.12;
dU= abs(20 - 27);
d1 = 2;
D1 = 254 - d1;
s1 = zeros(1,imax-d1);
for k=1:imax-d1
    s1(k)=(pom1(k+d1)-Ypp)/(dU);
end
subplot(2,1,1)
stairs(0:length(s1)-1, s1);
xlabel("k");
ylabel("Y");
hold on

% R2
Ypp = 32.55;
dU= abs(40 - 27);
d2 = 9;
D2 = 298 - d2;
s2 = zeros(1,imax-d2);
for k=1:imax-d2
    s2(k)=(pom2(k+d2)-Ypp)/(dU);
end
stairs(0:length(s2)-1, s2);

% R3
Ypp = 32.2;
dU= abs(80 - 27);
d3 = 9;
D3 = 285 - d3;
s3 = zeros(1,imax-d3);
for k=1:imax-d2
    s3(k)=(pom4(k+d3)-Ypp)/(dU);
end
stairs(0:length(s3)-1, s3);
legend("U = 20", "U = 40", "U = 80");
xlabel('k');
ylabel('s');

hold off
