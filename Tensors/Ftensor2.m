function F = Ftensor2(PosicoesNodaisMat,PosicoesNodaisEsp,delNdelX)
    % Calculates de deformation gradient F using the derivatives of the
    % shape functions in material Coordinates

        Um = PosicoesNodaisEsp - PosicoesNodaisMat;
        GradU = transpose(delNdelX * Um);
        F = GradU + eye(3);

end
