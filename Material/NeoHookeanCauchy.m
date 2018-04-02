  function Cauchy = NeoHookeanCauchy (mu,lambda,Ftensor)
    % Calcula o segundo tensor de piola-kirchhoff S para o modelo NeoHookean de
    % Material

    % Funcao potencial
%    Psi = mu/2 * (Ic -3) - mu* log(J)+ lambda/2 * log(J)^2 ;

    b = btensor(Ftensor);
    J = det(Ftensor);
    I = eye(3);
    
    Cauchy = mu/J * (b - I) + lambda/J * log(J) * I ;
  end
