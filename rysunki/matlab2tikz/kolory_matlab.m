x = 0:.01:2*pi;
y1 = sin(x);
y2 = -sin(x);
y3 = cos(x);
y4 = -cos(x);
y5 = sin(x)+cos(x);
y6 = sin(x)-cos(x);
y7 = cos(x)-sin(x);

set(0,'defaulttextinterpreter','latex');
set(0,'DefaultLineLineWidth',1);
set(0,'DefaultStairLineWidth',1);

figure;
plot(x,y1);
hold on;
plot(x,y2);
plot(x,y3);
plot(x,y4);
plot(x,y5);
plot(x,y6);
plot(x,y7);
xlabel('$x$')
ylabel('$y$')
matlab2tikz('wykres_kolory1.tex','showInfo', false);

figure;
plot(x,y1,'r');
hold on;
plot(x,y2,'g');
plot(x,y3,'b');
plot(x,y4,'c');
plot(x,y5,'m');
plot(x,y6,'y');
plot(x,y7,'k');
xlabel('$x$')
ylabel('$y$')
matlab2tikz('wykres_kolory2.tex','showInfo', false);
