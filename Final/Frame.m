classdef Frame < handle
    properties
        bodies;
    end
    
    methods
        function obj = Frame(bodies)
            obj.bodies = bodies;
        end
        
        function obj = addBody(obj,body)
            obj.bodies = [obj.bodies,body];
        end
        
        function obj = show(obj,lims)
            set(gcf,"Renderer",'opengl');
            shading flat
            cla
            
            for i = 1:length(obj.bodies)
                body = obj.bodies(i);
                ax = gca;
                xc = body.verts(1,:);
                yc = body.verts(2,:);
                zc = body.verts(3,:);
                xmax = lims(1);
                ymax = lims(2);
                zmax = lims(3);
                set(ax,'xlim',[-xmax xmax])
                set(ax,'ylim',[-ymax ymax])
                set(ax,'zlim',[-zmax zmax])
                hold on
                sc = 0.5;
                p = patch(ax,xc(body.faces), yc(body.faces), zc(body.faces),'k');
                q = quiver3(ax,[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[xmax,-xmax,0,0,0,0],[0,0,ymax,-ymax,0,0],[0,0,0,0,zmax,-zmax]);
                b1 = quiver3(ax,body.x,body.y,body.z,body.R(1,1)*body.length+body.R(1,1)*sc,body.R(2,1)*body.length+body.R(2,1)*sc,body.R(3,1)*body.length+body.R(3,1)*sc,1);
                b2 = quiver3(ax,body.x,body.y,body.z,body.R(1,2)*body.width+body.R(1,2)*sc,body.R(2,2)*body.width+body.R(2,2)*sc,body.R(3,2)*body.width+body.R(3,2)*sc,1);
                b3 = quiver3(ax,body.x,body.y,body.z,body.R(1,3)*body.height+body.R(1,3)*sc,body.R(2,3)*body.height+body.R(2,3)*sc,body.R(3,3)*body.height+body.R(3,3)*sc,1);
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
end