function angle_rates = Euler321_KDE(omega, angle)

    roll = angle(1);
    pitch = angle(2);

    cr = cos(roll);
    sr = sin(roll);
    cp = cos(pitch);
    sp = sin(pitch);

    w1 = omega(1);
    w2 = omega(2);
    w3 = omega(3);

    angle_rates = [
        w1 * cp + w2 * sr * sp + w3 * cr * sp
        w2 * cr * cp - w3 * sr * cp
        w2 * sr + w3 * cr
    ] / cp;

end