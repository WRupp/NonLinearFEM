clear; close all; clc;
% Determina e adiciona todas as subfolders
folder = fileparts(which(mfilename));
addpath(genpath(folder));

%% Constantes de material
E = 2e5;
v = 0.3;

% [lambda,mu] = Ev2lame (E,v);
lambda = 5800;
mu =380;

%% Malha

ngl = 3;

% Sistema de Unidades [mm,MPa,s]

PosicoesNodaisMat =  [1 0 0 1 ;
                      2 0 0 0 ;
                      3 0 1 0 ;
                      4 0 1 1 ;
                      5 1 0 1 ;
                      6 1 0 0 ;
                      7 1 1 0 ;
                      8 1 1 1 ] ;


%% Coisas para a integracao numerica

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

%% Condicoes de contorno

      Mcc = [ 1 0 1;
              2 0 1;
              3 0 1;
              4 0 1;
              1 0 2;
              5 0 2;
              6 0 2;
              2 0 2;
              2 0 3;
              3 0 3;
              6 0 3;
              7 0 3;
              5 0.005 1;
              6 0.005 1;
              7 0.005 1;
              8 0.005 1;];
%           
 
%% Forcas externas 

      Fext = zeros(24,1); % Sem forcas externas          
          
    Mfn = [];

for i=1:size(Mfn,1)
    Fext(ngl*(Mfn(i,1)-1) + Mfn(i,3)) = Mfn(i,2);
end

%% chute inicial

    PosicoesNodaisEsp =  PosicoesNodaisMat;
    PosicoesNodaisEsp(5:8,2) = 1.005;

    Fint = NeoHookean_Fint(PontoGauss,W,PosicoesNodaisMat,PosicoesNodaisEsp,mu,lambda);
    R = Fint - Fext ;

    
    [Kt] = NeoHookean_Kt(PontoGauss,W,PosicoesNodaisMat,PosicoesNodaisEsp,mu,lambda);

    [Kt,R] = AplicaCC (Kt,R,Mcc,3);
     
    nIncr = 30;
%     Fincr = Fext / nIncr;
%     Fext = Fincr;
%     

    
% for t = 1 : nIncr
    
        
    % Probleminha - Nao se está usando a informacao do ultimo estado de
    % nenhuma forma para o proximo passo
    
    while(norm(R)>1e-6)

          [Kt] = NeoHookean_Kt(PontoGauss,W,PosicoesNodaisMat,PosicoesNodaisEsp,mu,lambda);

          [Kt,R] = AplicaCC (Kt,R,Mcc,3);

          DeltaU = Kt \ (-R);

          Uorg = organizaU(DeltaU,3,8);

          PosicoesNodaisEsp(:,2:end) = PosicoesNodaisEsp(:,2:end) + Uorg;
          
          Fint = NeoHookean_Fint(PontoGauss,W,PosicoesNodaisMat,PosicoesNodaisEsp,mu,lambda);
          
          R = Fint - Fext ;
          
          norm(R)
          
    end
% end
%% Fim
