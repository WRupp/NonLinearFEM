function [B] = B_Hex8 (e1,e2,e3,PosicoesNodais)
	
	
	% Calculo do Jacobiano

	J = J_Hex8(e1,e2,e3,PosicoesNodais);

	% Derivadas em termos de e1 e e2

	Psi = Derivadas_Hex8(e1,e2,e3);

	% Derivadas em termos de x e y

	Deriv = J \ Psi;

	% Montagem da matriz B
    
    B = [Deriv(1,1) 0 0 Deriv(1,2) 0 0 Deriv(1,3) 0 0 Deriv(1,4) 0 0 ...
         Deriv(1,5) 0 0 Deriv(1,6) 0 0 Deriv(1,7) 0 0 Deriv(1,8) 0 0 ;
         0 Deriv(2,1) 0 0 Deriv(2,2) 0 0 Deriv(2,3) 0 0 Deriv(2,4) 0 ...
         0 Deriv(2,5) 0 0 Deriv(2,6) 0 0 Deriv(2,7) 0 0 Deriv(2,8) 0 ;
         0 0 Deriv(3,1) 0 0 Deriv(3,2) 0 0 Deriv(3,3) 0 0 Deriv(3,4) ...
         0 0 Deriv(3,5) 0 0 Deriv(3,6) 0 0 Deriv(3,7) 0 0 Deriv(3,8);
         Deriv(2,1) Deriv(1,1) 0 Deriv(2,2) Deriv(1,2) 0 ...
         Deriv(2,3) Deriv(1,3) 0 Deriv(2,4) Deriv(1,4) 0 ...
         Deriv(2,5) Deriv(1,5) 0 Deriv(2,6) Deriv(1,6) 0 ...
         Deriv(2,7) Deriv(1,7) 0 Deriv(2,8) Deriv(1,8) 0 ;
         0 Deriv(3,1) Deriv(2,1) 0 Deriv(3,2) Deriv(2,2) ...
         0 Deriv(3,3) Deriv(2,3) 0 Deriv(3,4) Deriv(2,4) ...
         0 Deriv(3,5) Deriv(2,5) 0 Deriv(3,6) Deriv(2,6) ...
         0 Deriv(3,7) Deriv(2,7) 0 Deriv(3,8) Deriv(2,8) ;
         Deriv(3,1) 0 Deriv(1,1) Deriv(3,2) 0 Deriv(1,2) ...
         Deriv(3,3) 0 Deriv(1,3) Deriv(3,4) 0 Deriv(1,4) ...
         Deriv(3,5) 0 Deriv(1,5) Deriv(3,6) 0 Deriv(1,6) ...
         Deriv(3,7) 0 Deriv(1,7) Deriv(3,8) 0 Deriv(1,8) ];
         
       


end