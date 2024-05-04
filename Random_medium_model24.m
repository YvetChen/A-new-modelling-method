
clc

clear all

close all

vp0=4.319965685826324e+03;%背景速度与密度

vs0=2.174229226018436e+03;

rau0=2750;

K=0.5;%一般取0.3-0.8之间

eps=0.08;%标准差

A=1;%介质在x，z方向上的自相关长度

B=1;

x=1:1:500;

z=1:1:500;

%a=zeros(256,256);

b=x'*x/(A^2)+z'*z/(B^2);

c=exp(-sqrt(b));%自相关函数

%c=exp(-b);

d=fft2(c,50,50);%产生随机过程功率谱

e=unifrnd(0,2*pi,50,50);%产生二维随机场

%normplot(e);

f=sqrt(d).*exp(-i*e);%产生随机功率谱

g=ifft2(f,50,50);%得到空间域的随机扰动

h=real(g);

u=mean2(h(:));%均值

l=var(h(:));%方差

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








 
