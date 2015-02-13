rowToDelete=5;
resizeVertically=true;
logging=true;
generateAnimatedGif=false;

%%Utilise une approche par programmation dynamique. L'algorithme est rapide
%%et effectue le meilleur choix quant � la ligne/colonne � supprimer.
batchProcessDynamicProg('/Users/plauger/Pictures/Photographie Algorithmique/TP2/images/',rowToDelete,resizeVertically,generateAnimatedGif,logging);

%%Le premier choix glouton consiste � choisir le pixel sur la premi�re
%%rang�e ayant la plus basse �nergie. Le chemin est d�termin� � partir de
%%ce premier choix. L'algorithme est rapide, mais n'effectue pas la
%%suppression la plus optimale.
batchProcessGreedyFirstChoice('/Users/plauger/Pictures/Photographie Algorithmique/TP2/images/',rowToDelete,resizeVertically,generateAnimatedGif,logging);