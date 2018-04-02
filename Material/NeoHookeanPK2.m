  function S = NeoHookeanPK2 (mu,lambda,Ftensor)
    % Calcula o segundo tensor de piola-kirchhoff S para o modelo NeoHookean de
    % Material

    % Funcao potencial
%    Psi = mu/2 * (Ic -3) - mu* log(J)+ lambda/2 * log(J)^2 ;

    C = Ctensor(Ftensor);
    invC = inv(C);
    J = det(Ftensor);

    S = mu * (eye(3) - invC) + lambda* log(J) * invC ;

  end
