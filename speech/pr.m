function [Feature ] = pr()
%Record 1 (A) 
Rec =audiorecorder(8000,8,1);
disp('Start Speaking');
recordblocking(Rec,2);
%  ply=play(Rec);
disp('End Of Speaking');
S = getaudiodata(Rec);
save('S.mat','S');
audiowrite('S.wav',S,8000);
[y, fs] = audioread('S.wav');
y =y(:,1);
Threshold = 4e-3;
frame_duration = 0.2;
frame_length = frame_duration*fs;
Total_length =length(y) ;
Num_of_frames = floor(Total_length/frame_length);
y_new =[] ;
for n = 1: Num_of_frames
      y_frame = y((n-1)*frame_length+1:frame_length*n);
   if max(y_frame)> Threshold 
      y_new =[y_new y_frame];
    end
end
% load S.mat 

%Record 2 (B) 
Rec =audiorecorder(8000,8,1);
disp('Start Speaking');
recordblocking(Rec,2);
 % ply=play(Rec);
disp('End Of Speaking');
V = getaudiodata(Rec);
save('V.mat','V');
audiowrite('V.wav',V,8000);
[y, fs] = audioread('V.wav');
y =y(:,1);
Threshold = 4e-3;
frame_duration = 0.2;
frame_length = frame_duration*fs;
Total_length =length(y) ;
Num_of_frames = floor(Total_length/frame_length);
y_new =[] ;
for n = 1: Num_of_frames
      y_frame = y((n-1)*frame_length+1:frame_length*n);
   if max(y_frame)> Threshold 
      y_new =[y_new y_frame];
    end
end

% %Recored 3
% Rec =audiorecorder(8000,8,1);
% disp('Start Speaking');
% recordblocking(Rec,2);
% % ply=play(Rec);
% disp('End Of Speaking');
% D = getaudiodata(Rec);
% save('D.mat','D');
% audiowrite('D.wav',D,8000);
% load V.mat 
% voice 1
 window=hamming(16000);
 W = window .*S ; 
 F = fft(W);
 F = abs(F); %(Magntitude)Here Converted to Frequancy Domain  
 
%  subplot(2,2,1)
%  plot(F);
%  title('FFT');
%  
 Mel = 2595.*(log(1+F/700));
 Mel = log (Mel);
 
%  subplot(2,2,2)
%  plot(Mel);
%  title('Mel');
%  
 DCT = dct(Mel) ; % Here Converted to Time Domain Again
 DCT = abs(DCT);
 
%  subplot(2,2,3)
%  plot(DCT);
%  title('DCT');
 
 Featur = DCT(1:12) ;
 Featur=transpose(Featur);
%  subplot(2,2,4)
%  plot(Featur);
%  title('Feature');

 
 %voice 2
 window=hamming(16000);
 W = window .*V ; 
 F = fft(W);
 F = abs(F); %(Magntitude)Here Converted to Frequancy Domain  
 
%  subplot(2,2,1)
%  plot(F);
%  title('FFT');
 
 Mel = 2595.*(log(1+F/700));
 Mel = log (Mel);
 
%  subplot(2,2,2)
%  plot(Mel);
%  title('Mel');
 
 DCT = dct(Mel) ; % Here Converted to Time Domain Again
 DCT = abs(DCT);
 
%  subplot(2,2,3)
%  plot(DCT);
%  title('DCT');
 
 Featu = DCT(1:12) ;
 Featu=transpose(Featu);
%  subplot(2,2,4)
%  plot(Featu);
%  title('Feature');
 %voice 3
%  
%  window=hamming(16000);
%  %W = window .*D ; 
%  F = fft(W);
%  F = abs(F); %(Magntitude)Here Converted to Frequancy Domain  
%  
%  subplot(2,2,1)
%  plot(F);
%  title('FFT');
%  
%  Mel = 2595.*(log(1+F/700));
%  Mel = log (Mel);
%  
%  subplot(2,2,2)
%  plot(Mel);
%  title('Mel');
 
%  DCT = dct(Mel) ; % Here Converted to Time Domain Again
%  DCT = abs(DCT);
 
%  subplot(2,2,3)
%  plot(DCT);
%  title('DCT');
 
%  Feat = DCT(1:12) ;
%  Feat=transpose(Feat);
%  subplot(2,2,4)
%  plot(Feat);
%  title('Feature');
%  Feature=[Featur];
% disp(Featur);
% disp(Featu);

%  Feature_marwan=[Featur,Featu];
%  Mel = 2595.*(log(1+Feature/700));
%  Mel = log (Mel);
%  DCT = dct(Mel) ; % Here Converted to Time Domain Again
%  DCT = abs(DCT);
Feature=[Featur,Featu];
Feature = DCT(1:24) ;
% Feature_marwan=transpose(Feature_marwan);
 %load net.mat 
 
% res = abs(round(sim(net,Feature_marwan)));
%  if res == 1
%     title('bedo');
%  elseif res == 2
%        title('gemy');
%  elseif res == 3
%     i=imread(kholyo);
%     imshow(i);
%     title('kholyo');
%  else
%     title('reject');
%  end
% disp (res);
%  Feature=[Featur;Featu];
%  figure;
%  plot(Feature);
end