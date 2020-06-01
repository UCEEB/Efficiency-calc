function data = import_files( filename1, filename2, granularity)
%IMPORT Imports files and merge them into useable matrix of data
%
% 1 Datalog20200519145647063 (replace ',' -> '.' first)
% 2 gw106500euro
%
% granularity = smallest time piece to count with (optional, defualt =
% seconds)
%

if nargin < 3
    granularity = 1/24/60/60; %seconds
end

%% Load files
data1 = importfile1(filename1);
data2 = importfile2(filename2);

%% Combine time vectors
time1 = datenum(data1.TIMESTAMP,'dd.mm.yyyy HH:MM:SS.FFF');
time2 = datenum(data2.tsnorm1G1Narrow,'yyyy-mm-dd HH:MM:SS.FFF');

data.time = ( max( time1(1), time2(1) ) : granularity : min( time1(end), time2(end) ) )';
data.datetime = datetime( data.time, 'ConvertFrom', 'datenum');

data.CH1RMSW = interp1( time1, data1.CH1RMSW, data.time );
data.CH1MPPW = interp1( time1, data1.CH1MPPW, data.time );
data.CH1MPP = interp1( time1, data1.CH1MPP, data.time );

data.p1G2NarrowW = interp1( time2, data2.p1G2NarrowW, data.time );
data.p_SUMG1NarrowW = interp1( time2, data2.p_SUMG1NarrowW, data.time );


end




