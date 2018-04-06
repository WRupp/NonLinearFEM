function Ke = int_HEX8 (PosicoesNodais,C)
	% Realiza a integracao numerica do elemento e entrega a matriz de Rigidez elementar
	% para o modelo Quadrilatero Quadratico Q9

     np  = 8;
    % Posicao dos pontos
     Ponto =  1/sqrt(3);

     e =[+Ponto +Ponto +Ponto;
         +Ponto +Ponto -Ponto;
         +Ponto -Ponto +Ponto;
         +Ponto -Ponto -Ponto;
         -Ponto +Ponto +Ponto;
         -Ponto +Ponto -Ponto;
         -Ponto -Ponto +Ponto;
         -Ponto -Ponto -Ponto];
     
     % Peso
     W(1:np) = 1;
 
    % Calculo de Ke
    Ke = zeros (8*3);           % 8 nós - 3 dimensoes

    % Loop nos pontos de Gauss
for j = 1 : np
    
    % Pega o ponto de Gauss
    	e1 = e(j,1);
    	e2 = e(j,2);
        e3 = e(j,3);

    % Polinomio a ser integrado.
    P = P_Hex8(e1,e2,e3,PosicoesNodais,C);	
                                   
 	Ke = Ke + P * W(j); 
    
end
end