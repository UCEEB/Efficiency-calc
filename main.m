%% Process CSN 50530 
% Read measurements from files, calculate efficiency in 3 lines.
%
%
% author = Vladislav.Martinek@cvut.cz
% author = Vaclav.Zelenka@cvut.cz
%
% rename or read as csv

filename1 = 'C:\HOME\Èeské vysoké uèení technické v Praze\Team-PV Accu - Documents\Zpracování ÈSN 50530\GW10 6500Wnom\Data log 2020-05-19-14-56-47-063.txt';
filename2 = 'C:\HOME\Èeské vysoké uèení technické v Praze\Team-PV Accu - Documents\Zpracování ÈSN 50530\GW10 6500Wnom\gw10-6500euro.csv';

levels = [ 0.05; 0.1; 0.2; 0.25; 0.3; 0.5; 0.75; 1 ];


data = import_files( filename1, filename2 );

% valid = abs(data.diff - median(data.diff)) < median(data.diff)/20;

%% Prepare valid data
magic = 20;
limit = 5;
grad1 = gradient(data.p1G2NarrowW);
grad2 = gradient(data.p_SUMG1NarrowW);
valid = ( abs(grad1 - median(grad1)) < limit );
valid(1) = false;

%% Extract levels
h = histogram(data.p1G2NarrowW(valid), 'BinMethod', 'sqrt');
t = topkrows(h.Values', numel(levels));
e = h.BinEdges( h.Values >= t(end) );

% select data corresponding to expected levels
select = false( numel(data.time), numel(levels) );
% plot to check selected
figure; hold on;
plot( data.datetime, data.p1G2NarrowW, '.');
for i = 1 : numel(levels)
    select(:,i) = ( data.p1G2NarrowW > e(i) ) & ( data.p1G2NarrowW < ( e(i) + h.BinWidth ) ) & valid ;
    % select can contain holes - fill them
    tmp = find(select(:,i));
    select(:,i) = [ zeros(tmp(1)-1,1); ones(tmp(end)-tmp(1)+1,1); zeros(size(select(:,i), 1)-tmp(end),1) ];
    plot(data.datetime( select(:,i) ), data.p1G2NarrowW( select(:,i) ), 'o')
end
legend( [ "original"; num2str(levels) ] );


%% Calculate average at levels
conversion_eff = data.p_SUMG1NarrowW ./ data.p1G2NarrowW;
valid = ~( isnan(conversion_eff) | isinf(conversion_eff) );

ceff = zeros( numel(levels), 1 );

for i = 1 : numel(levels)
    ceff(i) = mean( conversion_eff( valid & select(:,i) ) );
end

% European efficiency
euro = 0.03*ceff(1) + 0.06*ceff(2) + 0.13*ceff(3) + 0.1*ceff(5) + 0.48*ceff(6) + 0.2*ceff(8);

% CEC efficiency
cec = 0.04*ceff(2) + 0.05*ceff(3) + 0.12*ceff(5) + 0.21*ceff(6) + 0.53*ceff(7) + 0.05*ceff(8);






% figure; hold on; plot( data.datetime(valid), data.CH1MPPW(valid), '.');
% plot( data.datetime(valid), data.p1G2NarrowW(valid), 'x');
% plot( data.datetime(valid), abs(data.p_SUMG1NarrowW(valid)), 'o');