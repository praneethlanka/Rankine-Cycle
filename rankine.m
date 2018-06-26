a=input('What all addons are there in the Cyclen\n1. Reheat\n2. Regenerative\n3. Both\n4. None\n');
rankp=xlsread('rankinecycle.xlsx','Rankine','d1:e1')';
boil=boiler(rankp);
if a==1
    [rh,nrh,rhdry]=reheat(boil);
    [cond,x]=condensor(rankp,a,0,rh,nrh);
end
if a==4
    [cond,x]=condensor(rankp,a,boil,0,0);
end   
%%Enthalpies at each point have been calculated
work=cell(2,2);
heat=cell(2,2);
heat{1,1}='BOILER';
heat{1,2}='REHEAT';
work{1,1}='PUMP';
work{1,2}='TURBINE';
if a==4
    twork=boil{2,2}(1,2)-cond{1,2}(1,2); work{2,2}= twork;
    pwork=XSteam('vL_p',rankp(1,1))*(rankp(2,1)-rankp(1,1))*10^5; work{2,1}=pwork;
    heat{2,1}=cell2mat(boil{2,2}(1,2))-cell2mat(boil{2,2}(1,1));
    eff=(twork-pwork)/heat{2,1};
    heatin=heat{2,1};
end
if a==1
    work{2,2}=zeros(nrh+1,1);
    work{2,2}(1,1)=boil{2,2}(1,2)-rh{2,2}(1,1);
    work{2,2}(2:end-1,1)=rh{2,2}(1:end-1,2)-rh{2,2}(2:end,1);
    work{2,2}(nrh+1,1)=rh{2,2}(end,2)-cond{1,2}(1,2);
    twork=sum(work{2,2});
    pwork=XSteam('vL_p',rankp(1,1))*(rankp(2,1)-rankp(1,1))*10^5; work{2,1}=pwork;
    heat{2,2}=sum(rh{2,2}(1:end,2)-rh{2,2}(1:end,1));
    heat{2,1}=boil{2,2}(1,2)-boil{2,2}(1,1);
    eff=(twork-pwork)/(heat{2,1}+heat{2,2});
    heatin=heat{2,1}+heat{2,2};
end
xlswrite('rankinecycle.xlsx',twork,'OUTPUT','C2');
xlswrite('rankinecycle.xlsx',pwork,'OUTPUT','E2');
xlswrite('rankinecycle.xlsx',heatin,'OUTPUT','C5');
xlswrite('rankinecycle.xlsx',eff,'OUTPUT','C8');
