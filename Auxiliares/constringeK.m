function [Kdel,Fdel] = constringeK (Kglobal,F,Mcc,GLpNo)


     Kdel = Kglobal;
     Fdel = F;

     for i=0:size(Mcc,1)-1

     Nno = Mcc(end-i,1);
     dof = Mcc(end-i,3);

     nG = GLpNo*(Nno-1) + dof;

     Kdel(nG,:)=[];
     Kdel(:,nG)=[];

     Fdel(nG) = [];

     end
 
end