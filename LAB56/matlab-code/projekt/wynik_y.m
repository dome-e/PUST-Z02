function y = wynik_y(u)
    U_sym(1:200)=u;
    Y_sym(1:200)=0;
    for k=7:200
        Y_sym(k)=symulacja_obiektu2y_p3(U_sym(k-5),U_sym(k-6),Y_sym(k-1),Y_sym(k-2));
    end
    y=Y_sym(200);
end