clear; close all;
% Determina e adiciona todas as subfolders
folder = fileparts(which(mfilename));
addpath(genpath(folder));

%% Constantes de material
lambda = 5800;
mu =380;



%% Malha % Sistema de Unidades [mm,MPa,s]

      ngl = 3;



      Ncoord =             [1 0 0 1 ;
                            2 0 0 0 ;
                            3 0 1 0 ;
                            4 0 1 1 ;
                            5 1 0 1 ;
                            6 1 0 0 ;
                            7 1 1 0 ;
                            8 1 1 1 ] ;

      Ncoord = sortrows(Ncoord); % Para garantir que estejam em ordem

      % Conectividade
      Nconec = [ 1 1 2 3 4 5 6 7 8];

        i = 1 ; % s� tem um elemento
        cont = 1;
      for j = 2 : size(Nconec,2);
      Nno = Nconec(i,j);
      PosicoesNodaisMat(cont,:) = Ncoord(Nno,:);
      cont = cont+1;
      end

%% Condicoes de Contorno (CC)
      % Matriz das Variacoes de deslocamento preescritas
      Mcc = [ 1 0 1;
              2 0 1;
              3 0 1;
              4 0 1;
              1 0 2;
              2 0 2;
              5 0 2;
              6 0 2;
              2 0 3;
              3 0 3;
              6 0 3;
              7 0 3;];

      %Variacoes de Deslocamento preescritos

      %Nota : Mcc e U_prescrito devem estar concordantes. Assim como
      % onde há desloc não ha força_ext e vice-versa

      % Deslocamento preescrito

      U_prescrito = zeros(size(PosicoesNodaisMat(:,2:end)));

      Mcc = [ Mcc;
              5 0 1;
              6 0 1;
              7 0 1;
              8 0 1];

      U_prescrito ([5 6 7 8],1)= .5 ;

      % Forcas Externas

    F_ext = zeros(24,1);
    F_ext_Incr = zeros(24,1);

    globalDOF = globalDOF([5 6 7 8],1,ngl);
%     F_ext(globalDOF) = 200;

  % Definicao dos Incrementos de forca e/ou deslocamento

    incrDiv = 100;
    deltaForca = F_ext ./ incrDiv;
    deltaDisp = U_prescrito ./ incrDiv;

  % Chute Inicial

   U = zeros(size(PosicoesNodaisMat(:,2:end)));
   PosicoesNodaisEsp = PosicoesNodaisMat;
   PosicoesNodaisEsp(:,2:end) = PosicoesNodaisMat(:,2:end) + U;





% Loop Newton
R = ones(24,1);


for t = 1 : incrDiv

    U =  U  + deltaDisp;
    F_ext_Incr = F_ext_Incr + deltaForca ;

    cont = 1;

   while( norm(R)> 1e-5 )

        [Kt_elem,R] = LinearizedEquilibrium(PosicoesNodaisMat , PosicoesNodaisEsp, mu, lambda, F_ext_Incr);

        [Kt_elem,R] = AplicaCC (Kt_elem , R , Mcc , 3);

        DeltaU = - Kt_elem \ R ;

        DeltaU_org = organizaU(DeltaU,ngl,8);

        U = U + DeltaU_org;

        PosicoesNodaisEsp(:,2:end) = PosicoesNodaisMat(:,2:end) + U;

        cont = cont+1;

        norm(R)


   end


        NiterConvergir(t) = cont;
        R = ones(24,1);

end

plot(0:1,0:1)
ans = 3
