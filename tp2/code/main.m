percentageToDelete=40;
resizeVertically=false;
logging=true;
generateAnimatedGif=true;
selectROI=false;

path='/Users/plauger/git/PhotoAlgo/tp2/web/images/originals/';

%% Algorithme dynamique
%%Utilise une approche par programmation dynamique. L'algorithme est rapide
%%et effectue le meilleur choix quant � la ligne/colonne � supprimer.

%% Utilisation
%%function batchProcessDynamicProg(pathToImages,percentage,resizeVertically,generateAnimatedGif,selectROI,logging)

batchProcessDynamicProg(path,percentageToDelete,true,generateAnimatedGif,true,logging);
%batchProcessDynamicProg(path,percentageToDelete,false,generateAnimatedGif,false,logging);

%% Algorithme Greedy
%%Le premier choix glouton consiste � choisir le pixel sur la premi�re
%%rang�e ayant la plus basse �nergie. Le chemin est d�termin� � partir de
%%ce premier choix. L'algorithme est rapide, mais n'effectue pas la
%%suppression la plus optimale.

%% Utilisation
%%function batchProcessGreedyFirstChoice(pathToImages,percentage,resizeVertically,generateAnimatedGif,logging)

batchProcessGreedyFirstChoice(path,percentageToDelete,resizeVertically,generateAnimatedGif,logging);