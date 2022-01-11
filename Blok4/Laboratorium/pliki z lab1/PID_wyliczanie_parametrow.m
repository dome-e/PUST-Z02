Tp = 4;


% K = ;
% Ti = ;
% Td - ;


Kkr = 23;
Tkr = 70;
K = 0.6 * Kkr;
Ti = 0.5 * Tkr;
Td = 0.125 * Tkr;

r0 = K*(1 + Tp/(2*Ti) + Td/Tp);
r1 = K*(-1 + Tp/(2*Ti) - 2*Td/Tp);
r2 = K*Td/Tp;