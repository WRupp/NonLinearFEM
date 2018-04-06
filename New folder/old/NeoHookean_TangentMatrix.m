function Dneo = NeoHookean(mu,lambda,F)
    % Calculates de material stiffness matrix for a compressible
    % neo-Hookean material.

        Jvol = det(F);
        muL = ( mu - lambda*log(Jvol)) / Jvol ;
        lambdaL = lambda/Jvol;


         Dneo = [lambdaL+2*muL lambdaL       lambdaL       0   0   0;
                 lambdaL       lambdaL+2*muL lambdaL       0   0   0;
                 lambdaL       lambdaL       lambdaL+2*muL 0   0   0;
                 0             0             0             muL 0   0;
                 0             0             0             0   muL 0;
                 0             0             0             0   0   muL];

end
