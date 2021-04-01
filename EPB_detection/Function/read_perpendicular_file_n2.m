function earfaifb8p16n20350 = read_perpendicular_file_n2(filename,main_path)
%IMPORTFILE Import data from a text file
%  EARFAIFB8P16N20350 = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the numeric data.
%
%  EARFAIFB8P16N20350 = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  earfaifb8p16n20350 = importfile("D:\workchalenge\VHF_radar\ear_faifb8p16n2_0350.txt", [2, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 04-Sep-2020 19:36:43
dataLines = [2, Inf];
%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [2, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 10);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["VarName1", "VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7", "Var8", "Var9", "Var10"];
opts.SelectedVariableNames = ["VarName1", "VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "string", "string", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Specify variable properties
opts = setvaropts(opts, ["Var8", "Var9", "Var10"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var8", "Var9", "Var10"], "EmptyFieldRule", "auto");

% Import the data
cd(main_path)
earfaifb8p16n20350 = readtable(filename, opts);

%% Convert to output type
earfaifb8p16n20350 = table2array(earfaifb8p16n20350);
end