Y1_PP=3250;
Y2_PP=3525;
G1_PP=270;
G2_PP=320;
d1=211;

load('skokG1_27_40.mat');
n=211;
y1=y1(1:n);
y2=y2(1:n);
Uskok=400;


dU = Uskok - G1_PP;

s1_1 = zeros(1,n-d1);
for k = 1:n
    s1_1(k)=(y1(k)-Y1_PP)/dU;
end
s1_2 = zeros(1,n-d1);
for k = 1:n
    s1_2(k)=(y2(k)-Y2_PP)/dU;
end

load('skokG2_32_45mat.mat');
n=211;
y1=y1(1:n);
y2=y2(1:n);
Uskok=450;


dU = Uskok - G2_PP;

s2_1 = zeros(1,n-d1);
for k = 1:n
    s2_1(k)=(y1(k)-Y1_PP)/dU;
end
s2_2 = zeros(1,n-d1);
for k = 1:n
    s2_2(k)=(y2(k)-Y2_PP)/dU;
end

S=[s1_1 s1_2; s2_1 s2_2];
%% horyzonty
D = 180; % horyzont dynamiki
N = 180; % horyzont predykcji
Nu = 10; % horyzont sterowania
%% Wspolczynnik kary za przyrosty sterowania
lambda = 1;

%% DMC wyliczenia OFFLINE
% wyliczenie macierzy M

% wyliczenie macierzy Mp
M = zeros (N*2 , Nu*2 ) ;
for i =1: N
    for j =1: Nu
        if (i >= j )
            M((i-1)*2+1 , (j-1)*2+1 ) = s1_1(i - j +1) ;
            M((i-1)*2+1 , j*2 ) = s1_2(i - j +1) ;
            M(i*2, (j-1)*2+1 ) = s2_1(i - j +1) ;
            M(i*2, j*2 ) = s2_2(i - j +1) ;
        end
    end
end

MP = zeros (2*N, (D-1)*2) ;
for i=1:N
    for j =1: D -1
        if i +j <= D
            MP ((i-1)*2+1 , (j-1)*2+1 ) = s1_1( i+j ) -s1_1 ( j ) ; %U1Y1
            MP ((i-1)*2+1 , j*2 ) = s1_2( j+i ) -s1_2 ( j ) ; %U1Y2
            MP (i*2 , (j-1)*2+1 ) = s2_1( j+i ) -s2_1 ( j ) ; %U2Y1
            MP (i*2 , j*2 ) = s2_2( j+i ) -s2_2 ( j ) ; %U2Y2
        else
            MP ((i-1)*2+1 , (j-1)*2+1 ) = s1_1( D ) -s1_1 ( j ) ;
            MP ((i-1)*2+1 , j*2 ) = s1_2( D ) -s1_2 ( j ) ;
            MP (i*2 , (j-1)*2+1 ) = s2_1( D ) -s2_1 ( j ) ;
            MP (i*2 , j*2 ) = s2_2( D ) -s2_2 ( j ) ;
        end
    end
end
I=eye(Nu*2);
K = (( M' * M + I ) ^ -1) *M' ;
DMC_K11=0;
DMC_K12=0;
DMC_K21=0;
DMC_K22=0;

DMC_K11=sum(K(1,1:2:D));
DMC_K12=sum(K(1,2:2:D));
DMC_K21=sum(K(2,1:2:D));
DMC_K22=sum(K(2,2:2:D));

disp(sprintf("DMC_K11 := %f;\n", DMC_K11));
disp(sprintf("DMC_K12 := %f;\n", DMC_K12));
disp(sprintf("DMC_K21 := %f;\n", DMC_K21));
disp(sprintf("DMC_K22 := %f;\n", DMC_K22));

Kj1_1=zeros(1,D-1);
Kj1_2=zeros(1,D-1);
Kj2_1=zeros(1,D-1);
Kj2_2=zeros(1,D-1);

for j =1: D -1
    Kj1_1(j)=K(1,1:2:D)*MP(1:2:N,(j-1)*2+1);
    Kj1_2(j)=K(1,2:2:D)*MP(1:2:N,j*2);
    Kj2_1(j)=K(2,1:2:D)*MP(1:2:N,(j-1)*2+1);
    Kj2_2(j)=K(2,2:2:D)*MP(1:2:N,j*2);
    disp(sprintf("tablica[?].wiersz[j-1]:=%f; \n", Kj1_1));
end