nrh=input('No. of reheat cycles?');
rhp=zeros(nrh,1);
rht=zeros(nrh,2);
rhent=zeros(nrh,1);
rhenth=zeros(nrh,3);
rhx=zeros(nrh,1);
for i=1:nrh
    rhp(i,1)=input('Enter pressure to which each cycle drops');        
    rht(i,1)=input('ENter the tmeperature before entering the reheat');
    %Checks if the temperature entered is close to Saturation temp
    % If it is close it assigns saturationtemperature at that point.
    if abs(rht(i,1)-XSteam('Tsat_p',rhp(i,1)))<0.2  
        rht(i,1)=XSteam('Tsat_p',rhp(i,1));
        rhenth(i,1)=XSteam('h_pT',rhp(i,1),rht(i,1));
    end
    if abs(rht(i,1)-XSteam('Tsat_p',rhp(i,1)))>0.2
        rhenth(i,2)=XSteam('h_pT',rhp(i,1),rht(i,1));
    end
    rht(i,2)=input('\nEnter the temp. after entering the reheat''s boiler at each cycle');
end
rhenth(:,3)=XSteam('h_pT',rhp(:,1),rht(:,2)); %Returns enthalpy of superheated steam
% rhsuph=rht(:,1)>XSteam('Tsat_p',rhp(:,1)); % Ensures if the temp. before entering reheat is saturated or not
%                                             % Returns 1 if it is
%                                             % superheated and 0 if normal
% rhtsuph=rht(rhsuph==1); % Seperates out the temperatures which are 
% rhtsat=rht(rhsuph==0);
% 
% rhenth(:,2)=XSteam('h_pT',rhp(:,1),rhtsuph(1,:));
% if rhsuph(:,1)==1
%     rhenth(:,1)=XSteam('h_pT',rhp(:,1),rht(:,1));  %% Calculates the enthaply at superheated points
% end
% 
% % What to do with ) Values
% if rhsuph(:,1)==0
%     rhent(:,1)=XSteam('s_pT',rhp(:,1),rht(:,1));
%     rhx(:,1)=(rhent(:,1)-XSteam('sL_p',p))./(XSteam(s
% end
%     
    

        

