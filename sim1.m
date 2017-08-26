set(h0,'Pointer','arrow');

Gxapp1=str2num(get(editGxapp1,'String'));
Gxamp1=str2num(get(editGxamp1,'String'));
Gxdur1=str2num(get(editGxdur1,'String'));

Gxapp2=str2num(get(editGxapp2,'String'));
Gxamp2=str2num(get(editGxamp2,'String'));
Gxdur2=str2num(get(editGxdur2,'String'));

Gxapp3=str2num(get(editGxapp3,'String'));
Gxamp3=str2num(get(editGxamp3,'String'));
Gxdur3=str2num(get(editGxdur3,'String'));

Gxapp4=str2num(get(editGxapp4,'String'));
Gxamp4=str2num(get(editGxamp4,'String'));
Gxdur4=str2num(get(editGxdur4,'String'));

Gyapp1=str2num(get(editGyapp1,'String'));
Gyamp1=str2num(get(editGyamp1,'String'));
Gydur1=str2num(get(editGydur1,'String'));

Gyapp2=str2num(get(editGyapp2,'String'));
Gyamp2=str2num(get(editGyamp2,'String'));
Gydur2=str2num(get(editGydur2,'String'));

Gyapp3=str2num(get(editGyapp3,'String'));
Gyamp3=str2num(get(editGyamp3,'String'));
Gydur3=str2num(get(editGydur3,'String'));

Gyapp4=str2num(get(editGyapp4,'String'));
Gyamp4=str2num(get(editGyamp4,'String'));
Gydur4=str2num(get(editGydur4,'String'));

Gzamp=str2num(get(editGzamp,'String'));

Gxamp1=Gxamp1*1E-6;   % conver to uT
Gxamp2=Gxamp2*1E-6;   % conver to uT
Gxamp3=Gxamp3*1E-6;   % conver to uT
Gxamp4=Gxamp4*1E-6;   % conver to uT

Gyamp1=Gyamp1*1E-6;   % conver to uT  
Gyamp2=Gyamp2*1E-6;   % conver to uT
Gyamp3=Gyamp3*1E-6;   % conver to uT
Gyamp4=Gyamp4*1E-6;   % conver to uT

Gzamp=Gzamp*1E-6;   % conver to uT

Gxapp1=Gxapp1/1000;   % conver to ms
Gxapp2=Gxapp2/1000;   % conver to ms
Gxapp3=Gxapp3/1000;   % conver to ms
Gxapp4=Gxapp4/1000;   % conver to ms

Gyapp1=Gyapp1/1000;   % conver to ms
Gyapp2=Gyapp2/1000;   % conver to ms
Gyapp3=Gyapp3/1000;   % conver to ms
Gyapp4=Gyapp4/1000;   % conver to ms

Gxdur1=Gxdur1/1000;   % conver to ms
Gxdur2=Gxdur2/1000;   % conver to ms
Gxdur3=Gxdur3/1000;   % conver to ms
Gxdur4=Gxdur4/1000;   % conver to ms

Gydur1=Gydur1/1000;   % conver to ms
Gydur2=Gydur2/1000;   % conver to ms
Gydur3=Gydur3/1000;   % conver to ms
Gydur4=Gydur4/1000;   % conver to ms

N=str2num(get(editN,'String'));
slice=round(str2num(get(editslice,'String')));
thickness=str2num(get(editthickness,'String'));

Mx=str2num(get(editMx,'String'));   %in the rotating frame
My=str2num(get(editMy,'String'));
Mz=str2num(get(editMz,'String'));

Bo=str2num(get(editBo,'String'));

gamma=str2num(get(editgamma,'String'));
gamma=gamma*1000000;                        %Convert to MHz

B1=str2num(get(editB1,'String'));
B1=B1*0.000001;                             %convert to Tesla


w=1000000*str2num(get(editw,'String'));

Tp=str2num(get(editTp,'String'));
Tp=Tp*0.001;                                %convert to seconds

phase=str2num(get(editphase,'String'));
tilt=str2num(get(edittilt,'String'));

T1=str2num(get(editT1,'String'));
T1=T1*0.001;                                %convert to seconds

T2=str2num(get(editT2,'String'));
T2=T2*0.001;                                %convert to seconds

tilt=tilt*pi/180;                           %convert to radians
phase=phase*pi/180;                         %conver to radians

Gymax=max([Gyapp1+Gydur1 Gyapp2+Gydur2 Gyapp3+Gydur3 Gyapp4+Gydur4 ]);
Gxmax=max([Gxapp1+Gxdur1 Gxapp2+Gxdur2 Gxapp3+Gxdur3 Gxapp4+Gxdur4 ]);

if T1<T2 | slice>N | Gxmax>2*max(T1,T2) | Gymax>2*max(T1,T2) | slice <1
    if T1<T2
        errordlg('Choosing T1>T2 will result false simulation results')
    end
    if slice>N | slice <1
        errordlg(['Please choose an aprropriate slice number (a positive integer smaller than or equal to ' num2str(N) ')'])
    end
    if Gxmax>2*max(T1,T2) | Gymax>2*max(T1,T2)
        errordlg(['Applied gradient(s) must vanish before t=' num2str(2*max(T1,T2)) 'ms'])    
    end
else
hesapla;
end
set(h0,'Pointer','arrow');