function Nglobal = local2global(GLpNo,NnosE,Nconec,k)
	% Mapeia os nos locais para o seu respectivo no global e o respectivo grau de liberdade.
	% NnosE - numero de nos por elemento NnosE
	% GLpNo - Numero de graus de liberdade por no

    for i = 1 : NnosE
        for dof = 1 : GLpNo
            Nglobal ( GLpNo * (i-1) + dof ) = GLpNo * ( Nconec(k,i+1) - 1 ) + dof;
        end
    end

end
