function [Kt] = NeoHookean_Kt(PontoGauss,W,PosicoesNodaisMat,PosicoesNodaisEsp,mu,lambda)

  % Calcula a matriz tangente para o modelo material NeoHooke

      Kt_M = zeros(24,24);
      Kt_G = zeros(24,24);
     
    for i = 1 : 8

        % % Parte Material

        % Jacobiano
        JX = J_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisMat(:,2:end)); % % Parte Material
        
        Jx = J_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisEsp(:,2:end)); % % Parte Espacial

        % Derivadas das funcoes de forma em X material

        delNdelX = JX \ Derivadas_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3));
%         delNdelx = transpose(Jx) \ Derivadas_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3));

        % Tensor gradiente de mapeamento

        F = Ftensor2(PosicoesNodaisMat(:,2:end),PosicoesNodaisEsp(:,2:end),delNdelX);         

        % Matrizes

        B = B_Hex8 (PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisEsp(:,2:end));
        
        G = G_Hex8 (PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisEsp(:,2:end));
        
        % Questoes do material

            % Matriz Elasticidade
            Cnh = NeoHookean (mu,lambda,F);
            % Calcula Cauchy
            Cauchy = NeoHookeanCauchy (mu,lambda,F);
            
       % Integracao numerica 
       
       PolinomioM = B' * Cnh * B  * det(Jx); 
        
       PolinomioG = G' * Cauchy * G * det(Jx);

        

        %  Mapeamento da Qualificacao do Thiago - pg 83 
%         [G,B,CauchyMat] = Map_Thiago (PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisEsp(:,2:end),Cauchy);        

%        Polinomio1 = B' * Cnh * B  * det(Jx); 
%        PolinomioG = G' * CauchyMat * G  * det(Jx);       



       Kt_M = Kt_M + PolinomioM  * W(i);

       Kt_G = Kt_G + PolinomioG * W(i);

    end
    
        % Matriz tangente    
         Kt = Kt_M + Kt_G;

end
