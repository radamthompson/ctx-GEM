function [ MuSurface ] = plotATPsurf( MuSurface, figName )
%plotATPsurf Generate 3D plot of ATP requirements
%   For plotting without running generate3wayATP.m again
%
%
% R. Adam Thompson
% Trinh Lab
% University of Tennessee, Knoxville
% rthomp46@utk.edu
%
% Created: Aug 6, 2015
% Last edit: Aug 10, 2015

GAMArray = [0:1:50];
CellArray = [40:1:90];

figure
surf(CellArray,GAMArray,MuSurface)

ylabel('GAM ATP Req.');
xlabel('Cellulosome ATP Req.');
zlabel('Specific growth rate \mu (hr^{-1})');
ylim([0 50]);
xlim([40 90]);
zlim([0 0.5]);
set(gca,'Ydir','reverse')

set(findall(gcf,'type','text'),'fontSize',16)
fp = fillPage(gcf, 'margins', [0 0 0 0], 'papersize', [8.5 8.5]);


print (gcf,'-dpdf','-r300',figName);

end

