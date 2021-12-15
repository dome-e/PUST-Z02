function s = odp_skok(Uskok)
    n=300;
    Upp=0;
    Ypp=0;
    U(1:7)=Upp;
    Y(1:n)=Ypp;
    U(7:n)=Uskok;

    for k = 7:n
        Y(k)=symulacja_obiektu2y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2));
    end

    d1 = 7; % pierwszy skok z zad2 dla toru U-Y

    dU = Uskok - Upp;

    s = zeros(1,n-d1);
    for k = 1:n-d1
        s(k)=(Y(k+d1)-Ypp)/dU;
    end
end
