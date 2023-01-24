% compute_pll.m
% input parameters
% - gamma -> value of gamma to be used in the pll
% - x     -> input signal
% output parameters
% - phi_pll -> computed pll phase
% - pll     -> output of pll exp(-j phi_pll)
% - x_pll   -> signal after pll
% - e_pll   -> error signal (imaginary part of x_pll)

function [phi_pll, pll, x_pll, e_pll] = compute_pll(gamma, x)

% pll phase
phi_pll = zeros(length(x), 1);
phi_pll(1) = 0;

% pll output
pll = zeros(length(x), 1);
pll(1) = exp(-1j * phi_pll(1));

% resulting signal after pll
x_pll = zeros(length(x), 1);
x_pll(1) = x(1) * pll(1);

% empty vector for the pll error signal
e_pll = zeros(length(x), 1);
e_pll(1) = imag(x_pll(1));

for n=2 : 1 : length(x)
    phi_pll(n) = phi_pll(n-1) + gamma * e_pll(n-1);
    phi_pll(n) = mod(phi_pll(n), 2*pi);

    pll(n) = exp(-1j * phi_pll(n));

    x_pll(n) = x(n) * pll(n);
    
    e_pll(n) = imag(x_pll(n));
end

end
