clear all;
load('s_DMC.mat');

D=100;
nu=4;
ny=3;

%Macierz odopowiedzi skokowych
for i=1:140
    S(i)={[s11(i) s12(i) s13(i) s14(i);s21(i) s22(i) s23(i) s24(i);s31(i) s32(i) s33(i) s34(i)]};
end
    
%Parametry dobrane eksperymentalnie
N=10; Nu=10;
lambda1=0.01; lambda2=0.0001; lambda3=0.005; lambda4=0.0001;
psi1=1.3; psi2=1.15; psi3=1.1;

%Punkty pracy
U1pp=0;
U2pp=0;
U3pp=0;
U4pp=0;
Y1pp=0;
Y2pp=0;
Y3pp=0;

%Inicjalizacja macierzy i wektor?w

%Macierz M
for i=1:Nu
    M(i:N,i)=S(1:N-i+1);
    M(1:i-1,i)={[0 0 0 0; 0 0 0 0; 0 0 0 0]};
end

%Macierz Mp
for i=1:(D-1)
    for j=1:N
        Mp{j,i}=S{j+i}-S{i};
    end
end

%Macierz Lambd
for i=1:Nu
    for j=1:Nu
        if i==j
            Lambda{i,j}=[lambda1 0 0 0; 0 lambda2 0 0;...
                         0 0 lambda3 0; 0 0 0 lambda4];
        else
            Lambda{i,j}=[0 0 0 0; 0 0 0 0;...
                         0 0 0 0; 0 0 0 0;];
        end
    end
end

%Maciersz Psi
for i=1:N
    for j=1:N
        if i==j
            Psi{i,j}=[psi1 0 0; 0 psi2 0; 0 0 psi3];
        else
            Psi{i,j}=[0 0 0; 0 0 0; 0 0 0];
        end
    end
end

%Macierz K
M_tmp=cell2mat(M);
Mt_tmp=M_tmp';
Psi_tmp=cell2mat(Psi);
Mt_tmp=Mt_tmp*Psi_tmp;
for i=1:Nu
    size(i)=nu;
end
for i=1:N
    size2(i)=ny;
end
Temp_M = mat2cell(Mt_tmp*M_tmp,size,size); %Mno?emie M'*M
for i=1:Nu
    for j=1:Nu
        A{i,j}=Temp_M{i,j}+Lambda{i,j}; %Dodanie Lambdy
    end
end
A_tmp = cell2mat(A);
A_odwrocone = mat2cell(A_tmp^(-1),size,size);%Odwr?cenie macierzy
A_odwrocone_tmp = cell2mat(A_odwrocone);

K = mat2cell(A_odwrocone_tmp*Mt_tmp,size,size2);%Przemno?enie przez M'

%Macierze przechowuj?ce warto?ci dla oblicze? DMC
dup=zeros(nu,1);
for i=1:D-1
    dUp1234(i,1)={dup};
end

Y_zad_dmc=zeros(ny,1);
for i=1:N
    Y_1234(i,1)={Y_zad_dmc};
end

Y_dmc=zeros(ny,1);
for i=1:N
    Y1234(i,1)={Y_dmc};
end

for i=1:N
    Y0(i,1)={[0;0]};
end

du=zeros(nu,1);
for i=1:Nu
    dU1234(i,1)={du};
end


n=1600; %Okres symulacji
U1(1:n)=U1pp;
U2(1:n)=U2pp;
U3(1:n)=U3pp;
U4(1:n)=U4pp;
Y1(1:n)=Y1pp;
Y2(1:n)=Y2pp;
Y3(1:n)=Y3pp;

Y1_zad(1:14)=Y1pp;
Y1_zad(15:300)=1;
Y1_zad(301:700)=2;
Y1_zad(701:1100)=0.5;
Y1_zad(1101:1600)=1.5;

Y2_zad(1:14)=Y2pp;
Y2_zad(15:400)=1;
Y2_zad(401:800)=0.5;
Y2_zad(801:1200)=1;
Y2_zad(1201:1600)=1.5;

Y3_zad(1:14)=Y3pp;
Y3_zad(15:400)=1;
Y3_zad(401:900)=1.5;
Y3_zad(901:1300)=0.5;
Y3_zad(1301:1600)=1;

