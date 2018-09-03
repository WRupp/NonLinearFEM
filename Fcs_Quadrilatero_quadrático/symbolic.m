syms e1 e2

% --------------------------
Phi1 (e1,e2) = - 1/4 * ( 1 - e1) * (1 + e2) * (1 + e1 - e2 );

dphi11 = simplify ( diff(Phi1,e1) )
dphi12 = simplify ( diff(Phi1,e2) )

% --------------------------
Phi2 (e1,e2) = - 1/4 * ( 1 + e1) * (1 + e2) * (1 - e1 - e2 ) ;
dphi21 = simplify ( diff(Phi2,e1) )
dphi22 = simplify ( diff(Phi2,e2) )

% --------------------------
Phi3 (e1,e2) = + 1/4 * ( 1 + e1) * (1 - e2) * (-1 + e1 - e2 ) ;
dphi31 = simplify ( diff(Phi3,e1) )
dphi32 = simplify ( diff(Phi3,e2) )

% --------------------------
Phi4 (e1,e2) = + 1/4 * ( 1 - e1) * (1 - e2) * (-1 - e1 - e2 ) ;
dphi41 = simplify ( diff(Phi4,e1) )
dphi42 = simplify ( diff(Phi4,e2) )

% --------------------------
Phi5 (e1,e2) = 1/2 *  ( 1 + e1 ) * ( 1 - e1) * ( 1 + e2);
dphi51 = simplify ( diff(Phi5,e1) )
dphi52 = simplify ( diff(Phi5,e2) )

% --------------------------

Phi6 (e1,e2) = 1/2 *  ( 1 + e1 ) * ( 1 + e2) * ( 1 - e2);
dphi61 = simplify ( diff(Phi6,e1) )
dphi62 = simplify ( diff(Phi6,e2) )

% --------------------------
Phi7 (e1,e2) = 1/2 *  ( 1 - e1 ) * ( 1 + e1) * ( 1 - e2);
dphi71 = simplify ( diff(Phi7,e1) )
dphi72 = simplify ( diff(Phi7,e2) )

% --------------------------
Phi8 = 1/2 *  ( 1 - e1 ) * ( 1 - e2) * ( 1 + e2);
dphi81 = simplify ( diff(Phi8,e1) )
dphi82 = simplify ( diff(Phi8,e2) )


