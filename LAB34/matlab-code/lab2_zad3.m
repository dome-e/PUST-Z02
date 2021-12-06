% s1, s2, s3, ...
imax = 350;
Ypp = 32.52;
dU= 50 - 27;
d1 = 11;
s=zeros(1,imax-d1);
for k=1:imax-d1
    s(k)=(pom_3(k+d1)-Ypp)/(dU);
end
subplot(2,1,1)
stairs(0:299, s(1:300));
% title("zad3: skok jedn. przeskalowany, G1 = 50");
xlabel("k");
ylabel("Y");
legend("U = 50");

% s1_z, s2_z, s3_z, ...
Ypp_z= 27.8; % 27.75;
dU_z= 15;
d1_z = 8;
s_z=zeros(1,imax-d1_z);
for k=1:imax-d1_z
    s_z(k)=(pom2(k+d1_z)-Ypp_z)/(dU_z);
end
subplot(2,1,2)
stairs(0:299, s_z(1:300));
% title("zad3: skok jedn. przeskalowany, Z = 15");
xlabel("k");
ylabel("Y");
legend("Z = 15");
