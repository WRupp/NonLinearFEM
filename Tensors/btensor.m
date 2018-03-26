function b = btensor(Ftensor)
    % Calculates the left Cauchy-Green stretch tensor
    
    b = Ftensor * transpose(Ftensor);

end