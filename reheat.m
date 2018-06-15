function rhenth=reheat()
nrh=input('No. of reheat cycles?');
rhp=zeros(nrh,1);
rht=zeros(nrh,2);
rhent=zeros(nrh,1);
rhenth=zeros(nrh,2);
rhx=zeros(nrh,1);
for i=1:nrh
    rhp(i,1)=input('Enter pressure to which each cycle drops');        
    rht(i,1)=input('\nEnter the temp. before entering reheat''s boiler at each cycle');
    rht(i,2)=input('\nEnter the temp. after entering the reheat''s boiler at each cycle');
end
rhenth(:,1)=XSteam('h_pT',rhp(:,1),rht(:,1));  %% Calculates the enthaply at superheated points
rhenth(:,2)=XSteam('h_pT',rhp(:,1),rht(:,2));

    

   

