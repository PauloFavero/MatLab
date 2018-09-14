function [H] = f( i,j,om )

global Phid Phie lbdd

H=0;
n=4;

for k=1:4
    H=H+Phid(i,k)*Phie(j,k)/(1i*om - lbdd(k,k))+Phid(i,k)'*Phie(j,k)'/(1i*om - lbdd(k,k)');
    
end 
end

