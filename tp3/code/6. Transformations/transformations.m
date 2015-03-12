% Déclarer des valeurs symboliques
syms tx ty theta sx sy

% matrice de translation
A1 = [1 0 tx; 0 1 ty; 0 0 1];

% matrice de rotation
A2 = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];

% matrice d'échelle
A3 = [sx 0 0; 0 sy 0; 0 0 1];

% essayons A1*A2*A3
T1 = A1*A2*A3

% maintenant, changeons l'ordre des transformations
T2 = A3*A2*A1

% pour en être bien certain:
isequal(T1, T2)
