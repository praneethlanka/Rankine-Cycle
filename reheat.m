function [rh,nrh,rhdry]=reheat(boil)
nrh=xlsread('rankinecycle.xlsx','Reheat');
if max(nrh)~=0
    rhp=xlsread('rankinecycle.xlsx','Reheat Pressure Drops');
    rhp(rhp==0 | isnan(rhp)==1)=50; %Dummy Value to avoid problems with XSteam
    rh{1,1}='TEMPERATURE';
    rh{1,2}='ENTHALPY';
    rh{1,3}='ENTROPY';
    rh{2,1}=xlsread('rankinecycle.xlsx','Reheat Temperatures'); % The reheat entry point is dictated by the boiler 
    rh{2,1}(rh{2,1}==0 | isnan(rh{2,1}))=50; % Dummy Value
    rh{2,3}=zeros(size(nrh,1),2*max(nrh));
    rh{2,2}=rh{2,3};
    rh{2,3}(rhp(:,1)~=50,1)=boil{2,3}(rhp(:,1)~=50,2);
    rh{2,3}(:,2:2:end)=XSteam('s_pT',rhp,rh{2,1});
    rh{2,3}(:,3:2:end)=rh{2,3}(:,2:2:end-1);
    ela=elementfinder(rh{2,3},-4.033604688162298e+17);
    ela(:,2)=ela(:,2)-1;
    rowa=ela(:,1);
    cola=ela(:,2);
    for i=1:size(rowa,1)
        rh{2,3}(rowa(i),cola(i))=-4.033604688162298e+17;
    end
    rhdry=(rh{2,3}(:,1:2:end)-XSteam('sL_p',rhp))./(XSteam('sV_p',rhp)-XSteam('sL_p',rhp));
    rhdry(abs(rhdry-1)<0.01)=1;
    rhdry(rhdry>1.01)=NaN;
    rhdry(rhdry<0)=-1;
    rhenthin=zeros(size(nrh,1),max(nrh));
    rhenthout=rhenthin;
    rhentin=rh{2,3}(:,1:2:end);
    rhenthin(rhp~=50)=XSteam('h_ps',rhp(rhp~=50),rhentin(rhp~=50));
    rhenthout(rhp~=50)=XSteam('h_pT',rhp(rhp~=50),rh{2,1}(rhp~=50));
    rh{2,2}(:,1:2:end)=rhenthin;
    rh{2,2}(:,2:2:end)=rhenthout;
    rh{2,3}(rh{2,3}<0)=-1;
end
if max(nrh)==0
    rh{2,3}=zeros(size(nrh,1),2);
    rh{2,2}=rh{2,3};
end
