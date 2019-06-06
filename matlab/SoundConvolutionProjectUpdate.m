%Final Project for:
%Tianyu Shi, David Lee, Kevin Chien

clear;
[Y, FS]=audioread('Beyonce.mp3');
[y, fs]= audioread('sample.wav');
[YY,FS]=audioread('Queen.mp3');
[YY3,FS]=audioread('WeightKeys.mp4');
%[imp, FS]=audioread('impulse.mp4a');
%[x, xs, xbits]= wavread('hall.wav');
y=y(:,1);
Y1=Y(5.5*(length(y)):7*length(y));
YY1=YY(7*length(y):9*length(y));
YYY3=YY3(7*length(y):9*length(y));


%soundsc(YYY3,FS)
%soundsc(YY1, FS/2)

% soundsc(YY, FS)

T = 1/fs;
t =[0:1:length(y)-1];
t2 =[0:1:length(Y1)-1];
t3 =[0:1:length(YY1)-1];
t4 =[0:1:length(YYY3)-1];

figure(15)
subplot(4,1,1)
plot(t,y)
title('Glad you came - A')
subplot(4,1,2)
plot(t2,Y1)
title('Beyonce Listen - B')
subplot(4,1,3)
plot(t3, YY1)
title('Queen - C')
subplot(4,1,4)
plot(t4, YYY3)
title('Weight of Love - D')


% soundsc(y, fs); %Glad you came
% soundsc(Y1, FS*2); %Beyonce
% soundsc(YY1, FS/2); %Queen
%soundsc(YYY3, FS); %Weight of Keys

%Filter 1
f1=[0:.1:1];
f2=[.9:-.1:0];
filt1=[f1 f2];
F1=conv(y,filt1);
F1B=conv(Y1,filt1);
F1BB=conv(YY1, filt1);
F1BBB=conv(YYY3, filt1);




% soundsc(F1,fs) %Glad you came
% soundsc(F1B, FS); %Beyonce
% soundsc(F1BB, FS); %Queen
%soundsc(F1BBB,FS); % Weight of Keys

%Filter 1 more extreme
f1=[0:.05:1];
f2=[.95:-.05:0];
filt1=[f1 f2];
F1=conv(y,filt1);
F11=conv(Y1,filt1);
F11B=conv(YY1,filt1);
F111B=conv(YYY3, filt1);

%soundsc(F1,fs); %Glad you came
% soundsc(F11, FS); %Beyonce
%soundsc(F11B,FS); %Queen
%soundsc(F111B,FS); %Weight of Keys

%Filter 2
filt2=[-1 2 -1];
F2=conv(y,filt2);
F2B=conv(Y1,filt2);
F22B=conv(YY1,filt2);
F222B=conv(YYY3, filt2);

% soundsc(F2,fs) % Glad you came
% soundsc(F2B, FS);%Beyonce
%soundsc(F22B, FS);%Queen
%soundsc(F222B, FS); %Weight of Keys


%Filter 3
filt3=[-1 3 -1];
%bandpass
%L=ones(1,100);
%filt3=[1 1 -1 -1];
%filt3=[L -L]
F3=conv(y,filt3);
F3B=conv(Y1,filt3);
F33B=conv(YY1,filt3);
F333B=conv(YYY3, filt3);

%soundsc(F3, FS); %Glad you came
% soundsc(F3B, FS); %Beyonce
% soundsc(F33B, FS); %Queen
%soundsc(F333B, FS); %Weight of Keys

%Filter 4: Guess what happens?
filt4=[1 zeros(1,15000) 1 ];
F4=conv(y,filt4); % Glad you came
F44=conv(Y1,filt4); %Beyonce
F44B=conv(YY1,filt4); % Queen
F444B=conv(YYY3, filt4); %Weight of Keys



%Put them all together
%Glad you came results
%no filter
soundsc(y, FS)
%filter=[0:.05:1 and back down again
soundsc(F1, FS)
%filter=[-1 2 -1]
soundsc(F2, FS)
%filter=[-1 3 -1]
soundsc(F3,FS)
%filter=[1 00000000 (10000 zeros) 1]
soundsc(F4, FS)

%Beyonce results
%no filter
% soundsc(Y1, FS/2)
% %filter=[0:.05:1 and back down again
% soundsc(F11, FS)
% %filter=[-1 2 -1]
% soundsc(F2B, FS)
% %filter=[-1 3 -1]
% soundsc(F3B,FS)
% %Filter 4: Guess what happens?
% %filter=[1 00000000 (10000 zeros) 1]
% soundsc(F44,FS)

%Queen results
%no filter
% soundsc(YY1, FS)
% %filter=[0:.05:1 and back down again
% soundsc(F11B, FS)
% %filter=[-1 2 -1]
% soundsc(F22B, FS)
% %filter=[-1 3 -1]
% soundsc(F33B,FS)
% %soundsc(F3,fs)
% %Filter 4: Guess what happens?
% %filter=[1 00000000 (10000 zeros) 1]
% soundsc(F44B,FS)



%Weight of Keys results
%no filter
% soundsc(YYY3, FS)
% %filter=[0:.05:1 and back down again
% soundsc(F111B, FS)
% %filter=[-1 2 -1]
% soundsc(F222B, FS)
% %filter=[-1 3 -1]
% soundsc(F333B,FS)
% %soundsc(F3,fs)
% %Filter 4: Guess what happens?
% %filter=[1 00000000 (10000 zeros) 1]
% soundsc(F444B,FS)



%Guess what happens?

% soundsc(F44,fs); %Beyonce
% soundsc(F44B, FS); %Queen
% soundsc(F4, FS); %Glad you came
% soundsc(F444B, FS); %Weight of Keys
%soundsc(y,fs)


% a = [ 1 zeros(1,50000) 1 zeros(1,1000)];   %delayed
% a1 = conv(y,a);
% figure(2)
% plot(a1)
% soundsc(a1,fs)



% b = [zeros(1,20) ones(1,100)/20 zeros(1,20)];  %smoothing i.e. low pass
% b1 = conv(y,b);
% figure(2)
% plot(b1)
% soundsc(b1,fs)



% c= [-1 1];     % high pass
% c1 = conv(y,c);
% figure(2)
% plot(c1)
% soundsc(c1,fs)



% xa = x(:,1);
% xb = xa(1:60000);   % reverb
% e1 = conv(y,xb);  
% figure(2)
% plot(xb)
% figure(3)
% plot(e1)
% soundsc(e1,fs)



ya = y(90000:145000);
y1 = conv(y,y);
figure(2)
plot(ya)
figure(3)
plot(y1)
% soundsc(y1,fs)



