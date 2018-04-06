function F = Ftensor(PosicoesNodaisMat,PosicoesNodaisEsp,delNdelX)
    % Calculates de deformation gradient F
    % delNdelX - Derivatives of shape functions in terms of material coordinates

  Um = PosicoesNodaisEsp - PosicoesNodaisMat;
  GradU = (delNdelX * Um)';
  F = GradU + eye(3);

end
