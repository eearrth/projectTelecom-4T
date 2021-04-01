function earfaifb8p16n10350 = per1_beam(filename, dataLines_start,dataLines_stop)
%IMPORTFILE Import data from a text file
%  EARFAIFB8P16N10350 = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the numeric data.
%
%  EARFAIFB8P16N10350 = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  earfaifb8p16n10350 = importfile("D:\workchalenge\VHF_radar\ear_faifb8p16n1_0350.txt", [2, 154]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 06-Sep-2020 17:56:09
dataLines=[dataLines_start, dataLines_stop];
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
opts.VariableNames = ["VarName1", "VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7", "VarName8", "VarName9", "VarName10"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Import the data
earfaifb8p16n10350 = readtable(filename, opts);

%% Convert to output type
earfaifb8p16n10350 = table2array(earfaifb8p16n10350);
end