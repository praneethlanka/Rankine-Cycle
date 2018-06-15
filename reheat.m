function [rhenth,rhent]=reheat()
nrh=input('No. of reheat cycles?');
rhp=zeros(nrh,1);
rht=zeros(nrh,2);
rhenth=zeros(nrh,2);
for i=1:nrh
    rhp(i,1)=input('Enter pressure to which each cycle drops');        
    rht(i,1)=input('ENter the tmeperature before entering the reheat');
    rht(i,2)=input('\nEnter the temp. after entering the reheat''s boiler at each cycle');
end
%Next line checks for superheated temperatures at the reheat's inlet and
%returns 1 if it is superheated and 0 if steam is either dry saturated or in wet state. 
rhsuph=abs(rht(:,1)-XSteam('Tsat_p',rhp(:,1)))>0.2;
%If the temperature entered by the user is close to Saturation temperature
%to a tolerance of 0.2 then it rounds it off to Saturation temperature
rht(rht-XSteam('Tsat_p',rhp)<0.2)=XSteam('Tsat_p',rhp(rht-XSteam('Tsat_p',rhp)<0.2));
% Elementfinder returns the position of the 2nd argument of the function in
% the 1st Argument( A matrix)
%This line returns at what inlet is the steam is in superheated state.
%Initially the user does not know where the steam is superheated
a=elementfinder(rhsuph,1);
%The enthalpy's at the superheated states(if any) are calculated in this
%line. Matrix indexing is done in such a way that the pressure and
%temperature inputs are in correspondence with the superheated states.
rhenthsup=XSteam('h_pT',rhp(rhsuph==1),rht(rhsuph==1));
% Finally the enthalpies of all the states are added into suitable
% post=itions of the rhenth matrix with the help of output from the
% variable a
rhenth(a(:,1),1)=rhenthsup(:,1);
b=elementfinder(rhsuph,0);
rhenth(b(:,1),1)=XSteam('hV_p',rhp(rhsuph==0));
rhenth(:,2)=XSteam('h_pT',rhp,rht(:,2));
rhent=XSteam('s_pT',rhp(nrh-1,1),rht(nrh-1,2));














% rhenth(:,3)=XSteam('h_pT',rhp(:,1),rht(:,2)); %Returns enthalpy of superheated steam
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
    

        

