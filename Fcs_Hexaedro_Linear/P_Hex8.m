function P = P_Hex8(e1,e2,e3,PosicoesNodais,C)
	% Calcula o polinomio a ser integrado para o elemento solido Hexaedro linear.

	B = B_Hex8(e1,e2,e3,PosicoesNodais);

	J = J_Hex8(e1,e2,e3,PosicoesNodais);	

	P =  transpose(B) * C * B * det(J);

end