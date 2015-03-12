%%

% param�tres de la droite
a = 5; 
b = 1; 

% �chantillons sur l'axe x
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

% solvons le syst�me d'�quations lin�aire
p = pinv(A)*b;

% �quivalent
p = inv(A'*A)*A'*b;

% pas tout � fait �quivalent, mais... 
p = A\b;

% affichons la droite estim�e
hold on;
plot(x, p(1)*x + p(2), '--r');

%% Pouvons-nous �tre robustes aux "outliers"?
p = robustfit(A, b, [], [], 'off');

plot(x, p(1)*x + p(2), '-g');
