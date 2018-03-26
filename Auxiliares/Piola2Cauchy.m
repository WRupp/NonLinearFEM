function sigma = Piola2Cauchy(P,F)
  % Transforma o PK1 P no tensor tensões de Piola2Cauchy
  
  J = det(F);
  sigma = (1/J) * P * transpose(F);

end
