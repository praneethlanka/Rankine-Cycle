a=input('What all addons are there in the Cyclen\n1. Reheat\n2. Regenerative\n3. Both\n4. None');
rankp=zeros(2,1);
fprintf('Mulltiple inputs are to be given in the form of [a b c...]\n')
rankp(:,1)=input('Cycle operating between what pressures?');
boil=boiler(rankp);
if a==1
    [rh,nrh]=reheat();
    cond=condensor(rankp,a,0,rh);
end
if a==4
    cond=condensor(rankp,a,boil,0);
end
   
%%Enthalpies at each point have been calculated
work=cell(2,2);
work{1,1}='PUMP';
work{1,2}='TURBINE';
if a==4
    twork=boil{2,2}(1,2)-cond{1,2}(1,2); work{2,2}= twork;
    pwork=XSteam('vL_p',rankp(1,1))*(rankp(2,1)-rankp(1,1)); work{2,1}=pwork;
end

if a==1
    work{1,2}=zeros(nrh+1,1);
    work{1,2}(1,1)=boil{2,2}(1,2)-rh{2,2}(1,1);
    work{1,2}(1,2:(end-1))=rh{2,2}(1,2:end)-rh{2,2}(2:end,1);
    work{1,2}(1,end)=rh{2,2}(end,2)-cond{1,2}(1,2);
    twork=sum(work{1,2});
    pwork=XSteam('vL_p',rankp(1,1))*(rankp(2,1)-rankp(1,1)); work{2,1}=pwork;
end
