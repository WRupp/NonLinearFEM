function [Kt_elem,R] = LinearizedEquilibrium(PosicoesNodaisMat,PosicoesNodaisEsp,mu,lambda,F_ext)


% Localizacao e peso dos pontos de Gauss

      P = 1/sqrt(3);
      PontoGauss = [+P +P +P;
                    +P +P -P;
                    +P -P +P;
                    +P -P -P;
                    -P +P +P;
                    -P +P -P;
                    -P -P +P;
                    -P -P -P] ;

      W(1:8) = 1;

% Loop nos pontos de Gauss

     Kt_elem = zeros(24,24);
     F_int = zeros(24,1);
%      F_ext = zeros(24,1);

    for i = 1 : 8
      
      % Mapeamento Material
      JacobMat = J_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisMat(:,2:end));
      delNdelXMat = JacobMat' \ Derivadas_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3));  % J^{-T} delNdelE
    
      % Mapeamento Espacial
      JacobEsp = J_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisEsp(:,2:end));
      delNdelxEsP = JacobEsp' \ Derivadas_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3));  % J^{-T} delNdelE
    
      
      % Parte do Material
      F = Ftensor(PosicoesNodaisMat(:,2:end),PosicoesNodaisEsp(:,2:end),delNdelXMat);      
      Cauchy = NeoHookean_Cauchy (mu,lambda,F);
      
      
      % Mapeamento do Cauchy
      z3 = zeros(3);
      CauchyBarra  = [[Cauchy z3 z3 ]; [z3 Cauchy z3 ]; [z3 z3 Cauchy] ];
      CauchyVoigt  = [ Cauchy(1,1) Cauchy(2,2) Cauchy(3,3) Cauchy(1,2) Cauchy(2,3) Cauchy(1,3)]';
      
      B = B_Hex8 (delNdelxEsP);
      G = G_Hex8 (delNdelxEsP);
      D = D_Hex8 (mu,lambda,F);   % Matriz Elasticidade NeoHookean
           
      
      %Integração Numerica
      %Kt
      PolinomioG = G' * CauchyBarra * G * det(JacobEsp);
      PolinomioM = B' * D * B  * det(JacobEsp);
      Kt_elem = Kt_elem + (PolinomioM + PolinomioG) * W(i);
      
      % Forca Interna
      PolinomioForcaInterna = B' * CauchyVoigt * det(JacobEsp);
      F_int = F_int + PolinomioForcaInterna * W(i);
      
      % To be implemented ...
%       PolinomioForcaExterna = [];
%       F_ext = F_ext + PolinomioForcaExterna * W(i);
    
     end
      
      R = F_int - F_ext;     
      
end