function Sigma = PK2toCauchy (S,F)
  % Converte o segundo tensor de Piola Kirchoff para Cauchy

  J = det(F);

  Sigma = (1/J) * F * S * transpose(F);

end
