clear all
close all
Image=imread('deathstar.jpg');
phantom=Image(1:2:end,1:2:end,1);
phantom=phantom<10; 
%phantom=im2double(phantom);
%phantom=abs(phantom-255);
%Load image
%phantom=importdata('image.jpg');
imagesc(phantom); %the head phantom is pre-loaded in matlab, or you can import your own image
axis square
colormap(gray);

%%

%Make sinogram of phantom
sinogram = radon(phantom, 1:360);
figure
imagesc(sinogram');
colormap(gray);

%%

%Perform 1D filter on each projection in the sinogram (ramp filter and hann)
X=abs(-floor(size(sinogram,1)/2):floor(size(sinogram,1)/2)); %ramp function
X(floor(size(sinogram,1)/2)+1)=1;  %set DC for ramp function to 1
X=X';
window=hann(size(sinogram,1)); %create smooth filter (hann filter)

Sinogram=zeros(size(sinogram,1),size(sinogram,2)); 
Sinogram2=zeros(size(sinogram,1),size(sinogram,2));
 
%  for ind = 1:360
%     z = sin(x*2*pi/ind)+cos(y*2*pi/ind);
%     im = sc(z, 'hot');
%     writeVideo(vidfile, im);
%  end
%close(vidfile)
%loop through each projection and multiply 1D FT by filter, then take IFT
for h=1:360
    Sinogram(:,h)=X.*fftshift(fft(sinogram(:,h))); %ramp filtration
    HSinogram(:,h)=window.*X.*fftshift(fft(sinogram(:,h))); %hann filtration
    Sinogram2(:,h)=fftshift(fft(sinogram(:,h))); %no filtration
    filteredsin(:,h)=ifft(ifftshift(Sinogram(:,h))); 
    Hfilteredsin(:,h)=ifft(ifftshift(HSinogram(:,h)));
   
end

%Display FFT and filters
figure
colormap(gray)
subplot(2,3,1);imagesc(abs(Sinogram2'));title('1D FFT of Sinogram')
subplot(2,3,2);plot(X);title('Ramp Filter'); axis square;
subplot(2,3,3);imagesc(abs(Sinogram'));title('Filtered Frequeny Domain')
subplot(2,3,5);plot(X.*window);title('Hann Filter'); axis square;
subplot(2,3,6);imagesc(abs(HSinogram'));title('Hann Filtered Frequeny Domain')
pause;
%Display original sinogram and filtered sinogram
figure
colormap(gray)
subplot(1,3,1);imagesc(sinogram);title('Unfiltered Sinogram')
subplot(1,3,2);imagesc(filteredsin);title('Filtered Sinogram')
subplot(1,3,3);imagesc(Hfilteredsin);title('Hamming Filtered Sinogram')

%%
%SKIP THIS SECTION TOO LONG FOR CLASS

%Backproject from filtered sinogram

%initialize matrices
backprojection1d=zeros(size(sinogram,1),size(sinogram,1),180);
backprojection2d=zeros(size(sinogram,1),size(sinogram,1),180);
backprojection3d=zeros(size(sinogram,1),size(sinogram,1),180);
rotbackprojection1d=zeros(size(sinogram,1),size(sinogram,1),180);
rotbackprojection2d=zeros(size(sinogram,1),size(sinogram,1),180);
rotbackprojection3d=zeros(size(sinogram,1),size(sinogram,1),180);
cumulative1d=zeros(size(sinogram,1),size(sinogram,1),180);
cumulative2d=zeros(size(sinogram,1),size(sinogram,1),180);
cumulative3d=zeros(size(sinogram,1),size(sinogram,1),180);


max=180; %desired number of projections
inc=180/max; %angle between projections
for n = 1:max
angle = n*inc;
%backproject each projection to fill the full image
for k=1:size(sinogram,1)
    backprojection1d(k,:,n)=sinogram(:,n*inc);
    backprojection2d(k,:,n)=filteredsin(:,n*inc);
    backprojection3d(k,:,n)=Hfilteredsin(:,n*inc);
end
%rotate and sum each backprojection
rotbackprojection1d(:,:,n)=imrotate(backprojection1d(:,:,n),angle,'nearest','crop');
rotbackprojection2d(:,:,n)=imrotate(backprojection2d(:,:,n),angle,'nearest','crop');
rotbackprojection3d(:,:,n)=imrotate(backprojection3d(:,:,n),angle,'nearest','crop');
cumulative1d(:,:,n)=sum(rotbackprojection1d,3);
cumulative2d(:,:,n)=sum(rotbackprojection2d,3);
cumulative3d(:,:,n)=sum(rotbackprojection3d,3);
end
x1=floor(size(sinogram,1)-size(phantom,1))/2;
x2=x1+size(phantom,1);

%plot the resulting images for unfiltered, ramp filtered, and hann filtered
%backprojection
figure
subplot(1,3,1);imshow(cumulative1d(x1:x2,x1:x2,max),[]), title('Backprojection')
subplot(1,3,2);imshow(cumulative2d(x1:x2,x1:x2,max),[]), title('Ramp Filtered Backprojection')
subplot(1,3,3);imshow(cumulative3d(x1:x2,x1:x2,max),[]), title('Hann Filtered Backprojection')

save DeathStarData cumulative1d cumulative2d cumulative3d x1 x2 max

%%
load DeathStarData
%Diplay backprojection movie - no filtration
figure,hold on
for k = 1:max
    imshow(cumulative1d(x1:x2,x1:x2,k)/100,[],'InitialMagnification',200)
    %// MATLAB pauses for 0.001 sec before moving on to execue the next 
    %%// instruction and thus creating animation effect
    pause(0.001);     
end
%%

%Diplay backprojection movie - ramp filtration
figure,hold on
for k = 1:max
    imshow(cumulative2d(x1:x2,x1:x2,k),[],'InitialMagnification',200)
    %// MATLAB pauses for 0.001 sec before moving on to execue the next 
    %%// instruction and thus creating animation effect
    pause(0.001);     
end
%%

%Diplay backprojection movie - hann filtration
figure,hold on
for k = 1:max
    imshow(cumulative3d(x1:x2,x1:x2,k),[],'InitialMagnification',200)
    %// MATLAB pauses for 0.001 sec before moving on to execue the next 
    %%// instruction and thus creating animation effect
    pause(0.002);     
end
%% 
figure
subplot(1,3,1);imshow(cumulative1d(x1:x2,x1:x2,max),[]), title('Simple Backprojection')
subplot(1,3,2);imshow(cumulative2d(x1:x2,x1:x2,max),[]), title('Ramp Filtered Backprojection')
subplot(1,3,3);imshow(cumulative3d(x1:x2,x1:x2,max),[]), title('Hann Filtered Backprojection')


