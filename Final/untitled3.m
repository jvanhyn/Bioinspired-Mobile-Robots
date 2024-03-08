close all
clear
clc

rot = @(w) expm(VecToso3(w));


cube = Cube(1,2,3,1);

for i = linspace(0,2*pi,100)
rotate(cube,rot([1;0;0]*i));
show(cube,[4,4,4])
drawnow
pause(0.01)
end

function w_dot = dynamics(t,x,cube)
wb = 
    w_dot = inv(cube.Ib)*(VecToso3(wb)*cube.Ib*wb)
end

function so3mat = VecToso3(omg)
so3mat = [0, -omg(3), omg(2); omg(3), 0, -omg(1); -omg(2), omg(1), 0];
end