%%

% paramètres de la droite
a = 5; 
b = 1; 

% échantillons sur l'axe x
x = linspace(0,1,100);

% bruit gaussien
e = randn(size(x)) / 4;

% variables y
y = a*x+b + e;

figure(1); clf;
plot(x, y, 'o');

%% Rajoutons des "outliers"
y(10) = 5;
y(11) = 5;

% plot(x, y, 'o');


%%

% forme matricielle
A = cat(2, x(:), ones(size(x(:))));
b = y(:);

% solvons le système d'équations linéaire
p = pinv(A)*b;

% équivalent
p = inv(A'*A)*A'*b;

% pas tout à fait équivalent, mais... 
p = A\b;

% affichons la droite estimée
hold on;
plot(x, p(1)*x + p(2), '--r');

%% Pouvons-nous être robustes aux "outliers"?
p = robustfit(A, b, [], [], 'off');

plot(x, p(1)*x + p(2), '-g');
