function fillFirstHole
% This function fills the hole "firstHole" in myTemplate.dotx
% Copyright 2016 - 2016 The MathWorks, Inc.
   import mlreportgen.dom.*;
   
   doc = Document('firstDocument', 'docx', 'myTemplate');
   holeId = moveToNextHole(doc);
   fprintf('Current hole ID: %s\n', holeId);
   textObj = Text('Hello World');
   append(doc, textObj);
   close(doc);
   
   rptview('firstDocument', 'docx');

end

