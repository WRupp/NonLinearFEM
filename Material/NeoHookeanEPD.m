function cauchy = NeoHookeanEPD(F,mu,lambda)
    % Calculates de cauchy stress tensor for a plane strain case

    J = det(F);
    b = btensor(F);
    I = eye(3);
    
    cauchy = mu/J * (b-I) + lambda /J * log(J) * I;

end