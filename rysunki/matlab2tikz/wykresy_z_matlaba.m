x = 0:.001:pi;
y = sin(2*x.^4);

set(0,'defaulttextinterpreter','latex');

plot(x,y,'linewidth',1);
xlim([min(x) max(x)]);
xlabel('$x$');
ylabel('$y$');
matlab2tikz('wykres_tex.tex','showInfo', false);