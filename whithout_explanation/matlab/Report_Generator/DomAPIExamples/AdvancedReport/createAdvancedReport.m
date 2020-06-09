function createAdvancedReport
clc
%ADVANCEDREPORTCREATE This function creates the file AdvancedReport.docx
%   First it calls the function "getAdvancedReportData" to get the data
%   that should be shown in the report. Then it loops through the holes in
%   "AdvancedReportTemplate" and fills the holes with the data.
%   Copyright 2016 - 2016 The MathWorks, Inc.

   import mlreportgen.dom.*
   
   %Get the report data from the interface
   reportData = getAdvancedReportData;
   %Create new object of class Document, based on AdvancedReportTemplate
   doc = Document('AdvancedReport', 'docx', 'AdvancedReportTemplate');
   %Move to the first hole
   currentHoleId = moveToNextHole(doc);
   %While we have not reached the end, we loop through all the holes
   while ~strcmp(currentHoleId, '#end#')
      %For some holes we perform a special handling, all "standard" holes
      %are filled with processStandardHole in the otherwise case
      switch currentHoleId 
         case 'Image'
            processImage(doc, reportData, currentHoleId);
         case 'SimpleTable' 
            processSimpleTable(doc, reportData, currentHoleId);
         case 'AdvancedTable' 
            processAdvancedTable(doc, reportData, currentHoleId);
         otherwise
            processStandardHole(doc, reportData, currentHoleId);
      end
      currentHoleId = moveToNextHole(doc); 
   end
   %Close the document and write the result to disc
   close(doc);
   %Show the result
   rptview('AdvancedReport.doxc','pdf');
end


function processImage(doc, reportData, holeId)
   %This function adds an image to our report
   import mlreportgen.dom.*   

   %We access the reportData structure dynamically
   fileName = reportData.(holeId);
   %A new Image objected is created and the image is sized 10x10cm
   img = Image(fileName);
   img.Width  = '10cm';
   img.Height = '10cm';
   
   %We create a new paragraph, based on the AR_Image style and append the
   %image to this paragraph. This is done because this style has a center
   %alignment, and so the image is centered too.
   p = Paragraph( '', 'AR_Image' );
   append(p, img);
   append(doc, p);

   %After the image we add another paragraph of AR_Caption style. This
   %style counts the number of images and adds "Figure X: " on front of our
   %text
   p = Paragraph('This is the MATLAB logo.', 'AR_Caption');
   append(doc, p);
end


function processSimpleTable(doc, reportData, holeId)
   %This function adds a simple table, which is based on the Word style
   %"_AR_Table" to our report
   import mlreportgen.dom.*
   
   %We add a new Level2 Heading before this table
   p = Paragraph('Simple Table Example', 'AR_Heading2');
   append(doc, p);
   %And some description
   p = Paragraph(['This is an example of a simple table. The table ' ...
      'is based upon the Word table style "AR_Table".'], 'AR_Normal');
   append(doc, p);
   
   tableData = reportData.(holeId);
   %The Table class constructor accepts a cell array which contains the
   %data we want to display. The complete table is automatically build for
   %us, based on the input data and the table style AR_Table, which is
   %defined in the Word template
   table = Table( tableData, 'AR_Table');
   append(doc, table);   
end

function processAdvancedTable(doc, reportData, holeId)
   %This function adds a table to our report, which is solely constructed
   %with DOM API commands
   import mlreportgen.dom.*
   
   %We add a new Level2 Heading before this table
   p = Paragraph('Complex Table Example', 'AR_Heading2');
   append(doc, p);
   %And some description
   p = Paragraph(['This is an example of an advanced table, which is ' ...
      'completely created with the DOM API.'], 'AR_Normal');
   append(doc, p);
   
   tableData = reportData.(holeId);
   numCol = size(tableData,2);
   numRow = size(tableData,1);
   %The FormalTable class allows us to build a complete table from scratch.
   %We need to provide the number of columns in the constructor
   table = FormalTable( numCol );
   %The table shall span the page width, so we set the attribute to 100%
   table.Width = '100%';

   %Now we need to create a TableRow object for each row we want to add.
   %This loop is for adding a table header which shall be displayed in bold
   row = TableRow();
   for nc=1:numCol
      %We create a Text for each colum in the header and make it bold
      textObj = Text(sprintf('Row %d', nc));
      textObj.Bold = true;      
      te = TableEntry( textObj );
      %Then a TableEntry is added to the TableRow for each column
      append(row, te );
   end
   %This row is appended to the table-header
   append(table.Header, row);
   
   %This loop fills the table body
   for nr=1:numRow
      row = TableRow();
      for nc=1:numCol
         te = TableEntry( tableData{nr,nc} );
         %The BackgroundColor of each TableEntry shall be filled with a
         %random color.
         bgColor = sprintf('#%x', randi(16777215));
         te.Style  = { BackgroundColor(bgColor) };
         te.VAlign = 'middle';
         append(row, te );
      end
      append(table.Body, row);
   end   
   append(doc, table);   
end

function processStandardHole(doc, reportData, holeId)
   import mlreportgen.dom.*
   
   %This function fills all holes that do not require a special handling.
   %The try/catch block performs an error handling in the case that there
   %is a mismatch between the hole-names in the template and the field-
   %names of the reportData-structure
   try
      data = reportData.(holeId);
   catch
      warning('Undefined Hole-Id: %s', holeId);
      data = 'undefined';
   end

   %Create a new text object and add it to the report
   t = Text(data);   
   append(doc, t);
end

