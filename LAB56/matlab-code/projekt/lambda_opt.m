function E=lambda_opt(X)
    %Punkty pracy
    Upp=0;
    Ypp=0;

    %Ograniczenia
    u_max=1;
    u_min=-1;

    %Ilo�� regulator�w lokalnych
    regulator = 2;

    %rozne_lambdy=
    %0 - wszystkie regulatory maj� jednakow� warto�c lambda
    %1 - regulatory maj� r�ne warto�ci lambda
    rozne_lambdy=0;
    typ_regulatora = 'DMC';
    y_przedzial = rozklad(regulator, typ_regulatora);
    if regulator==2
        D={25, 25};
        lambda={X(1) X(2)};
    elseif regulator==3
        D={25, 25, 25};
        lambda={X(1) X(2) X(3)};
    elseif regulator==4
        D={25, 25, 25, 25};
        lambda={X(1) X(2) X(3) X(4)};
    elseif regulator==5
        D={25, 25, 25, 25, 52};
        lambda={X(1) X(2) X(3) X(4) X(5)};
    end

    N=D;
    Nu=D;


    %Wektory odpowiedzi skokowych
    s=cell(1, regulator);
    for i=1:regulator
        U_tmp(1:200)=u_rozmyte(i,2);
        U_tmp(20:200)=u_rozmyte(i,3);
        Y_tmp(1:200)=wartosc_y(u_rozmyte(i,2));
        for k=7:200
            Y_tmp(k)=symulacja_obiektu11y(U_tmp(k-5),U_tmp(k-6),Y_tmp(k-1),Y_tmp(k-2));
        end
        for j=1:180
            s_tmp(j)=(Y_tmp(j+20)-wartosc_y(u_rozmyte(i,2)))/(u_rozmyte(i,3)-u_rozmyte(i,2));
        end
        s{i}=s_tmp;
    end                                              

    %Inicjalizacja macierzy i wektor�w dla regulator�w
    dup=cell(1,regulator); 
    M=cell(1,regulator);   
    Mp=cell(1,regulator);
    K=cell(1,regulator);
    Ku=cell(1,regulator);
    Ke=cell(1,regulator);

    for k=1:regulator
        dup{k}(1:D{k}-1) = 0;

        M{k}=zeros(N{k},Nu{k});
        for i=1:N{k}
           for j=1:Nu{k}
              if (i>=j)
                 M{k}(i,j)=s{k}(i-j+1);
              end;
           end;
        end;

        Mp{k}=zeros(N{k},D{k}-1);
        for i=1:N{k}
           for j=1:D{k}-1
              if i+j<=D{k}
                 Mp{k}(i,j)=s{k}(i+j)-s{k}(j);
              else
                 Mp{k}(i,j)=s{k}(D{k})-s{k}(j);
              end;      
           end;
        end;

        K{k}=((M{k}'*M{k}+lambda{k}*eye(Nu{k}))^-1)*M{k}';
        Ku{k}=K{k}(1,:)*Mp{k};
        Ke{k}=sum(K{k}(1,:));
    end

    n=1400; %Okres symulacji
    U(1:n)=Upp;
    Y(1:n)=Ypp;
    Y_zad(1:10)=Ypp;
    Y_zad(11:250)=-1;
    Y_zad(251:500)=-3;
    Y_zad(501:750)=-2;
    Y_zad(751:1000)=0;
    Y_zad(1001:1400)=-2.5;
    u=U-Upp;
    y_zad=Y_zad-Ypp;
    y(1:n)=0;
    e(1:n)=0;

    for k=7:n 
       Y(k)=symulacja_obiektu2y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2)); 
       y(k)=Y(k)-Ypp;
       e(k)=y_zad(k)-y(k);

       u(k)=u(k-1);
       for i=1:regulator
            du{i}=Ke{i}*e(k)-Ku{i}*dup{i}'; %regulator
            for n=D{i}-1:-1:2
                dup{i}(n)=dup{i}(n-1);
            end
            dup{i}(1)=du{i};
            mi{i}=trapmf(y(k),y_rozmyte(i,:)); %trapezowa funkcja przynaleznosci
            u(k)=u(k)+mi{i}*dup{i}(1);
       end

       if u(k)>u_max
            u(k)=u_max;
       end
       if u(k)<u_min
            u(k)=u_min;
       end

       U(k)=u(k)+Upp;   
    end

    E=(norm(e))^2; %Wska�nik jako�ci regulacji
end