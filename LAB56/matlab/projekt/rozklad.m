function wekt=rozklad(regulator,typ_r)

if typ_r == 'PID'
    Ymin = -0.2;
    Ymax = 4.75;
    Yw= Ymin:0.05:Ymax;
    if regulator ==2
       wekt_w1 = gbellmf(Yw, [(Ymax-Ymin)/2 (Ymax-Ymin) Ymax*-0.5]);
       wekt_w2 = gbellmf(Yw, [(Ymax-Ymin)/2 (Ymax-Ymin)/3 Ymax*0.8]); 
       wekt = [wekt_w1; wekt_w2];
    end
    if regulator ==3
        wekt_w1 = gbellmf(Yw, [(Ymax-Ymin)/4 (Ymax-Ymin)/2 Ymin]);
        wekt_w2 = gbellmf(Yw, [(Ymax - Ymin)/4 (Ymax-Ymin)/2 0.25*Ymax]);
        wekt_w3 = gbellmf(Yw, [(Ymax - Ymin)/4 (Ymax-Ymin)/2 0.57*Ymax]);
        wekt = [wekt_w1; wekt_w2; wekt_w3];
    end
    if regulator ==4
        wekt_w1 = gbellmf(Yw, [(Ymax-Ymin)/6 (Ymax-Ymin)/2 Ymin]);
        wekt_w2 = gbellmf(Yw, [(Ymax - Ymin)/6 (Ymax-Ymin)/2 0.15*Ymax]);
        wekt_w3 = gbellmf(Yw, [(Ymax - Ymin)/6 (Ymax-Ymin)/2 0.5*Ymax]);
        wekt_w4 = gbellmf(Yw, [(Ymax - Ymin)/6 (Ymax-Ymin)/2 0.9*Ymax]);
        wekt = [wekt_w1; wekt_w2; wekt_w3; wekt_w4];
    end
    if regulator ==5
        wekt_w1 = gbellmf(Yw, [(Ymax - Ymin)/8 (Ymax-Ymin)/2 Ymin]);
        wekt_w2 = gbellmf(Yw, [(Ymax - Ymin)/8 (Ymax-Ymin)/2 0.2*Ymax]);
        wekt_w3 = gbellmf(Yw, [(Ymax - Ymin)/8 (Ymax-Ymin)/2 0.5*Ymax]);
        wekt_w4 = gbellmf(Yw, [(Ymax - Ymin)/8 (Ymax-Ymin)/2 0.8*Ymax]);
        wekt_w5 = gbellmf(Yw, [(Ymax - Ymin)/8 (Ymax-Ymin)/2 1*Ymax]);
        wekt = [wekt_w1; wekt_w2; wekt_w3; wekt_w4; wekt_w5];
    end
end 

if typ_r =='DMC'
    Uw = -1:0.01:1;
    Umax = 1;
    Umin=-1;

    if regulator ==2
       wekt_w1 = gbellmf(Uw, [0.5 4 -0.2]);
       wekt_w2 = gbellmf(Uw, [0.4 4 0.7]); 
       wekt = [wekt_w1; wekt_w2];
    end
    if regulator ==3
        wekt_w1 = gbellmf(Uw, [0.4 4 -0.5]);
        wekt_w2 = gbellmf(Uw, [(Umax - Umin)/6 2 0.3]);
        wekt_w3 = gbellmf(Uw, [(Umax - Umin)/6 2 1]);
        wekt = [wekt_w1; wekt_w2; wekt_w3];
    end
    if regulator ==4
        wekt_w1 = gbellmf(Uw, [0.4 4 -0.5]);
        wekt_w2 = gbellmf(Uw, [(Umax - Umin)/10 2 0.2]);
        wekt_w3 = gbellmf(Uw, [(Umax - Umin)/10 2 0.6]);
        wekt_w4 = gbellmf(Uw, [(Umax - Umin)/10 2 1]);
        wekt = [wekt_w1; wekt_w2; wekt_w3; wekt_w4];
    end
    if regulator ==5
        wekt_w1 = gbellmf(Uw, [0.4 4 -0.5]);
        wekt_w2 = gbellmf(Uw, [(Umax - Umin)/15 5 0.2]);
        wekt_w3 = gbellmf(Uw, [(Umax - Umin)/15 5 0.5]);
        wekt_w4 = gbellmf(Uw, [(Umax - Umin)/15 5 0.8]);
        wekt_w5 = gbellmf(Uw, [(Umax - Umin)/15 5 1]);
        wekt = [wekt_w1; wekt_w2; wekt_w3; wekt_w4; wekt_w5];
    end
end
end