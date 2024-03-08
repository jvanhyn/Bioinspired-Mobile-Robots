close all
clear
clc

R = @(w,theta) rotationVectorToMatrix(w*theta);
T = @(w,theta,x,y,z) [[R(w,theta);0 0 0], [x;y;z;1]];

l = 1;
w = 1;
h = 1;

xmax = 3;
ymax = 3;
zmax = 3;

cube = [...
    -l   -w  -h 1;
    l    -w  -h 1;
    l    w   -h 1;
    -l   w   -h 1;
    -l   -w   h 1;
    l    -w   h 1;
    l    w    h 1;
    -l    w   h 1;
    ]';


idx = [4 8 5 1 4; 1 5 6 2 1; 2 6 7 3 2; 3 7 8 4 3; 5 8 7 6 5; 1 4 3 2 1]';

% I_B
% w_dot = inv(I_B) * (cross_matrix(w) * I_B * w')'

close
fig1 = figure();
set(fig1,'color','w');
ax = gca;

theta = linspace(0,2*pi,100);
for i = 1:length(theta)
T_sb = T([0,0,1],theta(i),0,0,0);
coord = T_sb*cube;
xc = coord(1,:);
yc = coord(2,:);
zc = coord(3,:);

bx = 0;
by = 0;
bz = 0;

brx = T_sb*[1;0;0;1];
bry = T_sb*[0;1;0;1];
brz = T_sb*[0;0;1;1];
cla
hold on
set(ax,'xlim',[-xmax xmax])
set(ax,'ylim',[-ymax ymax])
set(ax,'zlim',[-zmax zmax])
q = quiver3(ax,[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[xmax,-xmax,0,0,0,0],[0,0,ymax,-ymax,0,0],[0,0,0,0,zmax,-zmax]);
b1 = quiver3(ax,bx,by,bz,brx(1)'*l,brx(2)'*l,brx(3)'*l,1.5);
b2 = quiver3(ax,bx,by,bz,bry(1)'*w,bry(2)'*w,bry(3)'*w,1.5);
b3 = quiver3(ax,bx,by,bz,brz(1)'*h,brz(2)'*h,brz(3)'*h,1.5);

p = patch(ax,xc(idx), yc(idx), zc(idx),'k');
hold off
set(b1,"LineWidth",5)
set(b1,"Color",'r')
set(b1,"ShowArrowHead",'off')
set(b2,"LineWidth",5)
set(b2,"Color",'g')
set(b2,"ShowArrowHead",'off')
set(b3,"LineWidth",5)
set(b3,"Color",'b')
set(b3,"ShowArrowHead",'off')
set(q,"Color",'k')
set(p,"FaceColor", [.7 .7 .7])
set(p,"EdgeColor", [0 0 0]);
set(p,"LineWidth", 1);
pbaspect([1,1,1])
daspect([1,1,1])
axis vis3d
axis off
view(135,30);
drawnow
pause(0.01)
end 


