
import matplotlib.pyplot as plt
import numpy as np

def draw_robot(ordered_list_of_transformations):
    """
    Draw the configuration of the three-link jumper.
    """
    ax_lw = 3
    link_lw = 1

    # homogeneous unit vectors 
    x = np.array([[1, 0, 1]]).T 
    y = np.array([[0, 1, 1]]).T
    origin = np.array([[0, 0, 1]]).T

    prev_origin = np.array([[0, 0, 1]]).T    
    current_transformation = np.eye(3)

    # plt.clf()
    ax = plt.gca()  # get current axis

    # now we plot
    plt.plot([prev_origin[0][0]], [prev_origin[1][0]], '-ko',linewidth=link_lw)
    plt.plot([prev_origin[0][0], x[0][0]], [prev_origin[1][0], x[1][0]], '-ro', linewidth=ax_lw)
    plt.plot([prev_origin[0][0], y[0][0]], [prev_origin[1][0], y[1][0]], '-go', linewidth=ax_lw)


    # loop the transforms in order of T_01, T_12, ... , T_N-1N
    for k, transform in enumerate(ordered_list_of_transformations):

        # update the transformation
        current_transformation = current_transformation @ transform
        new_origin = current_transformation @ origin
        new_x = current_transformation @ x
        new_y = current_transformation @ y

        # now we plot
        plt.plot([prev_origin[0][0], new_origin[0][0]], 
                 [prev_origin[1][0], new_origin[1][0]], 
                 '-ko',linewidth=link_lw)
        
        plt.plot([new_origin[0][0], new_x[0][0]], [new_origin[1][0], new_x[1][0]], '-r', linewidth=ax_lw)
        plt.plot([new_origin[0][0], new_y[0][0]], [new_origin[1][0], new_y[1][0]], '-g', linewidth=ax_lw)


#         ax.annotate('{'+str(k+1)+'}', xy=new_origin[0:2][0], xytext=new_origin[0:2][0])

        # lastly update the current_origin to the new_origin
        prev_origin = new_origin

    # lastly set the axes to be equal and appropriate
    ax.set_aspect('equal')
    ax.set_xlabel('x')
    ax.set_ylabel('y')    