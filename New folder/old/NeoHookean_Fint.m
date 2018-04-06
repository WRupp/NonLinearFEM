function Fint = NeoHookean_Fint(PontoGauss,W,PosicoesNodaisMat,PosicoesNodaisEsp,mu,lambda)

% Calculo das Forcas Internas

Fint = 0;

for i = 1 : 8
    
    % Jacobiano
    
    JX = J_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisMat(:,2:end));
    
    Jx = J_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisEsp(:,2:end));
    
    % Derivadas das funcoes de forma em X material
    
    delNdelX = inv(JX)' * Derivadas_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3));
  
    
    % Tensor gradiente de mapeamento
    F = Ftensor( PosicoesNodaisMat(:,2:end) , PosicoesNodaisEsp(:,2:end), delNdelX);
    
    % Tensor tensao 
    Cauchy = NeoHookean_Cauchy (mu,lambda,F);
    
    z3 = zeros(3);
    CauchyBarra  = [[Cauchy z3 z3 ]; [z3 Cauchy z3 ]; [z3 z3 Cauchy] ];
    
    % Forca interna    
%     T = Cauchy * delNdelX ;s
    
    B = B_Hex8 (PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisEsp(:,2:end));
    
%     Fint = B'*CauchyBarra
    
     PolinomioForcaInterna = B' * CauchyBarra * det(Jx);
% %     for j = 1 : size(T,2);
% %         PolinomioForcaInterna(3*(j-1)+1:3*(j),1 ) =   T(:,j);   
% %     end 

    Fint = Fint + PolinomioForcaInterna  * W(i);

    % Forcas externas

    %%% Nao implementado forcas distribuidas
end
end