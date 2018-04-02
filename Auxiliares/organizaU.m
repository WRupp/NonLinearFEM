function Uorg = organizaU(U,nGL,Nnos)
    % Uma funcao que organiza o vetor U em uma matriz onde a linha contem o
    % no e os GL apropriados para aquele no
    
  for j = 1 :  Nnos 
    for i = 1  : nGL        
        Uorg (j,i) = U(nGL*(j-1)+i);        
    end
  end

end