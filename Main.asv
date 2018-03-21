clear; close all;
% Determina e adiciona todas as subfolders
folder = fileparts(which(mfilename)); 
addpath(genpath(folder));

%% Constantes de material
E = 2e5;
v = 0.3;

[lambda,mu] = Ev2lame (E,v);

%% Malha

% Sistema de Unidades [mm,MPa,s]

PosicoesNodaisMat =  [1 0 1 0 ;
                      2 0 0 0 ;
                      3 0 0 1 ;
                      4 0 1 1 ;
                      5 1 1 0 ;
                      6 1 0 0 ;
                      7 1 0 1 ;
                      8 1 1 1 ] ;
                  
          
PosicoesNodaisEsp =  [1 0 1 0 ;
                      2 0 0 0 ;
                      3 0 0 1 ;
                      4 0 1 1 ;
                      5 2 1 0 ;
                      6 2 0 0 ;
                      7 2 0 1 ;
                      8 2 1 1 ];
                  
% Tração                  
                  
        p = 2;  % [MPa]          
                  
                  
                  
%% Coisas do Hexa8
          
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

%% Integração do elemento      
      Int = 0;
          
for i = 1 : 8
    
    % Jacobiano
    J = J_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisMat(:,2:end));
    
    % Derivadas das funcoes de forma em X material
    delNdelX = inv(J)' * Derivadas_Hex8(PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3));
    
    % Tensor gradiente de mapeamento
    F = Ftensor(PosicoesNodaisMat(:,2:end),PosicoesNodaisEsp(:,2:end),delNdelX);
    
    % Matriz de Derivadas 
    B = B_Hex8 (PontoGauss(i,1),PontoGauss(i,2),PontoGauss(i,3),PosicoesNodaisEsp(:,2:end));
    
    % Matriz tangente do material
    Cnh = NeoHookean(mu,lambda,F);
   
    % Polinomio a ser integrado
    Polinomio = B' * Cnh * B;
    
    % Integracao numerica
    Int = Int + Polinomio * W(i);
end
    
%% Fim  
          
           
           
           
           

