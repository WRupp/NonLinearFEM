function G = G_Hex8 (e1,e2,e3,PosicoesNodais)
    % Cakcula a matriz de derivadas para a parte material

    % Calculo do Jacobiano

	J = J_Hex8(e1,e2,e3,PosicoesNodais);

	% Derivadas em termos de e1 e e2

	Psi = Derivadas_Hex8(e1,e2,e3);

	% Derivadas em termos de x e y

	Deriv = J \ Psi;

   S = size(Deriv);
   Dim = S(1);
   NfuncoesInterpolacao = S(2);
   G = zeros(Dim,Dim*NfuncoesInterpolacao); 


  for j = 1 : size(Deriv,2)

    Gzinho = [Deriv(1,j) 0        0             ;
              0        Deriv(2,j) 0             ;
              0        0             Deriv(3,j) ];


    G(1:Dim, 1+(j-1)*Dim : j*Dim ) = Gzinho;

  end
end
