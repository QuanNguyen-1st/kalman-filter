function angle = EP2Euler321(beta)

beta = beta(:) / norm(beta);

b0 = beta(1);
b1 = beta(2);
b2 = beta(3);
b3 = beta(4);

roll = atan2(2*(b0*b1 + b2*b3), 1 - 2*(b1^2 + b2^2));

sinPitch = 2*(b0*b2 - b3*b1);
pitch = asin(max(-1, min(1, sinPitch)));

yaw = atan2(2*(b0*b3 + b1*b2), 1 - 2*(b2^2 + b3^2));

angle = [roll pitch yaw];
end