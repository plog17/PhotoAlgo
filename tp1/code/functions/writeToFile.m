function writeToFile(text, file)
fileID = fopen(file,'w');
fprintf(fileID,text);
fclose(fileID);
