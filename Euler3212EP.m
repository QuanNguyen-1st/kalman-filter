function beta = Euler3212EP(angle)

    roll = angle(1);
    pitch = angle(2);
    yaw = angle(3);

    cr = cos(roll / 2);
    sr = sin(roll / 2);
    cp = cos(pitch / 2);
    sp = sin(pitch / 2);
    cy = cos(yaw / 2);
    sy = sin(yaw / 2);

    beta(1) = cr * cp * cy + sr * sp * sy;
    beta(2) = sr * cp * cy - cr * sp * sy;
    beta(3) = cr * sp * cy + sr * cp * sy;
    beta(4) = cr * cp * sy - sr * sp * cy;

end
