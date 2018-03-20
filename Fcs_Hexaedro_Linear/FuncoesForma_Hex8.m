function  Phi = FuncoesForma_Hex8(e1,e2,e3)

% Calcula os valores das funcoes de forma para o ponto (e1,e2)

Phi(1) = 1/8 *  (1-e1) * (1-e2) * (1+e3);
Phi(2) = 1/8 *  (1-e1) * (1-e2) * (1-e3);
Phi(3) = 1/8 *  (1-e1) * (1+e2) * (1-e3);
Phi(4) = 1/8 *  (1-e1) * (1+e2) * (1+e3);

Phi(5) = 1/8 *  (1+e1) * (1-e2) * (1+e3);
Phi(6) = 1/8 *  (1+e1) * (1-e2) * (1-e3);
Phi(7) = 1/8 *  (1+e1) * (1+e2) * (1-e3);
Phi(8) = 1/8 *  (1+e1) * (1+e2) * (1+e3);
end