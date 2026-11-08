clear all

Nsamples = 41500; % Number of data points
dt = 0.01; % seconds of time-step

EulerSaved = zeros(Nsamples, 3);

load ArsGyro
w = [wx(:) wy(:) wz(:)];

angle = [ 0 0 0 ];

for k = 1:Nsamples
    omega = w(k, :).';

    [~, angles] = ode45(@(~, a) Euler321_KDE(omega, a), ...
        [0, dt], angle);

    angle = angles(end, :).';
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