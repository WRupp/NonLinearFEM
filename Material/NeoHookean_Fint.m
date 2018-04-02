function Fint = NeoHookean_Fint(PontoGauss,W,PosicoesNodaisMat,PosicoesNodaisEsp,mu,lambda)

% Calculo das Forcas Internas

Fint = 0;

for i = 1 : 8
    
    % Jacobiano
    
    JX = J_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisMat(:,2:end));
    
    Jx = J_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisEsp(:,2:end));
    
    % Derivadas das funcoes de forma em X material
    
    delNdelX = inv(JX)' * Derivadas_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3));
    
    % Derivadas das funcoes de forma em x espacial
    
    delNdelx = inv(Jx)' * Derivadas_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3));
    
    % Tensor gradiente de mapeamento
    F = Ftensor( PosicoesNodaisMat(:,2:end) , PosicoesNodaisEsp(:,2:end), delNdelX);
    
    % Tensor tensao 
    Cauchy = NeoHookeanCauchy (mu,lambda,F);
    
    % Forca interna    
    T = Cauchy * delNdelx ;
    
    PolinomioForcaInterna = [];
    
    for j = 1 : size(T,2);
        PolinomioForcaInterna(3*(j-1)+1:3*(j),1 ) =   T(:,j);   
    end 

    Fint = Fint + PolinomioForcaInterna * det(Jx) * W(i);

    % Forcas externas

    %%% Nao implementado forcas distribuidas
end
end