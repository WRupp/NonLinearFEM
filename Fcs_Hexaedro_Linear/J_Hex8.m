function [J] = J_Hex8(e1,e2,e3,PosicoesNodais)
	% Calcula a matriz e o determinante da matriz jacobiana nos pontos
	% e1 e e2 ( ou \epsilon e \eta)
	% X é o vetor coluna de coordenadas nodais x
	% Y é o vetor coluna de coordenadas nodais y
    % Definicao da Jacobiana

	%J(:,1) = Psi*X; 
    
	%Derivadas das funcoes de forma
	Psi = Derivadas_Hex8(e1,e2,e3);
    
    % Jacobiana
	J = Psi*PosicoesNodais;
    
end