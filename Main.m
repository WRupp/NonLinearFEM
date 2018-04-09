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

        i = 1 ; % só tem um elemento
        cont = 1;
      for j = 2 : size(Nconec,2);
      Nno = Nconec(i,j);   
      PosicoesNodaisMat(cont,:) = Ncoord(Nno,:);  
      cont = cont+1;
      end      
    
      
%       PosicoesNodaisEsp = PosicoesNodaisMat;
%       PosicoesNodaisEsp(:,2) = 1.020*PosicoesNodaisMat(:,2);      
      
      % Matriz das CC - 
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
   
 
    F_ext = zeros(24,1);
    F_ext_Incr = zeros(24,1);
    
    globalDOF = globalDOF([5 6 7 8],1,ngl);
%     F_ext(globalDOF) = 200;
 
    
    %Variacoes de Deslocamento preescritos
    Mcc = [ Mcc;
            5 0 1;
            6 0 1;
            7 0 1;
            8 0 1];
    
    % Deslocamento preescrito    
    L = zeros(size(PosicoesNodaisMat(:,2:end))); 
    L([5 6 7 8],1)= 1 ;
        
    incrDiv = 100;
    deltaForca = F_ext ./ incrDiv;
    deltaDisp = L ./ incrDiv;
    
       
              
% Loop Newton 

   U = zeros(size(PosicoesNodaisMat(:,2:end)));
   PosicoesNodaisEsp = PosicoesNodaisMat;
   PosicoesNodaisEsp(:,2:end) = PosicoesNodaisEsp(:,2:end) + U;
  
    
for t = 1 : incrDiv  
    
    U =  U  + deltaDisp;
    F_ext_Incr = F_ext_Incr + deltaForca ;
    
    R = ones(24,1);    
    
    cont = 1;
       
   while( norm(R)> 1e-6 )
       
        [Kt_elem,R] = LinearizedEquilibrium(PosicoesNodaisMat , PosicoesNodaisEsp, mu, lambda, F_ext_Incr);       
        
        [Kt_elem,R] = AplicaCC (Kt_elem , R , Mcc , 3);            

        DeltaU = - Kt_elem \ R ;

        DeltaU_org = organizaU(DeltaU,ngl,8);
          
        U = U + DeltaU_org;

        PosicoesNodaisEsp(:,2:end) = PosicoesNodaisMat(:,2:end) + U;
        
        cont = cont+1;
        
        norm(R)
                  
   end 
end      

      
      