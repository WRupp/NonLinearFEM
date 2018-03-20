function Ftensor(e1,e2,e3,PosicoesNodaisMat,PosicoesNodaisEsp)
    % Calculates de deformation gradient F
    
    
    J = J_Hex8(e1,e2,e3,PosicoesNodaisMat);
    delNdelX = inv(J)' * Derivadas_Hex8(e1,e2,e3);
    
    F = zeros(3);
    
    for i= 1 : Nnos
        for j = 1 : 3
        F(i,j) = F(i,j) + PosicoesNodaisEsp(i) * delNdelX(i,j)  ;
        end        
    end
end