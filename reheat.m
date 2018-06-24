function [rh,nrh]=reheat()
nrh=input('No. of reheat cycles?');
rhp=zeros(nrh,1);
rht=zeros(nrh,2);
rhenth=zeros(nrh,2);
fprintf('Mulltiple inputs are to be given in the form of [a b c...]\n')
rhp(:,1)=input('Enter pressure to which each cycle drops');        
rht(:,1)=input('ENter the tmeperature before entering the reheat');
rht(:,2)=input('\nEnter the temp. after entering the reheat''s boiler at each cycle');

%Next line checks for superheated temperatures at the reheat's inlet and
%returns 1 if it is superheated and 0 if steam is either dry saturated or in wet state. 
rhsuph=abs(rht(:,1)-XSteam('Tsat_p',rhp(:,1)))>0.2;

%If the temperature entered by the user is close to Saturation temperature
%to a tolerance of 0.2 then it rounds it off to Saturation temperature
rht(abs((rht(:,1)-XSteam('Tsat_p',rhp))<0.2))=XSteam('Tsat_p',abs((rhp(rht(:,1)-XSteam('Tsat_p',rhp))))<0.2);

% Elementfinder returns the position of the 2nd argument of the function in
% the 1st Argument( A matrix)
%This line returns at what inlet is the steam is in superheated state.
%Initially the user does not know where the steam is superheated
[a,~]=elementfinder(rhsuph,1);

%The enthalpy's at the superheated states(if any) are calculated in this
%line. Matrix indexing is done in such a way that the pressure and
%temperature inputs are in correspondence with the superheated states.
rhenthsup=XSteam('h_pT',rhp(rhsuph==1),rht(rhsuph==1));

% Finally the enthalpies of all the states are added into suitable
% post=itions of the rhenth matrix with the help of output from the
% variable a
rhenth(a(:,1),1)=rhenthsup(:,1);%rhenth(a)=rhenthsup(:,1);
b=elementfinder(rhsuph,0);
rhenth(b(:,1),1)=XSteam('hV_p',rhp(rhsuph==0));
rhenth(:,2)=XSteam('h_pT',rhp,rht(:,2));
rhent=XSteam('s_pT',rhp(nrh,1),rht(nrh,2));
rh=cell(2,3);
rh{1,1}='TEMPERATURE';
rh{1,2}='ENTHALPY';
rh{1,3}='ENTROPY';
rh{2,1}=rht;
rh{2,2}=rhenth;
rh{3,3}=rhent;














