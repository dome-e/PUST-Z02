%Punkty pracy
    Upp=0;
    Ypp=0;

    %Ograniczenia
    u_max=1;
    u_min=-1;

    % Dobor regulatorow
    regulator = 4;
    % typ_regulatora = 'PID/';
    typ_regulatora = 'PID';
    
    % dobor_lambdy=
    % 0 - zadanie 6
    % 1 - zadanie 7
    dobor_lambda = 0;

    u_reg=zeros(2,regulator);
    u_przedzial = rozklad(regulator, typ_regulatora);
    if regulator==2
        D={40, 30};
        u_reg=zeros(2,regulator);

        u_reg(1,:)=[0.22,0.7];
        u_reg(2,:)=[0.3,0.8];
        if dobor_lambda==0
            lambda={1 1};
        elseif dobor_lambda==1
            lambda={9.3 21.2};
        end
    elseif regulator==3
        D={30, 20, 35};
        u_reg(1,:)=[0.2, 0.4, 0.7];
        u_reg(2,:)=[0.25, 0.48, 0.9];
        if dobor_lambda==0
            lambda={1 1 1};
        elseif dobor_lambda==1
            lambda={4.1 9.5 17};
        end
    elseif regulator==4
        D={42, 41, 23, 27};
        u_reg(1,:)=[-0.1, 0.2, 0.5, 0.9];
        u_reg(2,:)=[0.2, 0.25, 0.7, 1];
        if dobor_lambda==0
            lambda={1 1 1 1};
        elseif dobor_lambda==1
            lambda={2.1 2.2 7.2 1.1};
        end
    elseif regulator==5
        D={42, 41, 22, 23, 26};
        u_reg(1,:)=[-0.1, 0.2, 0.5, 0.9, 1];
        u_reg(2,:)=[0.2, 0.25, 0.7, 0.9, 1];
        if dobor_lambda==0
            lambda={1 1 1 1 1};
        elseif dobor_lambda==1
            lambda={X(1) X(2) X(3) X(4) X(5)};
        end
    end

    N=D;
    Nu=D;


    %Wektory odpowiedzi skokowych
    s=cell(1, regulator);
    for i=1:regulator
        s{i}=licz_s(u_reg(1,i),u_reg(2,i));
    end                                              

    %Inicjalizacja macierzy i wektorów dla regulatorów
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
              end
           end
        end

        Mp{k}=zeros(N{k},D{k}-1);
        for i=1:N{k}
           for j=1:D{k}-1
              if i+j<=D{k}
                 Mp{k}(i,j)=s{k}(i+j)-s{k}(j);
              else
                 Mp{k}(i,j)=s{k}(D{k})-s{k}(j);
              end      
           end
        end

        K{k}=((M{k}'*M{k}+lambda{k}*eye(Nu{k}))^-1)*M{k}';
        Ku{k}=K{k}(1,:)*Mp{k};
        Ke{k}=sum(K{k}(1,:));
    end

    n=1000; %Okres symulacji
    U(1:n)=Upp;
    Y(1:n)=Ypp;
    Y_zad(1:10)=Ypp;
    Y_zad(11:250)=1;
    Y_zad(251:500)=3.5;
    Y_zad(501:750)=2;
    Y_zad(750:1000)=0;
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
            du=Ke{i}*e(k)-Ku{i}*dup{i}'; %regulator
            for n=D{i}-1:-1:2
                dup{i}(n)=dup{i}(n-1);
            end
            dup{i}(1)=du;
            ind=floor(dup{i}(1)/0.01)+100;
            if ind<1
                ind = 1;
            end
            if ind>201
                    ind = 201;
            end
            u(k)=u(k)+u_przedzial(i,floor(Y(k)/0.05)+6)*dup{i}(1)/sum(u_przedzial(:,floor(Y(k)/0.05)+6));
            
       end

       if u(k)>u_max
            u(k)=u_max;
       end
       if u(k)<u_min
            u(k)=u_min;
       end

       U(k)=u(k)+Upp;   
    end

    E=(norm(e))^2 %WskaŸnik jakoœci regulacji
    
    subplot(2,1,1);
stairs(U);
% title('u(k)');
xlabel('k');
ylabel('U');
subplot(2,1,2);
stairs(Y);
% title('Y(k) i Y_z_a_d');
hold on;
stairs(Y_zad);
xlabel('k');
ylabel('Y');
legend('y','y_z_a_d','Location','southeast');
hold off