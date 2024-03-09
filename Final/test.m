close all
clear
clc

rot = @(w) expm(VecToso3(w));
rotx = @(t) [1 0 0; 0 cos(t) -sin(t) ; 0 sin(t) cos(t)] ;
roty = @(t) [cos(t) 0 sin(t) ; 0 1 0 ; -sin(t) 0  cos(t)] ;
rotz = @(t) [cos(t) -sin(t) 0 ; sin(t) cos(t) 0 ; 0 0 1] ;


tau = [0.1,0.1,0]';
cube = Cube(1,2,3,1);

[t,y] = ode45(@(t,x) dynamics(t,x,tau,cube),[0,10],[0,0,0,0,0,0]);

figure(1)
hold on
plot(t,y(:,1))
plot(t,y(:,2))
plot(t,y(:,3))
hold off

for i = 1:length(t)
rotate(cube,rotx(y(i,1))*roty(y(i,2))*rotz(y(i,3)));
show(cube,[4,4,4])
drawnow
pause(0.01)
end

function x_dot = dynamics(t,x,tau,cube)
    wb = x(4:end);
    x_dot = [wb; inv(cube.Ib)*(VecToso3(wb)*cube.Ib*wb) + inv(cube.Ib)*tau];
end

function so3mat = VecToso3(omg)
so3mat = [0, -omg(3), omg(2); omg(3), 0, -omg(1); -omg(2), omg(1), 0];
end