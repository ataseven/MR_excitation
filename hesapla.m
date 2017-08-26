% hesapla.m: m-file for compuation part of EE519 Term Project, Step 1
%
% Phase angle is assumed to be the angle with the x' axis in cw direction as done 
% in the book
%
% Time variation plots of Mz and Mxy are started from M(0+), the period of
% RF field application is not shown in the plots. If needed, the commented lines
% in iterate.m must be uncommented.
% This may be useful, but the simulation will take longer,especially if Tp 
% is long compared to the time step.
%
% The formulation can be extended to include possible Bo directions (not only
% along z),but this is useless as the initial direction of the
% magnetization vector (which will be along Bo field) may always be defined
% as the z-axis direction

timeend=max([T1 T2]);    %used for simulation
timearray=linspace(0,2*timeend,1000); %increase # of steps (i.e.,200) for more accuracy
zamanadim=2*timeend/1000;
wo=gamma*Bo;    %precession frequency
w1=B1*gamma;    

[X Y]=meshgrid(-N/2*thickness:thickness:N/2*thickness,-N/2*thickness:thickness:N/2*thickness); %both X and Y are (N+1)x(N+1)
Z=(ones(N+1)*slice-N/2)*thickness;  %(N+1)x(N+1)

Mx=Mx*ones(N+1);        %(N+1)x(N+1)
My=My*ones(N+1);        %(N+1)x(N+1)
Mz=Mz*ones(N+1);        %(N+1)x(N+1)

Mzo=sqrt(Mx*Mx+My*My+Mz*Mz);    %Mzo is (N+1)x(N+1)


iterate         %calculate Mrot(0+) for RF in x-direction

Gxt=zeros(1,1000);
Gyt=zeros(1,1000);

if Gxdur1>0  
Gxt(round(Gxapp1/2/timeend*1000)+1:round((Gxapp1+Gxdur1)/2/timeend*1000))=Gxt(round(Gxapp1/2/timeend*1000)+1:round((Gxapp1+Gxdur1)/2/timeend*1000))+Gxamp1;
end
if Gxdur2>0  
Gxt(round(Gxapp2/2/timeend*1000)+1:round((Gxapp2+Gxdur2)/2/timeend*1000))=Gxt(round(Gxapp2/2/timeend*1000)+1:round((Gxapp2+Gxdur2)/2/timeend*1000))+Gxamp2;
end
if Gxdur3>0  
Gxt(round(Gxapp3/2/timeend*1000)+1:round((Gxapp3+Gxdur3)/2/timeend*1000))=Gxt(round(Gxapp3/2/timeend*1000)+1:round((Gxapp3+Gxdur3)/2/timeend*1000))+Gxamp3;
end
if Gxdur4>0  
Gxt(round(Gxapp4/2/timeend*1000)+1:round((Gxapp4+Gxdur4)/2/timeend*1000))=Gxt(round(Gxapp4/2/timeend*1000)+1:round((Gxapp4+Gxdur4)/2/timeend*1000))+Gxamp4;
end

if Gydur1>0  
    Gyt(round(Gyapp1/2/timeend*1000)+1:round((Gyapp1+Gydur1)/2/timeend*1000))=Gyt(round(Gyapp1/2/timeend*1000)+1:round((Gyapp1+Gydur1)/2/timeend*1000))+Gyamp1;
end
if Gydur2>0  
    Gyt(round(Gyapp2/2/timeend*1000)+1:round((Gyapp2+Gydur2)/2/timeend*1000))=Gyt(round(Gyapp2/2/timeend*1000)+1:round((Gyapp2+Gydur2)/2/timeend*1000))+Gyamp2;
end
if Gydur3>0  
    Gyt(round(Gyapp3/2/timeend*1000)+1:round((Gyapp3+Gydur3)/2/timeend*1000))=Gyt(round(Gyapp3/2/timeend*1000)+1:round((Gyapp3+Gydur3)/2/timeend*1000))+Gyamp3;
end
if Gydur4>0  
    Gyt(round(Gyapp4/2/timeend*1000)+1:round((Gyapp4+Gydur4)/2/timeend*1000))=Gyt(round(Gyapp4/2/timeend*1000)+1:round((Gyapp4+Gydur4)/2/timeend*1000))+Gyamp4;
end

h_grad = figure('Units','points', ...
	'Color',[1 1 1], ...
	'Name','EE 519 TERM PROJECT-- RF Gradients                                                                           Yoldas Ataseven', ...
	'NumberTitle','off', ...
	'Position',[165.75 74.35 561 465.5], ...
    'Pointer','arrow',...
	'Resize','off', ...
	'Tag','Fig1');
subplot(2,1,1)
plot(timearray,Gxt)
title('Gx')
subplot(2,1,2)
plot(timearray,Gyt)
title('Gy')

%angles for spatial transformation
alphay_prime=tilt-pi/2;
alphaz_prime=phase;

% spatial transformation matrices in rotating frame
Ry_prime=[cos(alphay_prime) 0 -sin(alphay_prime);0 1 0;sin(alphay_prime) 0 cos(alphay_prime)];  %3x3
Rz_prime=[cos(alphaz_prime) sin(alphaz_prime) 0 ; -sin(alphaz_prime) cos(alphaz_prime) 0 ; 0 0 1];  %3x3

