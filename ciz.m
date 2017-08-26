if b==0
    b=1;
end
if tercih==0                % Animate for rotating frame
    subplot(hndl_anim.ax)
    campos([5 7 5])
 
        subplot(hndl_anim.ax)
        quiver3(X,Y,Z,Mrotx(:,:,b),Mroty(:,:,b),Mz_rot(:,:,b));
        xlabel('x''')
        ylabel('y''')
        zlabel('z''')
        text(4.5,-5,3.7,['time (s):' num2str(2*timeend*b/1000)])
        title('Rotating frame')
        %hold on,
        %fill3([-5 5 5 -5],[-5 -5 5 5],[Z(1,1) Z(1,1) Z(1,1) Z(1,1)],'g')
        %plot3([0 0],[0 0],[-10 10],'r:');
        %hold off,
        grid on,
        set(hndl_anim.ax,'Xlim',[-N/2*thickness-1,N/2*thickness+1],'Ylim',[-N/2*thickness-1,N/2*thickness+1],'Zlim',[-N/2*thickness-1,N/2*thickness+1])
        if transverse==1
            campos([0 0 N/2*thickness+1])
        end
%        pause
        set(h_anim,'Pointer','arrow');
        
end

if tercih==1               % Animate for lab frame
    subplot(hndl_anim.ax)
    campos([5 7 5])
    
        subplot(hndl_anim.ax)
        quiver3(X,Y,Z,real(Mxy_lab(:,:,b)),imag(Mxy_lab(:,:,b)),Mzt_lab(:,:,b));
        xlabel('x')
        ylabel('y')
        zlabel('z')
        text(4.5,-5,3.7,['time (s):' num2str(2*timeend*b/1000)])
        title('Laboratory frame')
        %hold on,
        %fill3([-5 5 5 -5],[-5 -5 5 5],[Z(1,1) Z(1,1) Z(1,1) Z(1,1)],'g')
        %plot3([0 0],[0 0],[-10 10],'r:');
        %hold off,
        grid on,
        set(hndl_anim.ax,'Xlim',[-N/2*thickness-1,N/2*thickness+1],'Ylim',[-N/2*thickness-1,N/2*thickness+1],'Zlim',[-N/2*thickness-1,N/2*thickness+1])
        subplot(hndl_anim.ax)
        if transverse==1;
            campos([0 0 N/2*thickness+1])
        end
        %pause
        set(h_anim,'Pointer','arrow');
       
end

