function d = calculate_shaft_diameter(Tm, Ta, Mm, Ma, AISI, surface_finish, reliability, n, D_d_ratio)
    % Default values
    if nargin < 7
        reliability = 0.999;
    end
    if nargin < 8
        n = 2;
    end
    if nargin < 9
        D_d_ratio = 1.2;
    end

    % Check if D_d_ratio is valid
    if D_d_ratio < 1.02 || D_d_ratio > 2.0
        error('Invalid D/d ratio. Please use a value between 1.02 and 2.0');
    end

    % Tabulated values for Kt and Kts (from Figures C-2 and C-3)
    d_d_table = [
        1.02, 1.43, 1.25;
        1.05, 1.64, 1.36;
        1.10, 1.88, 1.50;
        1.20, 2.16, 1.67;
        1.30, 2.35, 1.78;
        1.50, 2.58, 1.93;
        2.00, 2.95, 2.15
    ];

    % Assign material properties based on AISI number and surface finish
% Assign material properties based on AISI number and surface finish
if AISI == 1
    Sut = 82000; % psi
    Sy = 58000; % psi
elseif AISI == 1006
    if strcmp(surface_finish, 'hot-rolled')
        Sut = 43000; % psi
        Sy = 24000; % psi
    elseif strcmp(surface_finish, 'cold-drawn')
        Sut = 48000; % psi
        Sy = 41000; % psi
    else
        error('Invalid surface finish for AISI 1006. Use "hot-rolled" or "cold-drawn".');
    end
elseif AISI == 1010
    if strcmp(surface_finish, 'hot-rolled')
        Sut = 47000; % psi
        Sy = 26000; % psi
    elseif strcmp(surface_finish, 'cold-drawn')
        Sut = 53000; % psi
        Sy = 44000; % psi
    else
        error('Invalid surface finish for AISI 1010. Use "hot-rolled" or "cold-drawn".');
    end
elseif AISI == 1015
    if strcmp(surface_finish, 'hot-rolled')
        Sut = 50000; % psi
        Sy = 27500; % psi
    elseif strcmp(surface_finish, 'cold-drawn')
        Sut = 56000; % psi
        Sy = 47000; % psi
    else
        error('Invalid surface finish for AISI 1015. Use "hot-rolled" or "cold-drawn".');
    end
elseif AISI == 1018
    if strcmp(surface_finish, 'hot-rolled')
        Sut = 58000; % psi
        Sy = 32000; % psi
    elseif strcmp(surface_finish, 'cold-drawn')
        Sut = 64000; % psi
        Sy = 54000; % psi
    else
        error('Invalid surface finish for AISI 1018. Use "hot-rolled" or "cold-drawn".');
    end
elseif AISI == 1020
    if strcmp(surface_finish, 'hot-rolled')
        Sut = 55000; % psi
        Sy = 30000; % psi
    elseif strcmp(surface_finish, 'cold-drawn')
        Sut = 68000; % psi
        Sy = 57000; % psi
    else
        error('Invalid surface finish for AISI 1020. Use "hot-rolled" or "cold-drawn".');
    end
elseif AISI == 1030
    if strcmp(surface_finish, 'hot-rolled')
        Sut = 68000; % psi
        Sy = 37500; % psi
    elseif strcmp(surface_finish, 'cold-drawn')
        Sut = 76000; % psi
        Sy = 64000; % psi
    else
        error('Invalid surface finish for AISI 1030. Use "hot-rolled" or "cold-drawn".');
    end
elseif AISI == 1035
    if strcmp(surface_finish, 'hot-rolled')
        Sut = 72000; % psi
        Sy = 39500; % psi
    elseif strcmp(surface_finish, 'cold-drawn')
        Sut = 80000; % psi
        Sy = 67000; % psi
    else
        error('Invalid surface finish for AISI 1035. Use "hot-rolled" or "cold-drawn".');
    end
elseif AISI == 1040
    if strcmp(surface_finish, 'hot-rolled')
        Sut = 76000; % psi
        Sy = 42000; % psi
    elseif strcmp(surface_finish, 'cold-drawn')
        Sut = 85000; % psi
        Sy = 71000; % psi
    else
        error('Invalid surface finish for AISI 1040. Use "hot-rolled" or "cold-drawn".');
    end