Ry_minus=[cos(-alphay_prime) 0 -sin(-alphay_prime);0 1 0;sin(-alphay_prime) 0 cos(-alphay_prime)];  %3x3
Rz_minus=[cos(-alphaz_prime) sin(-alphaz_prime) 0;-sin(-alphaz_prime) cos(-alphaz_prime) 0;0 0 1];  %3x3

%calculate M(0+) for rotating frame concerning the filp and tilt angles
wait=waitbar(0,'processing...');
for i=1:N+1
    for j=1:N+1
        
        Mrot(i,j,:)=Rz_prime*Ry_prime*[Mx(i,j) My(i,j) Mz(i,j)]'; %Mrot(0+)
%-------!!!!!

% calculate M(0+) for lab framez
gecici(1)=Mrot(i,j,1);
gecici(2)=Mrot(i,j,2);
gecici(3)=Mrot(i,j,3);

M_lab(i,j,:)=[cos(wo*Tp) sin(wo*Tp) 0;-sin(wo*Tp) cos(wo*Tp) 0;0 0 1]*gecici'; %Mlab(0+)

%-----------------------------------------

Mxy_roto(i,j)=sqrt(Mrot(i,j,1)*Mrot(i,j,1)+Mrot(i,j,2)*Mrot(i,j,2)); %transverse component just after Rf pulse
%------!!!!!!

Mxy_rot(i,j,1)=Mrot(i,j,1)+sqrt(-1)*Mrot(i,j,2);%Mxy_roto(i,j);
Mxy_labo(i,j)=Mxy_rot(i,j,1)*exp(-sqrt(-1)*Tp*(wo+gamma*Gzamp*Z(i,j)));       %just after RF pulse
Mxy_lab(i,j,1)=Mxy_labo(i,j);

        for zaman=2:1000
            Mxy_rot(i,j,zaman)=Mxy_rot(i,j,zaman-1).*exp(-zamanadim/T2).*exp(zamanadim*sqrt(-1)*gamma.*(Gxt(zaman)*X(i,j)+Gyt(zaman)*Y(i,j)));             %transverse component
            %size(Mxy_rot);
            
            %-------!!!!!!
            
            Mxy_lab(i,j,zaman)=Mxy_lab(i,j,zaman-1).*exp(zamanadim.*(sqrt(-1).*(wo+gamma*(Gxt(zaman)*X(i,j)+Gyt(zaman)*Y(i,j)))-1/T2));            %transverse component     

        end
Mzt_lab(i,j,:)=Mzo(i,j).*(1-exp(-timearray/T1))+M_lab(i,j,3)*exp(-timearray/T1); %Mz(t) for lab frame
Mz_rot(i,j,:)=Mrot(i,j,3).*exp(-timearray/T1)+sqrt(Mz(i,j)^2+Mxy_roto(i,j)^2)*(1-exp(-timearray/T1)); %longitudinal component


Mrotx(i,j,:)=real(Mxy_rot(i,j,:));              %x component for rotating frame
Mroty(i,j,:)=imag(Mxy_rot(i,j,:));              %y component for rotating frame
%-------!!!!!!!

%----------------------------------------


Mlabx(i,j,:)=real(Mxy_lab(i,j,:));%M_lab(i,j,1).*exp(-timearray/T2-timearray*sqrt(-1)*wo);        % x component for lab frame
Mlaby(i,j,:)=imag(Mxy_lab(i,j,:));%M_lab(i,j,2).*exp(-timearray/T2-timearray*sqrt(-1)*wo);        % y component for lab frame
%------!!!!!!
    end
    waitbar(i/(N+1),wait)
end
close(wait)
%-------------------------------animation-------------------------
h_anim = figure('Units','points', ...
	'Color',[1 1 1], ...
	'Name','EE 519 TERM PROJECT                                                                                                Yoldas Ataseven', ...
	'NumberTitle','off', ...
	'Position',[165.75 74.35 561 465.5], ...
    'Pointer','arrow',...
	'Resize','off', ...
	'Tag','Fig1');
hndl_anim.ax = axes('Parent',h_anim, ...
	'Units','pixels', ...
	'CameraUpVector',[0 1 0], ...
	'CameraUpVectorMode','manual', ...
    'Visible','off',...
	'Color',[1 1 1], ...
	'Position',[97 85 556 472], ...
	'Tag','Axes1', ...
    'Xlim',[-5 5],...
	'Ylim',[-5 5],...
    'Zlim',[-5 5],...
    'XColor',[0 0 0], ...
	'YColor',[0 0 0], ...
	'ZColor',[0 0 0]);
hndl.slide = uicontrol('Parent',h_anim, ...
	'Units','points', ...
   'ListboxTop',0, ...
	'Position',[74.75 13 382.75 16.5], ...
	'SliderStep',[1/1000 1/100], ...
   'Style','slider', ...
   'Callback','b=round(get(gcbo,''Value'')*1000);set(txtacikla,''Visible'',''off'');ciz',...
   'Tag','Slider1');
txtacikla = uicontrol('Parent',h_anim, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'ListboxTop',0, ...
	'Position',[206.25 277.25 141.25 13.5], ...
	'String','USE THE SLIDER TO MOVE IN TIME', ...
	'Style','text', ...
	'Tag','StaticText1');
