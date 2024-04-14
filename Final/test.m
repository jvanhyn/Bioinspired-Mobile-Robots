close all
clear
clc

rot = @(w) expm(VecToso3(w));
rotx = @(t) [1 0 0; 0 cos(t) -sin(t) ; 0 sin(t) cos(t)] ;
roty = @(t) [cos(t) 0 sin(t) ; 0 1 0 ; -sin(t) 0  cos(t)] ;
rotz = @(t) [cos(t) -sin(t) 0 ; sin(t) cos(t) 0 ; 0 0 1] ;

st = linspace(0,10,100);

cube = Cube(0,0,0,1,1,1);
cube.m = 1;

F = [0.1,0,0,0.01,0,0]';
cube1 = Cube(0,0,1,1,1,1);
cube2 = Cube(0,0,-2,1,1,1);

% frame = Frame([cube1,cube2]);
% frame.show([4,4,4])

% cube.show([4,4,4])

[t,y] = ode45(@(t,x) dynamics(t,x,F,cube),st,[cube.x,cube.y,cube.z,0,0,0,0,0,0,0,0,0]);

% figure(1)
% hold on
% plot(t,y(:,7),'LineWidth',2)
% plot(t,y(:,8),'LineWidth',2)
% plot(t,y(:,9),'LineWidth',2)
% hold off

for i = 1:length(t)
transform(cube,rotx(y(i,1))*roty(y(i,2))*rotz(y(i,3)),y(i,7:9)');
show(cube,[4,4,4])
drawnow
pause(0.01)
end

function x_dot = dynamics(t,x,F,cube)
    tau = F(1:3);
    f = F(4:end);
    wb = x(4:6);
    dxyz = x(10:12);
    x_dot = [wb; inv(cube.Ib)*(VecToso3(wb)*cube.Ib*wb) + inv(cube.Ib)*tau; dxyz; f./cube.m];
end

function so3mat = VecToso3(omg)
so3mat = [0, -omg(3), omg(2); omg(3), 0, -omg(1); -omg(2), omg(1), 0];
end