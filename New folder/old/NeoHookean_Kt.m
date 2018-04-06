function [Kt] = NeoHookean_Kt(PontoGauss,W,PosicoesNodaisMat,PosicoesNodaisEsp,mu,lambda)

  % Calcula a matriz tangente para o modelo material NeoHooke

      Kt_M = zeros(24,24);
      Kt_G = zeros(24,24);

    for i = 1 : 8


      % Calculo do gradiente de mapeamento
      JacobMat = J_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisMat(:,2:end)); % % Parte Material
      delNdelX = transpose(JacobMat) \ Derivadas_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3));  % J^{-T} delNdelE
      F = Ftensor(PosicoesNodaisMat(:,2:end),PosicoesNodaisEsp(:,2:end),delNdelX);

      % Calcula Cauchy - Modelo NeoHooke compressivel
      Cauchy = NeoHookean_Cauchy (mu,lambda,F);
      % Matriz Elasticidade
      Cnh = NeoHookean_TangentMatrix (mu,lambda,F);



      % Jacobiano da parte Espacial - Natural -> Espacial
      JacobEsp = J_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisEsp(:,2:end)); % % Parte Espacial


        % Matrizes

        B = B_Hex8 (PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisEsp(:,2:end));

        G = G_Hex8 (PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisEsp(:,2:end));


       % Integracao numerica

       PolinomioM = B' * Cnh * B  * det(JacobEsp);

       PolinomioG = G' * Cauchy * G * det(JacobEsp);


       Kt_M = Kt_M + PolinomioM  * W(i);

       Kt_G = Kt_G + PolinomioG * W(i);

    end

        % Matriz tangente
         Kt = Kt_M + Kt_G;

end
