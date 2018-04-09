function [D] = D_Hex8(mu,lambda,F)
    % Calcula a matriz D para o elemento Hexa8 (atente para o tipo de
    % mapeamento de Voigt utilizado
    
    % [e11 e22 e33 e12 e23 e13]
    
    c1111 = c_esp(lambda,mu,F,[1 1 1 1]);
    c1122 = c_esp(lambda,mu,F,[1 1 2 2]);
    c1133 = c_esp(lambda,mu,F,[1 1 3 3]);
    c1112 = c_esp(lambda,mu,F,[1 1 1 2]);
    c1123 = c_esp(lambda,mu,F,[1 1 2 3]);
    c1113 = c_esp(lambda,mu,F,[1 1 1 3]);
    
    c2222 = c_esp(lambda,mu,F,[2 2 2 2]);
    c2233 = c_esp(lambda,mu,F,[2 2 3 3]);
    c2212 = c_esp(lambda,mu,F,[2 2 1 2]);
    c2223 = c_esp(lambda,mu,F,[2 2 2 3]);
    c2213 = c_esp(lambda,mu,F,[2 2 1 3]);
    
    c3333 = c_esp(lambda,mu,F,[3 3 3 3]);
    c3312 = c_esp(lambda,mu,F,[3 3 1 2]);
    c3323 = c_esp(lambda,mu,F,[3 3 2 3]);
    c3313 = c_esp(lambda,mu,F,[3 3 1 3]);
     
    c1212 = c_esp(lambda,mu,F,[1 2 1 2]);
    c1223 = c_esp(lambda,mu,F,[1 2 2 3]);
    c1213 = c_esp(lambda,mu,F,[1 2 1 3]);
    
    c2323 = c_esp(lambda,mu,F,[2 3 2 3]);
    c2313 = c_esp(lambda,mu,F,[2 3 1 3]);
    
    c1313 = c_esp(lambda,mu,F,[1 3 1 3]);
    
    D = [ c1111 c1122 c1133 c1112 c1123 c1113;
          c1122 c2222 c2233 c2212 c2223 c2213;
          c1133 c2233 c3333 c3312 c3323 c3313;
          c1112 c2212 c3312 c1212 c1223 c1213;
          c1123 c2223 c3323 c1223 c2323 c2313;
          c1113 c2213 c3313 c1213 c2313 c1313];
end