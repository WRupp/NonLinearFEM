function [componente_C_esp] = c_esp(lambda,mu,F,vetorComponente)
% vetorComponente = [ i , j , k , l)

if size(vetorComponente,1)>1
   error('vetorComponente tem mais de uma linha');    
end

J = det(F);
lambdaL = lambda / J ;
muL = mu / J ; 

i = vetorComponente(1);
j = vetorComponente(2);
k = vetorComponente(3);
l = vetorComponente(4);

if i == j
    KroeneckerIJ = 1;
else
    KroeneckerIJ = 0 ;
end

if k == l
    KroeneckerKL = 1;
else
    KroeneckerKL = 0 ;
end


if i == k
    KroeneckerIK = 1;
else
    KroeneckerIK = 0 ;
end

if j == l
    KroeneckerJL = 1;
else
    KroeneckerJL = 0 ;
end

    componente_C_esp = lambdaL * KroeneckerIJ * KroeneckerKL  + muL * KroeneckerIK * KroeneckerJL ;
    
    
end


















