function [cond,x]=condensor(rankp,boil,rh,nrh)
cond=cell(2,3);
cond{1,1}='TEMPERATURE';
cond{1,2}='ENTHALPY';
cond{1,3}='ENTROPY';
cond{2,1}=XSteam('Tsat_p',rankp(:,1));
cond{2,2}(:,1)=XSteam('hL_p',rankp(:,1));
cond{2,3}(:,1)=XSteam('sL_p',rankp(:,1));
for i=1:size(nrh,1)
    if nrh(i)~=0
        cond{2,3}(i,2)=rh{2,3}(i,2*nrh(i));
    end
    if nrh(i)==0
        cond{2,3}(i,2)=boil{2,3}(i,2);
    end
end
%Cannot perform binary operations on cells, therfore had to convert cells
%to matrices
x=(cond{2,3}(:,2)-XSteam('sL_p',rankp(:,1)))./(XSteam('sV_p',rankp(:,1))-XSteam('sL_p',rankp(:,1)));
cond{2,2}(:,2)=XSteam('h_ps',rankp(:,1),cond{2,3}(:,2));

