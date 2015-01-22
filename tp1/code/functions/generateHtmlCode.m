function code = generateHtmlCode(filename,rxoffset,ryoffset,gxoffset,gyoffset)
rxoffset=int2str(rxoffset);
ryoffset=int2str(ryoffset);
gxoffset=int2str(gxoffset);
gyoffset=int2str(gyoffset);

%code=strcat('<div class="result"><img src="/pictures/q2_aligned_',filename,'.jpg" width="380" height="250"><p>Red Offset : x=',rxoffset,', y=',ryoffset,'<br>Green Offset : x=', gxoffset,', y=',gyoffset,'</p></div>');
code=strcat('<div class="col-md-6 portfolio-item"><a href="#"><img class="img-responsive" src="pictures/q1_aligned_',filename,'" alt=""></a><h4><p>',filename,'</p></h4><p>Red Offset : x = ',rxoffset,', y = ',ryoffset,'<br>Green Offset : x = ', gxoffset,', y = ',gyoffset,'</p></div>');
