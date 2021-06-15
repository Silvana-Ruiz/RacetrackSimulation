% Pista Formula 1
% 28 nov 2020
% F1005B G1

puntos = 2701;
%velocidad = 378;
%radio = 277;
%omega = velocidad/radio;
deltaT = 1;

phi(1)=0;   % medida en radianes

%img = imread('pasto.jpg');
%theta = linspace(0,4*pi,200);
%image('CData',img,'XData',[-10 10],'YData',[-10 10])
%hold on
%plot(theta,sin(theta)./theta,'LineWidth',3)

% Ecuación pista 
x = 100:deltaT:2800;
y = -0.0000008726.*x.^3 + 0.0035708799.*x.^2 - 3.0021976698.*x + 1965.38354;

for i=2:puntos
    m = atan(y(i)-y(i-1))/(x(i)-x(i-1));
    phi(i) = m;
end
 
%gif1
figura=figure(1);
filename='formula1.gif';
axis([-20,20,0,25]);
set(gca,'color','green');

hold on

axis ([0 2900 1000 3500])

img = imread('pasto.jpg');
image('CData',img,'XData',[0 2900],'YData',[1000 3500])

plot(x,y,'-k','linewidth',30); % Pista
rectangle('Position',[479.171237202399993, 1157.110617195299938, 80, 10], 'FaceColor', [0.5, 0, 0]);
rectangle('Position',[2168.982097658899875, 3442.340393347200006, 80, 10], 'FaceColor', [0.5, 0, 0]);

plot(x,y,'--y','linewidth',1); %Lineas amarillas

%gif2
frame = getframe(figura);
im = frame2im(frame);
[imind, cm] = rgb2ind(im,256);
imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
 
e1 = 350; % escalar del quiver 1 = Ft
e2 = 350; % escalar del quiver 2 = Fn
for i=1:puntos
    trayectoria = plot(x(i),y(i),'.r','MarkerSize',4);
    carro = plot(x(i),y(i),'ks','MarkerFaceColor','green','MarkerSize',10);
    
    % Quiver Ft

    q1 = quiver(x(i),y(i),e1*cos(phi(i)),e1*sin(phi(i)),0,'m-','linewidth',2);
    t1 = text(x(i)+e1*cos(phi(i)),y(i)+e1*sin(phi(i)),'Ft','Color', 'm', 'fontsize', 10);
    
    if (x(i) > 200) && (x(i) < 840)
    % Quiver Fn
        q2 = quiver(x(i),y(i),e2*cos(phi(i)+pi/2),e2*sin(phi(i)+pi/2),0,'b-','linewidth',2);
        t2 = text(x(i)+e1*cos(phi(i)+pi/2),y(i)+e1*sin(phi(i)+ pi/2),'Fn','Color', 'b', 'fontsize', 10);
    elseif(x(i) > 1980) && (x(i) < 2400)
        % Quiver Fn
        q2 = quiver(x(i),y(i),e2*cos(phi(i)+3*pi/2),e2*sin(phi(i)+3*pi/2),0,'b-','linewidth',2);
        t2 = text(x(i)+e1*cos(phi(i)+pi/2),y(i)+e1*sin(phi(i)+ pi/2),'Fn','Color', 'b', 'fontsize', 10);
    end
    pause(0.000000001);
    
    %gif3
    frame = getframe(figura); 
    im = frame2im(frame);   
    [imind,cm] = rgb2ind(im,256);    
    imwrite(imind,cm,filename,'gif','WriteMode','append');
    
    delete(trayectoria);
    delete (carro);
    delete(q1);
    delete (t1);
    delete(q2);
    delete (t2);
end