elseif AISI == 1045
    if strcmp(surface_finish, 'hot-rolled')
        Sut = 82000; % psi
        Sy = 45000; % psi
    elseif strcmp(surface_finish, 'cold-drawn')
        Sut = 91000; % psi
        Sy = 77000; % psi
    else
        error('Invalid surface finish for AISI 1045. Use "hot-rolled" or "cold-drawn".');
    end
elseif AISI == 1050
    if strcmp(surface_finish, 'hot-rolled')
        Sut = 90000; % psi
        Sy = 49500; % psi
    elseif strcmp(surface_finish, 'cold-drawn')
        Sut = 100000; % psi
        Sy = 84000; % psi
    else
        error('Invalid surface finish for AISI 1050. Use "hot-rolled" or "cold-drawn".');
    end
elseif AISI == 1060
    if strcmp(surface_finish, 'hot-rolled')
        Sut = 98000; % psi
        Sy = 54000; % psi
    else
        error('AISI 1060 is only available in hot-rolled condition.');
    end
elseif AISI == 1080
    if strcmp(surface_finish, 'hot-rolled')
        Sut = 112000; % psi
        Sy = 61500; % psi
    else
        error('AISI 1080 is only available in hot-rolled condition.');
    end
elseif AISI == 1095
    if strcmp(surface_finish, 'hot-rolled')
        Sut = 120000; % psi
        Sy = 66000; % psi
    else
        error('AISI 1095 is only available in hot-rolled condition.');
    end
else
    error('Unsupported AISI number. Please use one of the implemented AISI grades (1006-1095).');
end

    % Calculate Se'
    Se_prime = 0.5 * Sut;

    % Calculate modification factors
    ka = surface_factor(surface_finish, Sut);
    kc = 1; % Assume load factor is 1 for bending and torsion
    kd = 1; % Assume temperature factor is 1 for room temperature
    ke = reliability_factor(reliability);
    kf = 1; % Assume miscellaneous factor is 1

    % Initialize variables for iteration
    d_prev = 1; % Initial guess
    kb = 1; % Initial size factor
    tolerance = 0.01; % 1% tolerance
    
    % Calculate r/d ratio
    r_d_ratio = (D_d_ratio - 1) / 2;

    % Initialize table for iteration data
    iteration_table = table('Size', [0, 4], 'VariableTypes', {'double', 'double', 'double', 'double'}, ...
                            'VariableNames', {'Iteration', 'Diameter', 'kb', 'Se'});

    iteration = 0;
    while true
        iteration = iteration + 1;
        
        % Calculate fillet radius based on current diameter estimate
        r = r_d_ratio * d_prev;
        
        if iteration == 1
            % For the first iteration, calculate Kt and Kts
            [Kt, Kts] = calculate_k_factors(D_d_ratio, r_d_ratio);
            % Set Kf and Kfs equal to Kt and Kts for the first iteration
            Kf = Kt;
            Kfs = Kts;
        else
            % For subsequent iterations, calculate Kt and Kts
            [Kt, Kts] = calculate_k_factors(D_d_ratio, r_d_ratio);
            % Calculate Kf and Kfs based on notch sensitivity
            q = notch_sensitivity(Sut, r);
            qs = torsional_notch_sensitivity(Sut, r);
            Kf = 1 + q * (Kt - 1);
            Kfs = 1 + qs * (Kts - 1);
        end

        % Calculate Se
        Se = ka * kb * kc * kd * ke * kf * Se_prime;

        % Calculate new diameter using DE-Gerber criteria
        A = sqrt(4*(Kf*Ma)^2 + 3*(Kfs*Ta)^2);
        B = sqrt(4*(Kf*Mm)^2 + 3*(Kfs*Tm)^2);
        d_new = ((8*n*A/(pi*Se))*(1+(1+(2*B*Se/(A*Sut))^2)^(1/2)))^(1/3);

        % Add data to iteration table
        iteration_table = [iteration_table; {iteration, d_new, kb, Se}];

        % Check for convergence
        if abs(d_new - d_prev) / d_prev <= tolerance
            break;
        end

        % Update diameter and size factor
        d_prev = d_new;
        kb = size_factor(d_new);
    end

    d = d_new;

    % Display the iteration table
    disp(iteration_table);

    % Calculate yield factor of safety
    sigma_a_prime = sqrt((32*Kf*Ma/(pi*d^3))^2 + 3*(16*Kfs*Ta/(pi*d^3))^2);
    sigma_m_prime = sqrt((32*Kf*Mm/(pi*d^3))^2 + 3*(16*Kfs*Tm/(pi*d^3))^2);
    sigma_max_prime = sigma_a_prime + sigma_m_prime;
    n_y = Sy/sigma_max_prime;

    % Display the yield factor of safety
    fprintf('\nYield factor of safety: %.3f\n', n_y);
