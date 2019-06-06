dt=.001;
t=[-10:dt:10];
ind=find(t>=-1&t<=1);

data=zeros(size(t));
data(ind)=1;

%data=zeros(1,999);
%data(451:550)=1;
%T=10;
%len=length(data);
%t=linspace(-T/2,T/2,len);
data2=zeros(size(t));
ind2=find(t>=-2&t<=2);
data2(ind2)=1;
%data2(401:600)=1;
figure
plot(t,data);
hold on
plot(t,data2, 'r')
legend('A=rect(t/tau)', 'B=rect(t/2tau)')

pause;



data3=zeros(size(t));
ind3=find(data>.5);
data3(ind3+800)=1;

FT1=fftshift(fft(ifftshift(data)));
FT2=fftshift(fft(ifftshift(data2)));
FT3=fftshift(fft(ifftshift(data3)));

magFT1=abs(FT1);
magFT2=abs(FT2);
magFT3=abs(FT3);
angFT1=angle(FT1);
angFT2=angle(FT2);

ReFT1=real(FT1);
ReFT2=real(FT2);
ReFT3=real(FT3);
ImFT1=imag(FT1);
ImFT2=imag(FT2);
ImFT3=imag(FT3);
angFT1new=unwrap(atan(ImFT1./ReFT1));
angFT2new=unwrap(atan(ImFT2./ReFT2));
angFT3new=(atan(ImFT3./ReFT3));
angFT3test=angle(FT3);

ind=find(ReFT1<0);
angFT1new(ind)=angFT1new(ind)+pi;
ind2=find(ReFT2<0);
angFT2new(ind2)=angFT2new(ind2)+pi;
ind3=find(ReFT3<0);
angFT3new(ind3)=angFT3new(ind3)+pi;
% 
% 

fmax=1/dt;
f=linspace(-fmax, fmax, length(t));
l=length(t);
l=floor(l/2);
l1=l-100;
l2=l+100;

figure
plot(f(l-100:l+100),magFT1(l-100:l+100))
hold on
plot(f(l-100:l+100),magFT2(l-100:l+100), 'r')
axis([-10 10 0 5000])
xlabel('frequency in Hz')
legend('A=rect(t/tau)', 'B=rect(t/2tau)')


pause;

figure
subplot(1,2,1)
plot(t,data);
hold on
plot(t,data2, 'r')
xlabel('seconds')
legend('A=rect(t/tau)', 'B=rect(t/2tau)')


subplot(1,2,2)
plot(f(l-100:l+100),magFT1(l-100:l+100))
hold on
plot(f(l-100:l+100),magFT2(l-100:l+100), 'r')
axis([-10 10 0 5000])
xlabel('frequency in Hz')
legend('A=rect(t/tau)', 'B=rect(t/2tau)')




pause;

figure
subplot(2,1,1)
plot(f(l-100:l+100),magFT1(l-100:l+100)./max(FT1))
hold on
plot(f(l-100:l+100),magFT2(l-100:l+100)./max(FT2), 'r')
axis([-10 10 0 1]);
xlabel('frequency in Hz')
legend('A=rect(t/tau)', 'B=rect(t/2tau)')


subplot(2,1,2)
plot(f(l-100:l+100),angFT1new(l-100:l+100))
hold on  
plot(f(l-100:l+100),angFT2new(l-100:l+100), 'r')
axis([-10 10 0 2*pi])
xlabel('frequency in Hz')
legend('A=rect(t/tau)', 'B=rect(t/2tau)')


pause;

figure
plot(t, data, t, data3, 'g')
legend('A=rect(t/tau)', 'B=rect((t-tau/2)/tau)')


pause;

figure
subplot(2,1,1)
plot(f(l-100:l+100),magFT1(l-100:l+100)./max(FT1))
hold on
plot(f(l-100:l+100),magFT3(l1:l2)./max(FT3), 'g--')
axis([-10 10 0 1]);
xlabel('Frequency in Hz')
legend('A=rect(t/tau)', 'B=rect((t-tau/2)/tau)')

subplot(2,1,2)
plot(f(l-100:l+100),angFT1new(l1:l2))
hold on
plot(f(l-100:l+100),unwrap(angFT3new(l1:l2)), 'g')
axis([-10 10 0 12]);
xlabel('Frequency in Hz')
legend('A=rect(t/tau)', 'B=rect((t-tau/2)/tau)')

