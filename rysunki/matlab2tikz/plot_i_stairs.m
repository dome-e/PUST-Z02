x = 0:.01:0.05;
y = sin(2*x.^2);

set(0,'defaulttextinterpreter','latex');
set(0,'DefaultLineLineWidth',1);
set(0,'DefaultStairLineWidth',1);

plot(x,y);
xlim([min(x) max(x)]);
xlabel('$x$')
ylabel('$y$')
matlab2tikz('plot.tex','width', '\fwidth' ,'height', '\fheight' ,'showInfo', false);

stairs(x,y);
xlim([min(x) max(x)]);
xlabel('$x$')
ylabel('$y$')
matlab2tikz('stairs.tex','width', '\fwidth' ,'height', '\fheight' ,'showInfo', false);

% opcja ,,width'' s³u¿y do nadpisania szerokoœci wykresu -- bêdzie ona
% równa tyle co wielkoœæ \fwidth zdefiniowana w LaTeX-u
% opcja ,,height'' s³u¿y do nadpisania wysokoœci wykresu -- bêdzie ona 
% równa tyle co wielkoœæ \fheight zdefiniowana w LaTeX-u

close all;