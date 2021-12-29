clearvars;
tic
fprintf("Cargando Datos \n");
video = VideoReader("exp1\30_FPS_2812_1823-11\camera_1\my_video_1.avi");
duration = video.Duration;
frames = video.NumFrames;
frameRate = 30;
imagen = [];
fprintf("Escoga el area a analizar \n");
imC = readFrame(video);
[~,rect] = imcrop(imC);
numFrame = 1;
maxFrames = 900;
sampleTime = maxFrames - (numFrame-1);
x = linspace(floor(numFrame/frameRate),floor(maxFrames/frameRate),sampleTime);
while numFrame <= maxFrames
    img_1 = read(video,numFrame);
    img_1 = img_1(:,:,1);
    [img_1] = imcrop(img_1,rect);
    [w,h] = size(img_1);
    img_1 = reshape(img_1,[1 w*h]);
    imagen = [imagen; img_1];
    numFrame = numFrame + 1;
end
imagesc(x,w*h,imagen');
title([num2str(sampleTime) ' Frames analizados']);
xlabel('Tiempo (s)'); ylabel('Pixeles');
pir2D = imagen(:,5940);
figure
y = lowpass(double(pir2D),0.05,'Steepness',0.95,'StopbandAttenuation',60);
%y = lowpass(double(pir2D),0.12,'Steepness',0.7,'StopbandAttenuation',60);
plot(x,pir2D);
hold on;
plot(x,y);
figure
Nfft = sampleTime;
[Pxx,f] = pwelch(y,gausswin(Nfft),Nfft/2,Nfft,30);
plot(f,abs(Pxx))
% hold on;
% plot(abs(ffsig))




toc




