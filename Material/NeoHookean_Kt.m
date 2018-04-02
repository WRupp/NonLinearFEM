function [Kt] = NeoHookean_Kt(PontoGauss,W,PosicoesNodaisMat,PosicoesNodaisEsp,mu,lambda)

  % Calcula a matriz tangente para o modelo material NeoHooke

      Kt_M = 0;
      Kt_G = 0;
    
    for i = 1 : 8

        % % Parte Material

        % Jacobiano

        JX = J_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisMat(:,2:end));

        % Derivadas das funcoes de forma em X material

        delNdelX = JX' \ Derivadas_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3));

        % Tensor gradiente de mapeamento

        F = Ftensor(PosicoesNodaisMat(:,2:end),PosicoesNodaisEsp(:,2:end),delNdelX);

        % % Parte Espacial  

        Jx = J_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisEsp(:,2:end));

        % Matriz de Derivadas

        B = B_Hex8 (PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisEsp(:,2:end));

        G = G_Hex8 (PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisEsp(:,2:end));

        %  material

            % Matriz tangente
            Cnh = NeoHookean (mu,lambda,F);
            % Converte pra Cauchy
            Cauchy = NeoHookeanCauchy (mu,lambda,F);

        % Polinomio a ser integrado - Parte Material
        Polinomio1 = B' * Cnh * B  * det(Jx);

        %  Polinomio a ser integrado - Parte Geometrica (tensao inicial)

        Polinomio2 = G' * Cauchy * G  * det(Jx);

        % Integracao numerica - Matriz Tangente
        Kt_M = Kt_M + Polinomio1  * W(i);

        Kt_G = Kt_G + Polinomio2 * W(i);

        Kt = Kt_M + Kt_G;

    end

end
