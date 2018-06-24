function cond=condensor(rankp,a,boil,rh)
cond=cell(2,3);
cond{1,1}='TEMPERATURE';
cond{1,2}='ENTHALPY';
cond{1,3}='ENTROPY';
cond{2,1}=XSteam('Tsat_p',input('Condensor operating at?'));
cond{2,2}(1,1)=XSteam('hL_p',rankp(1,1));
cond{2,3}{1,1}=XSteam('sL_p',rankp(1,1));
if a==1 || a==3
    cond{2,3}(1,2)=rh{2,3}(1,2);
end
if a==4||a==2
    cond{2,3}(1,2)=boil{2,3}(1,2);
end
    if cond{2,3}(1,2)<XSteam('sV_p',rankp(1,1))
        x=(cond{2,3}(1,2)-XSteam('sL_p',rankp(1,1)))/(XSteam('sV_p',rankp(1,1))-XSteam('sL_p',rankp(1,1)));
        cond{2,2}(1,2)=XSteam('hL_p',rankp(1,1))+(x*(XSteam('hV_p',rankp(1,1))-XSteam('hL_p',rankp(1,1))));
    end
    if cond{2,3}(1,2)==XSteam('sV_p',rankp(1,1))
        cond{2,2}(1,2)=XSteam('hV_p',rankp(1,1));
    end
    if cond{2,3}(1,2)>XSteam('sV_p',rankp(1,1))
        cond{2,2}(1,2)=XSteam('h_ps',rankp(1,1),cond{2,3}(1,2));
    end
   