pause;

ind=find(t>0);
xtexp=zeros(1,length(t));
xtexp2=xtexp;
xtexp(ind)=exp(-t(ind));
xtexp2(ind)=exp(-2*t(ind));
dt=t(2)-t(1);
f=linspace(-1/dt, 1/dt, length(t));

FTxt=fftshift(fft(xtexp));
FTxt2=fftshift(fft(xtexp2));


figure
%subplot(2,1,1)
plot(t,xtexp, 'b', t, xtexp2, 'r')
title('Exponential Decay')
legend('A=e^-t', 'B=e^-2t')

pause;

figure
plot(f,abs(FTxt)./max(abs(FTxt)))
hold on
plot(f,abs(FTxt2)./max(abs(FTxt2)), 'r')
xlabel('Hertz')
axis([-250 250 0 1]);
legend('A=e^-t', 'B=e^-2t')
pause;


ind2=find(t>=0&t<=.1);
ind3=find(t>.1&t<=.2+dt);
ind4=find(t>.2&t<=.4+dt);
xhigh=zeros(1,length(t));
xhigh(ind2)=1;
xhigh(ind3)=-1;
%sum(xhigh)
xhigh2=zeros(1,length(t));
xhigh2(ind2)=1;
xhigh2(ind3)=1;
xhigh2(ind4)=-1;
%sum(xhigh2)

FTxhigh=fftshift(fft(xhigh));
FTxhigh2=fftshift(fft(xhigh2));
figure
plot(t, xhigh, 'b')%, t, xhigh2, 'r--')
axis([-2 2 -2 2])
legend('A', 'B')
pause;

figure
plot(f, abs(FTxhigh)./max(abs(FTxhigh)));
axis([-250 250 0 1])
legend('A', 'B')
pause;

figure
plot(t, xhigh, 'b', t, xhigh2, 'r--')
axis([-2 2 -2 2])

legend('A', 'B')
pause;
figure
plot(f,abs(FTxhigh)./max(abs(FTxhigh)), 'b', f, abs(FTxhigh2)./max(abs(FTxhigh2)), 'r--')
xlabel('Hertz')
axis([-250 250 0 1])
legend('A', 'B')


% figure
% plot(f,abs(FTxhigh)./max(abs(FTxhigh)), 'b', f, abs(FTxhigh2)./max(abs(FTxhigh2)), 'r')
% xlabel('Hertz')
dt=.01;
t4=[-5:dt:5];
ind=find(abs(t4)<1);
x=zeros(size(t4));
x(ind)=cos(pi/2*t4(ind));
figure
subplot(2,1,1)
plot(t4,x)
title('Original x(t)')
pause;
FTT=fftshift(fft(x));
F=linspace(-1/dt,1/dt,length(x));
subplot(2,1,2)
plot(F,abs(FTT));
title('FT of x(t)')

pause;
dt=.01;
t4=[-5:dt:5];
ind=find(abs(t4)<1.5);
x=zeros(size(t4));
x(ind)=cos(pi/2*t4(ind));
figure
subplot(2,1,1)
plot(t4,x)
title('Original x(t)')
pause;
FTT=fftshift(fft(x));
F=linspace(-1/dt,1/dt,length(x));
subplot(2,1,2)
plot(F,abs(FTT));
title('FT of x(t)')

pause;
dt=.01;
t4=[-5:dt:5];
ind=find(abs(t4)<2);
x=zeros(size(t4));
x(ind)=cos(pi/2*t4(ind));
figure
subplot(2,1,1)
plot(t4,x)
title('Original x(t)')
pause;
FTT=fftshift(fft(x));
F=linspace(-1/dt,1/dt,length(x));
subplot(2,1,2)
plot(F,abs(FTT));
title('FT of x(t)')

pause;
dt=.01;
t4=[-5:dt:5];
ind=find(abs(t4)<3);
x=zeros(size(t4));
x(ind)=cos(pi/2*t4(ind));
figure
subplot(2,1,1)
plot(t4,x)
title('Original x(t)')
pause;
FTT=fftshift(fft(x));
F=linspace(-1/dt,1/dt,length(x));
subplot(2,1,2)
plot(F,abs(FTT));
title('FT of x(t)')
