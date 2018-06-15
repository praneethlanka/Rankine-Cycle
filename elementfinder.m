function [k,flag]=elementfinder(a,b)
tic
[l,m]=size(a);
flag=0;
i=0;
k=zeros(5,2);
for rows=1:l
    for columns=1:m
       if(a(rows,columns)==b)
            flag=flag+1;
            i=i+1;
            k(i,1)=rows;
            k(i,2)=columns;
       end
    end
end
if flag<5
    k(flag+1:5,:)=[];
end
toc;

