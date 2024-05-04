
clc

clear all

close all

vp0=4.319965685826324e+03;%Background velocity and density

vs0=2.174229226018436e+03;

rau0=2750;

K=0.5;%0.3-0.8

eps=0.08;%standard deviation

A=1;%The autocorrelation length of the medium in the x and z directions

B=1;

x=1:1:500;

z=1:1:500;

%a=zeros(256,256);

b=x'*x/(A^2)+z'*z/(B^2);

c=exp(-sqrt(b));%autocorrelation function

%c=exp(-b);

d=fft2(c,50,50);%Generate a random process power spectrum

e=unifrnd(0,2*pi,50,50);%Generates two-dimensional random fields

%normplot(e);

f=sqrt(d).*exp(-i*e);%Generate a random power spectrum

g=ifft2(f,50,50);%The random disturbance of the space domain is obtained

h=real(g);

u=mean2(h(:));%mean value

l=var(h(:));%variance


m=eps/sqrt(l)*(h-u);



vp=vp0*(1+m);

vs=vs0*(1+m);

rau=rau0*(1+K*m);

imagesc(vp);

fvp = fopen('random_vp.bin','wb');

fvs = fopen('random_vs.bin','wb');

frau = fopen('random_rau.bin','wb');



for x=1:50

   for z=1:50

        fwrite(fvp,vp(x,z),'float'); 

        fwrite(fvs,vs(x,z),'float');

        fwrite(frau,rau(x,z),'float');
        

   end

end

fclose(fvp);

fclose(fvs);

fclose(frau);



cvp = fopen('random_vp.txt','wt+');

cvs = fopen('random_vs.txt','wt+');

crau = fopen('random_rau.txt','wt+');



for x=1:50

   for z=1:50

        fprintf(cvp,'%g,%g,%g\n',x,z,vp(x,z)); 
        fprintf(cvs,'%g,%g,%g\n',x,z,vs(x,z)); 
        fprintf(crau,'%g,%g,%g\n',x,z,rau(x,z)); 
       
        

   end

end

fclose(cvp);

fclose(cvs);

fclose(crau);








 
