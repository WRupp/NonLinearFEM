function [Kglobal,Fglobal] = AplicaCC (Kglobal,Fglobal,Mcc,GLpNo)
    % Aplica as condicoes de contorno nos nós, substituido por uma linha
    % de zeros, com 1 na diagonal principal
     
     sCC = size(Mcc,1);

        %Loop ao longo de Mcc
     for i=1:sCC
        
         Nno = Mcc(i,1);
         dof = Mcc(i,3);
         nG = GLpNo*(Nno-1) + dof;
                  
         salvaEq= Kglobal(:,nG);

         Kglobal(nG,:)=0;
         Kglobal(:,nG)=0;
         Kglobal(nG,nG)=1;

         Fglobal(:) = Fglobal(:) + Mcc(i,2) * salvaEq;
         Fglobal(nG) =  Mcc(i,2);         
     end
 
end