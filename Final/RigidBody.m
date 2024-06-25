classdef RigidBody < handle
    properties
        isOpen = false;
      
        isKeyW = false;
        isKeyS = false;
        isKeyA = false;
        isKeyD = false;
        isKeyQ = false;
        isKeyE = false;

        isKeyI = false;
        isKeyK = false;
        isKeyJ = false;
        isKeyL = false;
        isKeyU = false;
        isKeyO = false;

        x = 0;
        y = 0;
        z = 0;

        a = 0;
        b = 0;
        c = 0;

        dx = 0;
        dy = 0;
        dz = 0;

        da = 0;
        db = 0;
        dc = 0;

        ddx = 0;
        ddy = 0;
        ddz = 0;

        dda = 0;
        ddb = 0;
        ddc = 0;
        
        I = eye(3);
        m = 1;

        verts0 = [...
                -1  -1  -1;
                 1  -1  -1;
                 1   1  -1;
                -1   1  -1;
                -1  -1   1;
                 1  -1   1;
                 1   1   1;
                -1   1   1;
                ]';

        verts = [...
                -1  -1  -1;
                 1  -1  -1;
                 1   1  -1;
                -1   1  -1;
                -1  -1   1;
                 1  -1   1;
                 1   1   1;
                -1   1   1;
                ]';

        faces = [...
                 4 8 5 1 4;
                 1 5 6 2 1;
                 2 6 7 3 2;
                 3 7 8 4 3;
                 5 8 7 6 5;
                 1 4 3 2 1;
                 ]';
    end
    methods
        function obj = RigidBody()
            obj.x = 0;
            obj.y = 0;
            obj.z = 2;
            obj.a = 0;
            obj.b = 0;
            obj.c = 0;
        end

        function T = getRotationMatrix(obj)
            rotx = [1 0 0 0; 0 cos(obj.a) -sin(obj.a) 0; 0 sin(obj.a) cos(obj.a) 0; 0 0 0 1];
            roty = [cos(obj.b) 0 sin(obj.b) 0; 0 1 0 0; -sin(obj.b) 0  cos(obj.b) 0; 0 0 0 1];
            rotz = [cos(obj.c) -sin(obj.c) 0 0; sin(obj.c) cos(obj.c) 0 0; 0 0 1 0; 0 0 0 1];

            T = rotx*roty*rotz;
        end

        function T = getTranslationMatrix(obj)
            T = eye(4);
            T(1,end) = obj.x;
            T(2,end) = obj.y;
            T(3,end) = obj.z;
        end

        function getKeyPress(obj,event,keyData)
        
            if keyData.Key == "w"
                obj.isKeyW = true;
            end
            if keyData.Key == "s"
                obj.isKeyS = true;
            end
            if keyData.Key == "a"
                 obj.isKeyA = true;
            end
            if keyData.Key == "d"
                 obj.isKeyD = true;
            end
            if keyData.Key == "q"
                 obj.isKeyQ = true;
            end
            if keyData.Key == "e"
                 obj.isKeyE = true;
            end
            if keyData.Key == "i"
                obj.isKeyI = true;
            end
            if keyData.Key == "k"
                obj.isKeyK = true;
            end
            if keyData.Key == "j"
                 obj.isKeyJ = true;
            end
            if keyData.Key == "l"
                 obj.isKeyL = true;
            end
            if keyData.Key == "u"
                 obj.isKeyU = true;
            end
            if keyData.Key == "o"
                 obj.isKeyO = true;
            end
           
            if keyData.Key == "p"
                obj.isOpen = false;
                disp("Quitted")
            end
        end

        function getKeyRelease(obj,event,keyData)
        
            if keyData.Key == "w"
                obj.isKeyW = false;
            end
            if keyData.Key == "s"
                obj.isKeyS = false;
            end
            if keyData.Key == "a"
                 obj.isKeyA = false;
            end
            if keyData.Key == "d"
                 obj.isKeyD = false;
            end
            if keyData.Key == "q"
                 obj.isKeyQ = false;
            end
            if keyData.Key == "e"
                 obj.isKeyE = false;
            end
            if keyData.Key == "i"
                obj.isKeyI = false;
            end
            if keyData.Key == "k"
                obj.isKeyK = false;
            end
            if keyData.Key == "j"
                 obj.isKeyJ = false;
            end
            if keyData.Key == "l"
                 obj.isKeyL = false;
            end
            if keyData.Key == "u"
                 obj.isKeyU = false;
            end
            if keyData.Key == "o"
                 obj.isKeyO = false;
            end
        end

        function updateKeys(obj)
            obj.dda = 0;
            obj.ddb = 0;
            obj.ddc = 0;
            obj.ddx = 0;
            obj.ddy = 0;
            obj.ddz = 0;

            k = 5;
            if obj.isKeyW
                obj.dda = 1;
            end
            if obj.isKeyS
                obj.dda = -1;
            end
            if obj.isKeyA
                obj.ddb = 1;
            end
            if obj.isKeyD
                obj.ddb = -1;
            end
            if obj.isKeyQ
                obj.ddc = 1;
            end
            if obj.isKeyE
                obj.ddc = -1;
            end

            if obj.isKeyI
                obj.ddz = k*1;
            end
            if obj.isKeyK
                obj.ddz = k*-1;
            end
            if obj.isKeyJ
                obj.ddy = k*1;
            end
            if obj.isKeyL
                obj.ddy = k*-1;
            end
            if obj.isKeyU
                obj.ddx = k*1;
            end
            if obj.isKeyO
                obj.ddx = k*-1;
            end

        end
       

        function updateVerticies(obj)
            obj.verts = (obj.getTranslationMatrix()*obj.getRotationMatrix())*[obj.verts0;ones(1,8)];

        end
        
        function updatePhysicsEuler(obj)
            dt = 0.01; 
            

            X = [obj.a obj.b obj.c obj.da obj.db obj.dc obj.x obj.y obj.z obj.dx obj.dy obj.dz]';
            TAU = [obj.dda;obj.ddb;obj.ddc];
            F = obj.getRotationMatrix()*[obj.ddx;obj.ddy;obj.ddz;1];
            F = F(1:3);

            if obj.z-1 < 0
                K = -10;
                d = -10;
                F(3) = F(3)+ K*(obj.z-1) + d*obj.dz;
            end
           
            X = X + dt*obj.dynamics(TAU,F);

            obj.a = X(1);
            obj.b = X(2);
            obj.c = X(3);
            obj.da = X(4);
            obj.db = X(5);
            obj.dc = X(6);
        
            obj.x = X(7);
            obj.y = X(8);
            obj.z = X(9);
            obj.dx = X(10);
            obj.dy = X(11);
            obj.dz = X(12);
        end


        function updateDisplay(obj)
            cla   
            ax = gca;
            s = 10;
            xc = obj.verts(1,:);
            yc = obj.verts(2,:);
            zc = obj.verts(3,:);
            
            hold on
            p1 = patch(ax,xc(obj.faces(:,1)), yc(obj.faces(:,1)), zc(obj.faces(:,1)),'r');
            p2 = patch(ax,xc(obj.faces(:,2)), yc(obj.faces(:,2)), zc(obj.faces(:,2)),'g');
            p3 = patch(ax,xc(obj.faces(:,3)), yc(obj.faces(:,3)), zc(obj.faces(:,3)),'b');
            p4 = patch(ax,xc(obj.faces(:,4)), yc(obj.faces(:,4)), zc(obj.faces(:,4)),'c');
            p5 = patch(ax,xc(obj.faces(:,5)), yc(obj.faces(:,5)), zc(obj.faces(:,5)),'y');
            p6 = patch(ax,xc(obj.faces(:,6)), yc(obj.faces(:,6)), zc(obj.faces(:,6)),'m');
            patch(ax,[-s+obj.x;-s+obj.x;s+obj.x;s+obj.x],[-s+obj.y;s+obj.y;s+obj.y;-s+obj.y],[0;0;0;0])
            
            patch(ax,[-s+obj.x;-s+obj.x;s+obj.x;s+obj.x],[-s+obj.y;s+obj.y;s+obj.y;-s+obj.y],[-0.01;-0.01;-0.01;-0.01],"FaceColor",[0.5,0.5,1])
            patch(ax,xc(obj.faces(:,1)), yc(obj.faces(:,1)), 1e-4*ones(5,1),'k');
            patch(ax,xc(obj.faces(:,2)), yc(obj.faces(:,2)), 2e-4*ones(5,1),'k');
            patch(ax,xc(obj.faces(:,3)), yc(obj.faces(:,3)), 3e-4*ones(5,1),'k');
            patch(ax,xc(obj.faces(:,4)), yc(obj.faces(:,4)), 4e-4*ones(5,1),'k');
            patch(ax,xc(obj.faces(:,5)), yc(obj.faces(:,5)), 5e-4*ones(5,1),'k');
            patch(ax,xc(obj.faces(:,6)), yc(obj.faces(:,6)), 6e-4*ones(5,1),'k');
            
            hold off

            set(ax,'xlim',[-s+obj.x,s+obj.x])
            set(ax,'ylim',[-s+obj.y,s+obj.y])
            set(ax,'zlim',[-s+obj.z,s+obj.z])

            
            set([p1,p2,p3,p4,p5,p6],"EdgeColor", 'k');
            set([p1,p2,p3,p4,p5,p6],"LineWidth", 2);

            pbaspect([1,1,1])
            daspect([1,1,1])

            axis vis3d
            grid on
            
            
            view(135,30);
            drawnow
        end

        function x_dot = dynamics(obj,tau,f)
            % x = [obj.x,obj.y,obj.z]';
            dx = [obj.dx,obj.dy,obj.dz]';
            % theta = [obj.a,obj.b,obj.c]';
            dtheta = [obj.da,obj.db,obj.dc]';
            x_dot = [dtheta; inv(obj.I)*(cross(dtheta,obj.I*dtheta)) + inv(obj.I)*tau; dx; f./obj.m + [0;0;-1]];
        end

        function show(obj)
            obj.isOpen = true;
            fig = gcf;
            set(fig,"KeyPressFcn",@obj.getKeyPress);
            set(fig,"KeyReleaseFcn",@obj.getKeyRelease);
            set(fig,"Renderer",'opengl');
            shading flat
            while obj.isOpen
                obj.updateKeys()
                obj.updatePhysicsEuler()
                obj.updateVerticies()
                obj.updateDisplay()
            pause(0.0001)
            end
            close
        end

    end
end

% function se3mat = VecTose3(obj,V)
        %     se3mat = [[0, -V(3), V(2); V(3), 0, -V(1); -V(2), V(1), 0], V(4: 6); 0, 0, 0, 0];
        % end
        % 
        
