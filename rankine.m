profile on
rankp=xlsread('rankinecycle.xlsx','Rankine Pressures');
boil=boiler(rankp);
[rh,nrh,rhdry]=reheat(boil);
[cond,x]=condensor(rankp,boil,rh,nrh);
rhenthin=rh{2,2}(:,1:2:end);
rhenthout=rh{2,2}(:,2:2:end);
rhheat=sum(rh{2,2}(:,2:2:end)-rh{2,2}(:,1:2:end),2); % Heat added in Reheat Cycles
boilheat=boil{2,2}(:,2)-boil{2,2}(:,1); %Heat added at all cases in boiler
heat=rhheat+boilheat;
rhlowturbwork=zeros(size(nrh,1),1);
rhhighturbwork=rhlowturbwork;
for i=1:size(nrh,1)
    if max(nrh)~=0
        for j=1:max(nrh)-1
            if rhenthout(i,j+1)~=0
                rhlowturbwork(i,1)=rhlowturbwork(i,1)+(rhenthout(i,j)-rhenthin(i,j+1));
            end
        end
    end
    if nrh(i)~=0
        rhhighturbwork(i,1)=rh{2,2}(i,2*nrh(i))-boil{2,2}(i,2);
    end
end
x(x>1)=NaN;
boilwork=zeros(size(nrh,1),1);
boilwork(nrh==0,1)=boil{2,2}(nrh==0,2)-cond{2,2}(nrh==0,2); %Heat Added in 
twork=boilwork+rhhighturbwork+rhlowturbwork;
pwork=boil{2,2}(:,1)-cond{2,2}(:,1);
eff=((twork-pwork)./heat)*100;
subplot(2,1,1)
plot(rankp(:,1),eff);
xlabel('Condensor Pressure');
ylabel('Efficiency (in %)');
subplot(2,1,2)
plot(rankp(:,2),eff);
xlabel('Boiler Pressure');
ylabel('Efficiency (in %)');
xlswrite('rankinecycle.xlsx',twork,'OUTPUT','A');
xlswrite('rankinecycle.xlsx',pwork,'OUTPUT','C');
xlswrite('rankinecycle.xlsx',heat,'OUTPUT','E');
xlswrite('rankinecycle.xlsx',eff,'OUTPUT','G');
