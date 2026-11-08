function [roll pitch] = EulerAccel(ax, ay)
    % assuming acceleration = 0 ({}^{N}(dv/dt))
    % [f]_B = -[g]_B = -n3 * g
    % n3 = [-s(pitch); c(pitch)*sin(roll); c(pitch)*c(roll)]
    %
    g = 9.81;

    pitch = asin(ax / g);
    roll = asin(-ay / (g * cos(pitch)));

end
