function boil=boiler(rankp)
boil=cell(2,3);
boil{1,1}='TEMPERATURE';
boil{1,2}='ENTHALPY';
boil{1,3}='ENTROPY';
boil{2,1}(:,1)=input('Boiler is operating between what temperatures');
boil{2,3}(1,1)=XSteam('s_pT',rankp(2,1),boil{2,1}(1,1));
boil{2,3}(1,2)=XSteam('s_pT',rankp(2,1),boil{2,1}(1,2));
if abs(boil{2,1}(1,2)-XSteam('Tsat_p',rankp(2,1)))<0.2
    boil{2,1}(1,2)=XSteam('Tsat_p',rankp(2,1));
    boil{2,2}(1,2)=XSteam('hV_p',rankp(2,1));
end
if boil{2,3}(1,2)>XSteam('sV_p',rankp(2,1))
    boil{2,2}(1,2)=XSteam('h_pT',rankp(2,1),boil{2,1}(2,1));
end
