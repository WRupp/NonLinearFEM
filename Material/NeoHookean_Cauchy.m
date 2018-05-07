  function Cauchy = NeoHookean_Cauchy (mu,lambda,Ftensor)
    % Calcula o segundo tensor de piola-kirchhoff S para o modelo NeoHookean de
    % Material

    % Funcao potencial
%    Psi = mu/2 * (Ic -3) - mu* log(J)+ lambda/2 * log(J)^2 ;

    b = btensor(Ftensor);
    Jvol = det(Ftensor);
    I = eye(3);

    Cauchy = mu/Jvol * (b - I) + lambda/Jvol * log(Jvol) * I ;
  end
