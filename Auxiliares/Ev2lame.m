function [lambda,mu] = Ev2lame(E,v)
	% Converte os parametros materiais de modulo de Elasticidade E e o coeficiente de poisson v para as constantes de lamé

	lambda = E*v /((1+v)*(1-2*v));

	mu = E / (2(1+v));

end