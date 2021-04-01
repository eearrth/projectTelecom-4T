function solarpast = importfile(filename,d_path,m_path)
%IMPORTFILE Import data from a text file
%  SOLARPAST = IMPORTFILE(FILENAME) reads data from text file FILENAME
%  for the default selection.  Returns the data as a table.
%
%  SOLARPAST = IMPORTFILE(FILE, DATALINES) reads data for the specified
%  row interval(s) of text file FILENAME. Specify DATALINES as a
%  positive scalar integer or a N-by-2 array of positive scalar integers
%  for dis-contiguous row intervals.
%
%  Example:
%  solarpast = importfile("D:\workchalenge\TECcal\Data_solar\solar_past.txt", [1, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 06-Oct-2020 16:38:44
 cd(d_path)
dataLines = [1, Inf];
%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [1, Inf];
end

%% Setup the Import Options and import the data
opts = fixedWidthImportOptions("NumVariables", 17);

% Specify range and variable widths
opts.DataLines = dataLines;
opts.VariableWidths = [4, 4, 3, 6, 6, 6, 6, 6, 6, 6, 6, 6, 3, 4, 6, 6, 9];

% Specify column names and types
opts.VariableNames = ["VarName1", "VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7", "VarName8", "VarName9", "VarName10", "VarName11", "VarName12", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
solarpast = readtable(filename, opts);
solarpast = table2array(solarpast);
 cd(m_path)
end