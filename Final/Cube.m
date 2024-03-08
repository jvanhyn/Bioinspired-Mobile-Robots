classdef Cube < handle

    properties
        x;
        y;
        z;
        R;
        width = 1;
        length = 1;
        height = 1;

        Ib;
        m = 1;

        verts0 = [...
                -1  -1  -1;
                1   -1  -1;
                1   1   -1;
                -1  1   -1;
                -1  -1  1;
                1   -1  1;
                1   1   1;
                -1  1   1;
                ]';

        verts = [...
                -1  -1  -1;
                1   -1  -1;
                1   1   -1;
                -1  1   -1;
                -1  -1  1;
                1   -1  1;
                1   1   1;
                -1  1   1;
                ]';

        faces = [4 8 5 1 4; 1 5 6 2 1; 2 6 7 3 2; 3 7 8 4 3; 5 8 7 6 5; 1 4 3 2 1]';
    end

    methods
        function obj = Cube(l,w,h,m)
            obj.width = w;
            obj.length = l;
            obj.height = h;
            obj.x = 0;
            obj.y = 0;
            obj.z = 0;
            obj.R = eye(3);
            obj.m = m;
            obj.Ib = diag([m*w*h/6,m*l*h/6,m*l*w/6]);
            obj.generate;
        end

        function obj = generate(obj)
            obj.verts0 = [...
                        -obj.length  -obj.width  -obj.height;
                        obj.length   -obj.width  -obj.height;
                        obj.length   obj.width   -obj.height;
                        -obj.length  obj.width   -obj.height;
                        -obj.length  -obj.width  obj.height;
                        obj.length   -obj.width  obj.height;
                        obj.length   obj.width   obj.height;
                        -obj.length  obj.width   obj.height;
                        ]';
        end
        
        function obj = rotate(obj,Rr)
            obj.R = Rr;
            obj.verts = Rr*obj.verts0; 
        end

        function show(obj,lims)
            cla
            ax = gca;
            xc = obj.verts(1,:);
            yc = obj.verts(2,:);
            zc = obj.verts(3,:);
            xmax = lims(1);
            ymax = lims(2);
            zmax = lims(3);
            set(ax,'xlim',[-xmax xmax])
            set(ax,'ylim',[-ymax ymax])
            set(ax,'zlim',[-zmax zmax])
            hold on
            p = patch(ax,xc(obj.faces), yc(obj.faces), zc(obj.faces),'k');
            q = quiver3(ax,[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[xmax,-xmax,0,0,0,0],[0,0,ymax,-ymax,0,0],[0,0,0,0,zmax,-zmax]);
            b1 = quiver3(ax,obj.x,obj.y,obj.z,obj.R(1,1)*obj.length,obj.R(2,1)*obj.length,obj.R(3,1)*obj.length,1.1);
            b2 = quiver3(ax,obj.x,obj.y,obj.z,obj.R(1,2)*obj.width,obj.R(2,2)*obj.width,obj.R(3,2)*obj.width,1.1);
            b3 = quiver3(ax,obj.x,obj.y,obj.z,obj.R(1,3)*obj.height,obj.R(2,3)*obj.height,obj.R(3,3)*obj.height,1.1);
            legend([b1,b2,b3],["x","y","z"])
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
        end
    end
end