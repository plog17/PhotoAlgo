percentageToDelete=75;
resizeVertically=false;
logging=true;
generateAnimatedGif=true;
selectROI=false;

%%Utilise une approche par programmation dynamique. L'algorithme est rapide
%%et effectue le meilleur choix quant � la ligne/colonne � supprimer.
%batchProcessDynamicProg('/Users/plauger/Pictures/Photographie Algorithmique/TP2/images/',percentageToDelete,false,generateAnimatedGif,selectROI,logging);
batchProcessDynamicProg('/Users/plauger/git/PhotoAlgo/tp2/web/images/originals/internet/',percentageToDelete,false,generateAnimatedGif,true,logging);

batchProcessDynamicProg('/Users/plauger/Pictures/Photographie Algorithmique/TP2/images/',percentageToDelete,false,generateAnimatedGif,true,logging);

%%Le premier choix glouton consiste � choisir le pixel sur la premi�re
%%rang�e ayant la plus basse �nergie. Le chemin est d�termin� � partir de
%%ce premier choix. L'algorithme est rapide, mais n'effectue pas la
%%suppression la plus optimale.

%batchProcessGreedyFirstChoice('/Users/plauger/Pictures/Photographie Algorithmique/TP2/images/',percentageToDelete,resizeVertically,generateAnimatedGif,logging);