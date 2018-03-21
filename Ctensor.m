function C = Ctensor(Ftensor)
    % Calculates the right Cauchy-Green stretch tensor
    
    C = transpose(Ftensor)*Ftensor;

end