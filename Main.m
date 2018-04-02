clear; close all; clc;
% Determina e adiciona todas as subfolders
folder = fileparts(which(mfilename));
addpath(genpath(folder));

%% Constantes de material
E = 2e5;
v = 0.3;

% [lambda,mu] = Ev2lame (E,v);
mu = 3.8e2;
lambda = 5.8e3;

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
                      5 1.01 1 0 ;
                      6 1.01 0 0 ;
                      7 1.01 0 1 ;
                      8 1.01 1 1 ];


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

%% Forcas externas e chute inicial

      Fext = zeros(24,1); % Sem forcas externas

      Mcc = [ 1 0 1;
              2 0 1;
              3 0 1;
              4 0 1;
              2 0 2;
              3 0 2;
              6 0 2;
              7 0 2;
              1 0 3;
              5 0 3;
              6 0 3;
              2 0 3;             
              5 1.2 1;
              6 1.2 1;
              7 1.2 1;
              8 1.2 1];


      Fint = NeoHookean_Fint(PontoGauss,W,PosicoesNodaisMat,PosicoesNodaisEsp,mu,lambda);
      R = Fint - Fext ;

%       Kt = sparse(24);

while(norm(R)>1e-6)

      [Kt] = NeoHookean_Kt(PontoGauss,W,PosicoesNodaisMat,PosicoesNodaisEsp,mu,lambda);

      [Kt,R] = AplicaCC (Kt,R,Mcc,3);

      DeltaU = Kt \ (-R);

      Uorg = organizaU(DeltaU,3,8);

      PosicoesNodaisEsp(:,2:end) = PosicoesNodaisMat(:,2:end) + Uorg;

      Fint = NeoHookean_Fint(PontoGauss,W,PosicoesNodaisMat,PosicoesNodaisEsp,mu,lambda);

      R = Fint - Fext ;

end


%% Fim
