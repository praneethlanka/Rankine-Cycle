function [rh,nrh,rhdry]=reheat(boil)
nrh=xlsread('rankinecycle.xlsx','Rankine','d8');
rhp=xlsread('rankinecycle.xlsx','Reheat(Pressure Drops)')';
rht=xlsread('rankinecycle.xlsx','Reheat(Temperatures)'); % The reheat entry point is dictated by the boiler 
rhent=zeros(nrh,2);                                     %pressure and 100% isentropic efficiency of turbines
rhent(:,2)=XSteam('s_pt',rhp,rht(:,2));
rhent(1,1)=boil{2,3}(1,2);
rhent(2:end,1)=rhent(1:end-1,2); %The entropies at the reheat entry points are calculated assuming
                                 %100% isentropic efficiencies
rhent1=rhent(:,1);   % THe entropy of the steam at each entry point is extracted 
rhenth=zeros(nrh,2);
sups=rhent1>XSteam('sV_p',rhp);  %They are checked for superheated, saturated, wet states
sat=rhent1-XSteam('sV_p',rhp);
wet=rhent1<XSteam('sV_p',rhp);
awet=elementfinder(wet,1);
asat=elementfinder(sat,1);
asup=elementfinder(sups,1);      %Corresponding states enthalpies are calculated using suitable XSteam
x=(rhent1(wet==1)-XSteam('sL_p',rhp(wet==1)))./(XSteam('sV_p',rhp(wet==1))-XSteam('sL_p',rhp(wet==1)));
rhdry(awet(:,1),1)=x(:,1);
rhdry(asat(:,1))=1;
rhdry(asup(:,1),1)=NaN;
rhenth(awet(:,1),1)=XSteam('hL_p',rhp(wet==1))+x.*(XSteam('hV_p',rhp(wet==1))-XSteam('hL_p',rhp(wet==1)));
rhenth(asat(:,1),1)=XSteam('hV_p',rhp(asat(:,1)));
rhenth(asup(:,1),1)=XSteam('h_ps',rhp(asup(:,1),1),rhent1(asup(:,1),1));
rhenth(:,2)=XSteam('h_pT',rhp,rht(:,2));
rh{1,1}='TEMPERATURE';
rh{1,2}='ENTHALPY';
rh{1,3}='ENTROPY';
rh{2,1}=rht;
rh{2,2}=rhenth;
rh{2,3}=rhent;