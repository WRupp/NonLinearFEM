function G = G_Hex8 (e1,e2,e3,PosicoesNodais)
    % Cakcula a matriz de derivadas para a parte material

    % Calculo do Jacobiano

	J = J_Hex8(e1,e2,e3,PosicoesNodais);

	% Derivadas em termos de e1 e e2

	Psi = Derivadas_Hex8(e1,e2,e3);

	% Derivadas em termos de x e y

	Deriv = J \ Psi;

   G = [ Deriv(1,1) 0 0 Deriv(1,2) 0 0 Deriv(1,3) 0 0 Deriv(1,4) 0 0 ...
         Deriv(1,5) 0 0 Deriv(1,6) 0 0 Deriv(1,7) 0 0 Deriv(1,8) 0 0 ;
         Deriv(2,1) 0 0 Deriv(2,2) 0 0 Deriv(2,3) 0 0 Deriv(2,4) 0 0 ...
         Deriv(2,5) 0 0 Deriv(2,6) 0 0 Deriv(2,7) 0 0 Deriv(2,8) 0 0 ;
         Deriv(3,1) 0 0 Deriv(3,2) 0 0 Deriv(3,3) 0 0 Deriv(3,4) 0 0 ...
         Deriv(3,5) 0 0 Deriv(3,6) 0 0 Deriv(3,7) 0 0 Deriv(3,8) 0 0 ;
         0 Deriv(1,1) 0 0 Deriv(1,2) 0 0 Deriv(1,3) 0 0 Deriv(1,4) 0 ...
         0 Deriv(1,5) 0 0 Deriv(1,6) 0 0 Deriv(1,7) 0 0 Deriv(1,8) 0 ;
         0 Deriv(2,1) 0 0 Deriv(2,2) 0 0 Deriv(2,3) 0 0 Deriv(2,4) 0 ...
         0 Deriv(2,5) 0 0 Deriv(2,6) 0 0 Deriv(2,7) 0 0 Deriv(2,8) 0 ;
         0 Deriv(3,1) 0 0 Deriv(3,2) 0 0 Deriv(3,3) 0 0 Deriv(3,4) 0 ...
         0 Deriv(3,5) 0 0 Deriv(3,6) 0 0 Deriv(3,7) 0 0 Deriv(3,8) 0 ;
         0 0 Deriv(1,1) 0 0 Deriv(1,2) 0 0 Deriv(1,3) 0 0 Deriv(1,4) ...
         0 0 Deriv(1,5) 0 0 Deriv(1,6) 0 0 Deriv(1,7) 0 0 Deriv(1,8) ;
         0 0 Deriv(2,1) 0 0 Deriv(2,2) 0 0 Deriv(2,3) 0 0 Deriv(2,4) ...
         0 0 Deriv(2,5) 0 0 Deriv(2,6) 0 0 Deriv(2,7) 0 0 Deriv(2,8) ;
         0 0 Deriv(3,1) 0 0 Deriv(3,2) 0 0 Deriv(3,3) 0 0 Deriv(3,4) ...
         0 0 Deriv(3,5) 0 0 Deriv(3,6) 0 0 Deriv(3,7) 0 0 Deriv(3,8) ;];

end
