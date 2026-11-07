function filter = MakeKalmanFilter(A, H, Q, R, x0, P0)
    %MAKEKALMANFILTER Create an independent Kalman filter.
    % Inputs:
    %   A : State transition matrix             (n x n)
    %   H : Measurement matrix                  (m x n)
    %   Q : Process noise covariance            (n x n)
    %   R : Measurement noise covariance        (m x m)
    %   x0: Initial state estimation            (n x 1)
    %   P0: Initial estimation error covariance (n x n)
    %
    % Create:
    %   kf = MakeKalmanFilter(A, H, Q, R, x0, P0);
    %
    % Run:
    %   [x, P] = kf(z);
    %   [x, P] = kf(z, A_new, H_new, Q_new, R_new);
    %
    % Omit optional arguments or pass [] to keep stored matrices.

    x = x0;
    P = P0;

    filter = @step;

    function [x_est, P_new] = step(z, A_new, H_new, Q_new, R_new)
        % Inputs:
        %   z : Current measurement (m x 1)
        %
        % Outputs:
        %   x_est : Updated state estimate              (n x 1)
        %   P_new : Updated estimation error covariance (n x n)

        % Update only the matrices supplied by the caller.
        if nargin >= 2 && ~isempty(A_new)
            A = A_new;
        end

        if nargin >= 3 && ~isempty(H_new)
            H = H_new;
        end

        if nargin >= 4 && ~isempty(Q_new)
            Q = Q_new;
        end

        if nargin >= 5 && ~isempty(R_new)
            R = R_new;
        end

        % Prediction step
        x_pred = A * x;
        P_pred = A * P * A' + Q;

        % Estimation step
        S = H * P_pred * H' + R;
        K = (P_pred * H') / S;

        x_est = x_pred + K * (z - H * x_pred);
        P_new = P_pred - K * H * P_pred;

        % Store the results for the next call.
        x = x_est;
        P = P_new;
    end

end
