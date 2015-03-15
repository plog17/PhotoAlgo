function [ pts ] = readTxtFile( pathToFile )
 fileID=fopen(pathToFile);
 data=textscan(fileID,'%f %f',43);
 fclose(fileID);

 X=data{1};
 Y=data{2};
 pts=cat(2,X,Y);
end