end

function [Kt, Kts] = calculate_k_factors(D_d_ratio, r_d_ratio)
    % Tables for bending (Kt)
    Dd_bend = [2.00, 1.50, 1.20, 1.10, 1.07, 1.05, 1.03, 1.02, 1.01];
    A_bend = [0.90879, 0.93836, 0.97098, 0.95120, 0.97527, 0.98137, 0.98061, 0.96048, 0.91938];
    b_bend = [-0.28598, -0.25759, -0.21796, -0.23757, -0.20958, -0.19653, -0.18381, -0.17711, -0.17032];

    % Tables for torsion (Kts)
    Dd_tors = [2.00, 1.33, 1.20, 1.09];
    A_tors = [0.86331, 0.84897, 0.83425, 0.90337];
    b_tors = [-0.23865, -0.23161, -0.21649, -0.12692];

    % Check if D/d ratio is within bounds
    if D_d_ratio < 1.01 || D_d_ratio > 2.0
        error('D/d ratio must be between 1.01 and 2.0');
    end

    % For bending (Kt)
    if ismember(D_d_ratio, Dd_bend)
        % Use exact values if D/d ratio matches a table value
        idx = find(Dd_bend == D_d_ratio);
        A_kt = A_bend(idx);
        b_kt = b_bend(idx);
    else
        % Interpolate if D/d ratio is between table values
        A_kt = interp1(Dd_bend, A_bend, D_d_ratio, 'linear');
        b_kt = interp1(Dd_bend, b_bend, D_d_ratio, 'linear');
    end
    
    % Calculate Kt
    Kt = A_kt * (r_d_ratio)^b_kt;

    % For torsion (Kts)
    if ismember(D_d_ratio, Dd_tors)
        % Use exact values if D/d ratio matches a table value
        idx = find(Dd_tors == D_d_ratio);
        A_kts = A_tors(idx);
        b_kts = b_tors(idx);
    else
        % Interpolate if D/d ratio is between table values
        A_kts = interp1(Dd_tors, A_tors, D_d_ratio, 'linear');
        b_kts = interp1(Dd_tors, b_tors, D_d_ratio, 'linear');
    end
    
    % Calculate Kts
    Kts = A_kts * (r_d_ratio)^b_kts;
end

function ka = surface_factor(surface_finish, Sut)
    % Sut is in psi, convert to ksi for the calculation
    Sut_ksi = Sut / 1000;
    
    if strcmp(surface_finish, 'hot-rolled')
        ka = 14.4 * Sut_ksi^(-0.718);
    elseif strcmp(surface_finish, 'cold-drawn')
        ka = 2.70 * Sut_ksi^(-0.265);
    else
        error('Invalid surface finish');
    end
end

function ke = reliability_factor(reliability)
    if reliability == 0.999
        ke = 0.753;
    elseif reliability == 0.99
        ke = 0.814;
    elseif reliability == 0.9
        ke = 0.897;
    else
        error('Unsupported reliability value');
    end
end

function kb = size_factor(d)
    if d < 0.3
        kb = 1;
    elseif d <= 2
        kb = 0.879 * d^(-0.107);
    else
        kb = 0.91 * d^(-0.157);
    end
end

function q = notch_sensitivity(Sut, r)
    % Calculate notch sensitivity based on Sut and fillet radius r
    % Sut is in psi, convert to ksi for the calculation
    Sut_ksi = Sut / 1000;
    sqrt_a = 0.246 - 3.08e-3 * Sut_ksi + 1.51e-5 * Sut_ksi^2 - 2.67e-8 * Sut_ksi^3;
    q = 1 / (1 + sqrt_a / sqrt(r));
end

function qs = torsional_notch_sensitivity(Sut, r)
    % Calculate torsional notch sensitivity based on Sut and fillet radius r
    % Sut is in psi, convert to ksi for the calculation
    Sut_ksi = Sut / 1000;
    sqrt_a = 0.190 - 2.51e-3 * Sut_ksi + 1.35e-5 * Sut_ksi^2 - 2.67e-8 * Sut_ksi^3;
    qs = 1 / (1 + sqrt_a / sqrt(r));
end