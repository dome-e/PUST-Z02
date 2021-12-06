clear all;
set(0,'defaulttextinterpreter','latex');
set(0,'DefaultLineLineWidth',1);
set(0,'DefaultStairLineWidth',1);
n=250; %Okres symulacji
D=80;
dmcs=6; %liczba regulatorów DMC (musi być >1)
umax=1;
umin=-1;
set(0,'defaulttextinterpreter','latex');
set(0,'DefaultLineLineWidth',1);
set(0,'DefaultStairLineWidth',1);

N=60; Nu=6; lambda=0.2; 
%Punkty pracy
Upp=0;
Ypp=0;
uskok=zeros(dmcs,1);
for i=1:dmcs
    uskok(i)=umin+(i-1)*(umax-umin)/(dmcs-1);
end
Ms=cell(dmcs, 1) ;
Mps=cell(dmcs, 1) ;
Ks=cell(dmcs,1);
for j=1:dmcs    
    %Inicjalizacja macierzy i wektorów
    if(uskok(j))<=0
        upps=uskok(j+1);
    else
        upps=uskok(j-1);
    end
    if j==dmcs/2
        upps=0;
    elseif j==dmcs/2+1
        upps=0;
    end
    s=s_DMC(upps,uskok(j));
    M=zeros(N,Nu);
    for i=1:Nu
        M(i:N,i)=s(1:N-i+1);
    end
    
    Ms{j}=M;
    
    Mp=zeros(N,D-1);
    for i=1:(D-1)
        Mp(1:N,i)=s(i+1:N+i)-s(i);
    end
    Mps{j}=Mp;
    I=eye(Nu);
    K=((M'*M+lambda*I)^(-1))*M';
    Ks{j}=K;
end
dUp=zeros(D-1,1);
Y0s=cell(dmcs,1);
dU=zeros(Nu,1);
Y_zad_dmc=zeros(N,1);
Y_dmc=zeros(N,1);

U(1:n)=Upp;
Y(1:n)=Ypp;
Y_zad(1:9)=Ypp;
Y_zad(10:50)=-0.1;
Y_zad(51:100)=0.05;
Y_zad(101:150)=-0.9;
Y_zad(151:n)=-1.9;
u=U-Upp;
y_zad=Y_zad-Ypp;
y(1:n)=0;
e(1:n)=0;

    

    
for k=10:n
    Y(k)=symulacja_obiektu12y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2));
    y(k)=Y(k)-Ypp;
    e(k)=y_zad(k)-y(k); %Uchyb
    
    Y_dmc(1:N,1)=y(k);
    Y_zad_dmc(1:N,1)=y_zad(k);
    dU=0;
    wagi=0;
    for j=1:dmcs

        waga=gbellmf(U(k-1),[(umax-umin)/dmcs 4 uskok(j)]);
        Y0s{j}=Y_dmc+Mps{j}*dUp;
        dU=dU+Ks{j}*(Y_zad_dmc-Y0s{j})*waga;
        wagi=wagi+waga;
    end
    du=dU(1);
    du=du/wagi;
    for n=D-1:-1:2
      dUp(n)=dUp(n-1);
    end
    
    u(k)=u(k-1)+du;
    
    if (u(k)+ Upp)>umax
        u(k)=umax-Upp;
    end
    if (u(k)+ Upp)<umin
        u(k)=umin-Upp;
    end
    
    dUp(1)=u(k)-u(k-1);
    
    U(k)=u(k)+Upp;

    
end
 
E=(norm(e))^2 %Wskaźnik jakośći regulacji

subplot(2,1,1);
stairs(U);
title('u(k)');
xlabel('k');
ylabel('u');
subplot(2,1,2);
stairs(Y);
title('Y(k) i Y_z_a_d');
hold on;
stairs(Y_zad);
xlabel('k');
legend('y','y_z_a_d','Location','southeast');


% plot bell fun
x=[-1:0.05:1];
figure
for i=1:dmcs
y=gbellmf(x,[(umax-umin)/dmcs 4 uskok(i)]);
plot(x,y)
hold on;
end
