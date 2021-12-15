function s=licz_s(u1, u2)

    y_temp = wynik_y(u1);
    Y=zeros(1,200);
    U=zeros(1,200);
    Y(1:15)=y_temp;
    U(1:10)=u1;
    U(11:200)=u2;
    
    for k=7:1:200
            Y(k)=symulacja_obiektu2y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2));
    end
    for j=1:1:190
        s(j)=(Y(j+10)-y_temp)/(u2-u1);
    end
    

end