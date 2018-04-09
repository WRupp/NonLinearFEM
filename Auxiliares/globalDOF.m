function GlobalDOF = globalDOF(NnoGlobal,localDOF,GLpNo)
  % Calcula o o apropriado grau de liberdade referente ao nó Nglobal
  % GLpNo - Graus de Liberdade por nó
  % Direcao - localDOF
  % x       - 1
  % y       - 2
  % z       - 3

  GlobalDOF =  GLpNo * (NnoGlobal-1) + localDOF;

end
