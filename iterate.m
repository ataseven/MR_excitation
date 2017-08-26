%iterate.m: Calculates the excitation for an arbitrary inital magnetization
%           vector in the rotating frame for both on-resonance and
%           off-resonance conditions.Takes no input arguments, returns
%           nothing. This file may be thought to be a module of hesapla.m
%
%   This function calculates the magnetization vector (for an RF field in x-direction) just after the
%   applied RF field using the governing differential equation. The effect of angles theta and fi are inserted in hesapla.m.
%   The d.e. is implemented iteratively during Tp, the RF field application period.
%
%   If you want to view the magnetization vector during the RF field application, uncomment all of the comments below.
%   Note that the axes' orientation will appear to be different than the
%   plots of the main function.


timestep=1e-6;

wo2=wo+gamma*Gzamp*Z;
    
delta_w=wo2-w;    
time=timestep;
B11=B1*ones(N+1,N+1);
i=1;
%figure,
while time<=Tp
    Mx=Mx+timestep*delta_w(:,:).*My;
    My=My-timestep*(delta_w(:,:).*Mx-gamma*B11(:,:).*Mz);
    Mz=Mz-timestep*gamma*B11(:,:).*My;
    time=time+timestep;
    i=i+1;
    %campos([N/2*thickness-1 N/2*thickness+1 N/2*thickness-1 N/2*thickness+1 N/2*thickness-1 N/2*thickness+1])
    %quiver3(X,Y,Z,Mx,My,Mz);
    %grid,
    %axis([N/2*thickness-1 N/2*thickness+1 N/2*thickness-1 N/2*thickness+1 N/2*thickness-1 N/2*thickness+1])
    %xlabel('x''')
    %ylabel('y''')
    %zlabel('z''')
    %pause(0.01)
end
%close

