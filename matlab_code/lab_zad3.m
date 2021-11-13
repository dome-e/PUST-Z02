% dla G1 = 50
d1 = 14;
d2 = 180;
imax = 300;
dU = 50 - 27;
s = zeros(1,imax-d1);
Ypp = 32.52;
for k = 1:imax-d1
    s(k)=(pom_3(k+d1)-Ypp)/dU;
end

figure()
subplot(2,1,1);
stairs(0:length(s)-1, s);
axis([0 250 0 0.4]);
xlabel('k');
ylabel('s');