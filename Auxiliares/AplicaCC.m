function [Kglobal,Fglobal] = AplicaCC (Kglobal,Fglobal,Mcc,GLpNo)
    % Aplica as condicoes de contorno nos nós, substituido por uma linha
    % de zeros, com 1 na diagonal principal
  
     % declaracoes iniciais
     sCC = size(Mcc,1);
     sKg = size(Kglobal,1);
     
     % Vetor para salvar as linhas/colunas substituidas
     salvaEq=zeros(sCC, 1 + sKg);

     for i=1:sCC

         Nno = Mcc(i,1);
         dof = Mcc(i,3);
         nG = GLpNo*(Nno-1) + dof;
         
         salvaEq(i,1)=nG;
         salvaEq(i,2:end)= Kglobal(nG,:);

         Kglobal(nG,:)=0;
         Kglobal(:,nG)=0;
         Kglobal(nG,nG)=1;

         Fglobal(:) = Fglobal(:) - Mcc(i,2) * salvaEq(i,2:end)';
         Fglobal(nG) =  Mcc(i,2);         
     end
 
end