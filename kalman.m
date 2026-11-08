clear all

Nsamples = 41500; % Number of data points
dt = 0.01; % seconds of time-step

EulerSaved = zeros(Nsamples, 3);

load ArsGyro
w = [wx(:) wy(:) wz(:)];

load ArsAccel
a = [fx(:) fy(:) fz(:)];

A = eye(4); % initial A, will change in loop
H = eye(4);
Q = 0.0001 * eye(4);
R = 10 * eye(4);
P0 = 1 * eye(4);
x0 = [1 0 0 0]';

filter = MakeKalmanFilter(A, H, Q, R, x0, P0);

angle = [0 0 0];

for k = 1:Nsamples
    w1 = w(k, 1);
    w2 = w(k, 2);
    w3 = w(k, 3);
    Omega = [0 -w1 -w2 -w3;
             w1 0 w3 -w2;
             w2 -w3 0 w1;
             w3 w2 -w1 0];
    A = eye(4) + (dt / 2) * Omega;

    f1 = a(k, 1);
    f2 = a(k, 2);
    [angle(1) angle(2)] = EulerAccel(f1, f2);

    z = Euler3212EP(angle);

    x_est = filter(z(:), A);

    angle = EP2Euler321(x_est);

    EulerSaved(k, :) = angle;
end

PhiSaved = EulerSaved(:, 1) * 180 / pi;
ThetaSaved = EulerSaved(:, 2) * 180 / pi;
PsiSaved = EulerSaved(:, 3) * 180 / pi;

t = 0:dt:Nsamples * dt - dt;

figure

subplot(1, 3, 1)
plot(t, PhiSaved)
title('Roll')
xlabel('time (s)'); ylabel('Roll, \phi (degrees)')
grid on
ylim(40 * [-1 1]); 
xlim([0 420]);
axis square
set(gca, 'fontsize', 15)

subplot(1, 3, 2)
plot(t, ThetaSaved)
title('Pitch')
xlabel('time (s)'); ylabel('Pitch, \theta (degrees)')
grid on
ylim(40 * [-1 1]); 
xlim([0 420]);
axis square
set(gca, 'fontsize', 15)

subplot(1, 3, 3)
plot(t, PsiSaved, 'k', 'linewidth', 1);
title('Yaw')
xlabel('time (s)'); ylabel('Yaw, \psi (degrees)')
grid on
xlim([0 420]);
axis square
set(gca, 'fontsize', 15)

set(gcf, 'Position', [10, 100, 1500, 600])