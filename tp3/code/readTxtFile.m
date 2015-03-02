function [ X,Y ] = readTxtFile( pathToFile )
 fileID=fopen(pathToFile);
 data=textscan(fileID,'%f %f',43);
 fclose(fileID);

 X=data{1};
 Y=data{2};
end

