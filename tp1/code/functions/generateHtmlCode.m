function code = generateHtmlCode(filename,rxoffset,ryoffset,gxoffset,gyoffset)
rxoffset=int2str(rxoffset);
ryoffset=int2str(ryoffset);
gxoffset=int2str(gxoffset);
gyoffset=int2str(gyoffset);

%code=strcat('<div class="result"><img src="/pictures/q2_aligned_',filename,'.jpg" width="380" height="250"><p>Red Offset : x=',rxoffset,', y=',ryoffset,'<br>Green Offset : x=', gxoffset,', y=',gyoffset,'</p></div>');
%fullres
code=strcat('<div class="col-md-6 portfolio-item"><a href=""pictures/q3_aligned_',filename,'"><img class="img-responsive" src="pictures/q2_aligned_',filename,'" alt=""></a><h5><a href="pictures/q3_aligned_',filename,'"</a></h5><p>Décalage du canal rouge : x=',rxoffset,', y=',ryoffset,'<br>Décalage du canal vert : x=', gxoffset,', y=',gyoffset,'</p></div>');
%code=strcat('<div class="col-md-4 portfolio-item"><img class="img-responsive" src="pictures/q1_aligned_',filename,'" alt=""></a><p>Décalage du canal rouge : x=',rxoffset,', y=',ryoffset,'<br>Décalage du canal vert : x=', gxoffset,', y=',gyoffset,'</p></div>');
