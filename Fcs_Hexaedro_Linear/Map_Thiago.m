function [G,B,CauchyMatrix] = Map_Thiago (e1,e2,e3,PosicoesNodais,Cauchy)

% Calcula as matrizes com a notacao da Qualificacao do Thiago - pg 83

% Calcula a matriz de tensoes
        z3 = zeros(3);
        CauchyMatrix = [[Cauchy z3 z3];[ z3 Cauchy z3];[ z3 z3 Cauchy]; ];

% Calculo do Jacobiano

J = J_Hex8(e1,e2,e3,PosicoesNodais);

% Derivadas em termos de e1 e e2

Psi = Derivadas_Hex8(e1,e2,e3);

% Calculos

invJ = inv(J);

BJ = [[invJ zeros(3) zeros(3)];
      [zeros(3) invJ zeros(3)];
      [zeros(3) zeros(3) invJ];];



P3L = [Psi(:,1) zeros(3,2) Psi(:,2) zeros(3,2) Psi(:,3) zeros(3,2) Psi(:,4) zeros(3,2) Psi(:,5) zeros(3,2) Psi(:,6) zeros(3,2) Psi(:,7) zeros(3,2) Psi(:,8) zeros(3,2)  ];
M3L = [zeros(3,1) Psi(:,1) zeros(3,1) zeros(3,1) Psi(:,2) zeros(3,1) zeros(3,1) Psi(:,3) zeros(3,1) zeros(3,1) Psi(:,4)  zeros(3,1) zeros(3,1) Psi(:,5)  zeros(3,1) zeros(3,1) Psi(:,6)  zeros(3,1) zeros(3,1) Psi(:,7)  zeros(3,1) zeros(3,1) Psi(:,8)  zeros(3,1) ];
U3L = [zeros(3,2) Psi(:,1) zeros(3,2) Psi(:,2) zeros(3,2) Psi(:,3) zeros(3,2) Psi(:,4) zeros(3,2) Psi(:,5) zeros(3,2) Psi(:,6) zeros(3,2) Psi(:,7) zeros(3,2) Psi(:,8)  ];

BN = [P3L ; M3L ; U3L];

BC = [ 1 0 0 0 0 0 0 0 0;
       0 0 0 0 1 0 0 0 0;
       0 0 0 0 0 0 0 0 1;
       0 1 0 1 0 0 0 0 0;
       0 0 0 0 0 1 0 1 0;
       0 0 1 0 0 0 1 0 0;];

G = BJ * BN;

B = BC* G;

end