u1=U1-U1pp;
u2=U2-U2pp;
u3=U3-U3pp;
u4=U4-U4pp;
y1_zad=Y1_zad-Y1pp;
y2_zad=Y2_zad-Y2pp;
y3_zad=Y3_zad-Y3pp;
y1(1:n)=0;
y2(1:n)=0;
y3(1:n)=0;
Ey=zeros(3,n);
Eu=zeros(1,n);

for k=9:n
   [Y1(k),Y2(k),Y3(k)]=symulacja_obiektu2_p4(U1(k-1),U1(k-2),U1(k-3),U1(k-4),...
                                            U2(k-1),U2(k-2),U2(k-3),U2(k-4),...
                                            U3(k-1),U3(k-2),U3(k-3),U3(k-4),...
                                            U4(k-1),U4(k-2),U4(k-3),U4(k-4),...
                                            Y1(k-1),Y1(k-2),Y1(k-3),Y1(k-4),...
                                            Y2(k-1),Y2(k-2),Y2(k-3),Y2(k-4),...
                                            Y3(k-1),Y3(k-2),Y3(k-3),Y3(k-4));
    
    
    y1(k)=Y1(k)-Y1pp;
    y2(k)=Y2(k)-Y2pp;
    y3(k)=Y3(k)-Y3pp;
    
    %uchyb
    Ey(1,k)=y1_zad(k)-y1(k);
    Ey(2,k)=y2_zad(k)-y2(k);
    Ey(3,k)=y3_zad(k)-y3(k);
    
    Y_dmc(1)=y1(k);
    Y_dmc(2)=y2(k);
    Y_dmc(3)=y3(k);
    for i=1:N
        Y1234(i,1)={Y_dmc};
    end
    
    
    Y_zad_dmc(1)=y1_zad(k);
    Y_zad_dmc(2)=y2_zad(k);
    Y_zad_dmc(3)=y3_zad(k);
    
    for i=1:N
        Y_1234(i,1)={Y_zad_dmc};
    end
    
    
    %Wyliczanie Y0
    Mp_tmp = cell2mat(Mp);
    dUp_tmp = cell2mat(dUp1234);
    Temp_Y0 = mat2cell(Mp_tmp*dUp_tmp,size2,[1]); 
    for i=1:N
        Y0{i,1}=Y1234{i,1}+Temp_Y0{i,1}; 
    end

    
    %du
    for i=1:N
        Temp_Y_zad{i,1}=Y_1234{i,1}-Y0{i,1}; 
    end
    K_tmp = cell2mat(K);
    Y_zad_tmp = cell2mat(Temp_Y_zad);
    dU1234 = mat2cell(K_tmp *Y_zad_tmp,size,[1]);
    

    du=dU1234{1};
    
    for n=D-1:-1:2;
      dUp1234(n)=dUp1234(n-1);
    end
   
    u1(k)=u1(k-1)+du(1);
    u2(k)=u2(k-1)+du(2);
    u3(k)=u3(k-1)+du(3);
    u4(k)=u4(k-1)+du(4);
    dUp1234(1,1)={du};
    
    U1(k)=u1(k)+U1pp;  
    U2(k)=u2(k)+U2pp;
    U3(k)=u3(k)+U3pp;  
    U4(k)=u4(k)+U4pp;
    
end
 
EY=norm(Ey)^2




figure;
subplot(2,2,1);
stairs(U1);
xlabel('k');
ylabel('U1');
subplot(2,2,2);
stairs(U2);
xlabel('k');
ylabel('U2');
subplot(2,2,3);
stairs(U3);
xlabel('k');
ylabel('U3');
subplot(2,2,4);
stairs(U4);
xlabel('k');
ylabel('U4');


figure;
subplot(3,1,1);
stairs(Y1);
xlabel('k');
ylabel('Y1');
hold on;
stairs(Y1_zad);
hold off;
subplot(3,1,2);
stairs(Y2);
xlabel('k');
ylabel('Y2');
hold on;
stairs(Y2_zad);
hold off;
subplot(3,1,3);
stairs(Y3);
xlabel('k');
ylabel('Y3');
hold on;
stairs(Y3_zad);
hold off;