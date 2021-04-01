function [lat_new1,lat_new2,lon_new1,lon_new2] = newlatlon(alt1,alt2,pern1,pern2)
%NEWLATLON Summary of this function goes here
%   Detailed explanation goes here
lat_new1.b1                                     =nan(alt1.row,alt1.col);
lat_new1.b2                                     =nan(alt1.row,alt1.col);
lat_new1.b3                                     =nan(alt1.row,alt1.col);
lat_new1.b4                                     =nan(alt1.row,alt1.col);
lat_new1.b5                                     =nan(alt1.row,alt1.col);
lat_new1.b6                                     =nan(alt1.row,alt1.col);
lat_new1.b7                                     =nan(alt1.row,alt1.col);
lat_new1.b8                                     =nan(alt1.row,alt1.col);

lat_new2.b1                                     =nan(alt2.row,alt2.col);
lat_new2.b2                                     =nan(alt2.row,alt2.col);
lat_new2.b3                                     =nan(alt2.row,alt2.col);
lat_new2.b4                                     =nan(alt2.row,alt2.col);
lat_new2.b5                                     =nan(alt2.row,alt2.col);
lat_new2.b6                                     =nan(alt2.row,alt2.col);
lat_new2.b7                                     =nan(alt2.row,alt2.col);
lat_new2.b8                                     =nan(alt2.row,alt2.col);

lon_new1.b1                                     =nan(alt1.row,alt1.col);
lon_new1.b2                                     =nan(alt1.row,alt1.col);
lon_new1.b3                                     =nan(alt1.row,alt1.col);
lon_new1.b4                                     =nan(alt1.row,alt1.col);
lon_new1.b5                                     =nan(alt1.row,alt1.col);
lon_new1.b6                                     =nan(alt1.row,alt1.col);
lon_new1.b7                                     =nan(alt1.row,alt1.col);
lon_new1.b8                                     =nan(alt1.row,alt1.col);

lon_new2.b1                                     =nan(alt2.row,alt2.col);
lon_new2.b2                                     =nan(alt2.row,alt2.col);
lon_new2.b3                                     =nan(alt2.row,alt2.col);
lon_new2.b4                                     =nan(alt2.row,alt2.col);
lon_new2.b5                                     =nan(alt2.row,alt2.col);
lon_new2.b6                                     =nan(alt2.row,alt2.col);
lon_new2.b7                                     =nan(alt2.row,alt2.col);
lon_new2.b8                                     =nan(alt2.row,alt2.col);

%%% for beam 1 in n = 1


    for ii = 1:alt1.col
        [~,idx]                                             =min(abs(pern1.beam1(:,2)-alt1.hight(1,(ii))));
        lat_new1.b1(:,ii)                      =pern1.beam1(idx,8) ;
        lon_new1.b1(:,ii)                     =pern1.beam1(idx,9);
    end

    for ii = 1:alt1.col
        [~,idx]                                             =min(abs(pern1.beam1(:,2)-alt1.hight(2,(ii))));
        lat_new1.b2(:,ii)                      =pern1.beam2(idx,8) ;
        lon_new1.b2(:,ii)                     =pern1.beam2(idx,9);
    end
        for ii = 1:alt1.col
        [~,idx]                                             =min(abs(pern1.beam1(:,2)-alt1.hight(3,(ii))));
        lat_new1.b3(:,ii)                      =pern1.beam3(idx,8) ;
        lon_new1.b3(:,ii)                     =pern1.beam3(idx,9);
        end
        for ii = 1:alt1.col
        [~,idx]                                             =min(abs(pern1.beam1(:,2)-alt1.hight(4,(ii))));
        lat_new1.b4(:,ii)                      =pern1.beam4(idx,8) ;
        lon_new1.b4(:,ii)                     =pern1.beam4(idx,9);
        end
        for ii = 1:alt1.col
        [~,idx]                                             =min(abs(pern1.beam1(:,2)-alt1.hight(5,(ii))));
        lat_new1.b5(:,ii)                      =pern1.beam5(idx,8) ;
        lon_new1.b5(:,ii)                     =pern1.beam5(idx,9);
        end
        for ii = 1:alt1.col
        [~,idx]                                             =min(abs(pern1.beam1(:,2)-alt1.hight(6,(ii))));
        lat_new1.b6(:,ii)                      =pern1.beam6(idx,8) ;
        lon_new1.b6(:,ii)                     =pern1.beam6(idx,9);
        end
        for ii = 1:alt1.col
        [~,idx]                                             =min(abs(pern1.beam7(:,2)-alt1.hight(7,(ii))));
        lat_new1.b7(:,ii)                      =pern1.beam7(idx,8) ;
        lon_new1.b7(:,ii)                     =pern1.beam7(idx,9);
        end
        for ii = 1:alt1.col
        [~,idx]                                             =min(abs(pern1.beam8(:,2)-alt1.hight(8,(ii))));
        lat_new1.b8(:,ii)                      =pern1.beam8(idx,8) ;
        lon_new1.b8(:,ii)                     =pern1.beam8(idx,9);
        end
    for ii = 1:alt2.col
        [~,idx]                                             =min(abs(pern2.beam1(:,2)-alt2.hight(1,(ii))));
        lat_new2.b1(:,ii)                      =pern2.beam1(idx,8) ;
        lon_new2.b1(:,ii)                     =pern2.beam1(idx,9);
    end

    for ii = 1:alt2.col
        [~,idx]                                             =min(abs(pern2.beam1(:,2)-alt2.hight(2,(ii))));
        lat_new2.b2(:,ii)                      =pern2.beam2(idx,8) ;
        lon_new2.b2(:,ii)                     =pern2.beam2(idx,9);
    end
        for ii = 1:alt2.col
        [~,idx]                                             =min(abs(pern2.beam1(:,2)-alt2.hight(3,(ii))));
        lat_new2.b3(:,ii)                      =pern2.beam3(idx,8) ;
        lon_new2.b3(:,ii)                     =pern2.beam3(idx,9);
        end
        for ii = 1:alt2.col
        [~,idx]                                             =min(abs(pern2.beam1(:,2)-alt2.hight(4,(ii))));
        lat_new2.b4(:,ii)                      =pern2.beam4(idx,8) ;
        lon_new2.b4(:,ii)                     =pern2.beam4(idx,9);
        end
        for ii = 1:alt2.col
        [~,idx]                                             =min(abs(pern2.beam1(:,2)-alt2.hight(5,(ii))));
        lat_new2.b5(:,ii)                      =pern2.beam5(idx,8) ;
        lon_new2.b5(:,ii)                     =pern2.beam5(idx,9);
        end
        for ii = 1:alt2.col
        [~,idx]                                             =min(abs(pern2.beam1(:,2)-alt2.hight(6,(ii))));
        lat_new2.b6(:,ii)                      =pern2.beam6(idx,8) ;
        lon_new2.b6(:,ii)                     =pern2.beam6(idx,9);
        end
        for ii = 1:alt2.col
        [~,idx]                                             =min(abs(pern2.beam7(:,2)-alt2.hight(7,(ii))));
        lat_new2.b7(:,ii)                      =pern2.beam7(idx,8) ;
        lon_new2.b7(:,ii)                     =pern2.beam7(idx,9);
        end
        for ii = 1:alt2.col
        [~,idx]                                             =min(abs(pern2.beam8(:,2)-alt2.hight(8,(ii))));
        lat_new2.b8(:,ii)                      =pern2.beam8(idx,8) ;
        lon_new2.b8(:,ii)                     =pern2.beam8(idx,9);
        end    



















































end

