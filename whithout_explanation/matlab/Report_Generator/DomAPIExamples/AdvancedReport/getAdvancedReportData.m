function data = getAdvancedReportData
%ADVANCEDREPORTDATA Defines an Interface between the report creation
%   function and the data that shall be displayed in the report
%   The function fills a struct where every structure field corresponds
%   to a hole name in the Word template.
%   Copyright 2016 - 2016 The MathWorks, Inc.

   data.Title    = 'Advanced Report';
   data.SubTitle = 'An example by:';
   data.Author   = getenv('username');
   data.Image    = fullfile(pwd, 'Image.png');
   
   data.SimpleTable   = getTableData;
   data.AdvancedTable = getTableData;
   
   data.Text = evalc('why');

end

function table = getTableData
   %This function uses the MATLAB function "why", which returns a different
   %random sentence everytime it is called. This sentence is then transformed
   %into a 3-by-n cell array, to represent our table data
   
   numCol = 3;
   %Why has no return value, so we need to capture the output with evalc
   randomString = evalc('why');
   %Remove the last carriage return
   randomString(end) = [];
   %Split the string at each space to get a cell array
   cellString = strsplit(randomString, ' ');
   le = length(cellString);   
   if mod(le, numCol) ~= 0
      %If the length is not a multiple of three, we need to add empty elements
      numElementsToAdd = numCol*(floor(le/numCol)+1) - le;
      cellString = [cellString repmat({''},1,numElementsToAdd)];
   end
   %Reshape the cell array into a 3-by-n cell array
   table = reshape(cellString, [numCol, length(cellString)/3])';   
end

