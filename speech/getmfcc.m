function [ features ] = getmfcc()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%

clc
clear

% read your voice with any character
recorder = audiorecorder(8000,8,1);
disp('Start Speacking...... to Record!!');
recordblocking(recorder,2);
disp('Thanks.....Recorded!!');
play(recorder);
recorder_info = get(recorder);
recorder_data = getaudiodata(recorder);
audiowrite('vtest.wav', recorder_data, recorder_info.SampleRate);
[x,fs]=audioread('vtest.wav');

a=ones(3,1)/3;       % mask
y=filter(a,1,x);   % apply linear filter with zero padding

first=x(1:1600);
m=mean(first);
s=std(first);


for i=1:length(x)
    d(i,1)=(x(i)-m)/s;
    if (d(i)>.3) % threshold -> th -> 0.3
        A(i,1)=1;  % voiced
    else 
         A(i,1)=0;  % unvoiced
    end
end


temp=0;
a=0;
b=0;
n=0;
m=0;

for j=0:80:length(A)-80  % intial -> 0, step -> 80 , finish at -> length of A - 80   -> because we don't need last 80
 block=A(j+1:temp+80); % 1 : 80
   maj=sum(block);
   
  if (maj>=40)
    voiced(a+1:a+80,1)=x(j+1:temp+80);
     a=a+80;
     n=n+1; % counter of voiced
  else
    unvoiced(b+1:b+80,1)=x(j+1:temp+80);
    b=b+80;
    m=m+1; % counter of unvoiced
  end   
  temp=temp+80;
end

h=hamming(4001);

window=h.*s;

en=sum(window);
f=abs(fft(window))

mel=2595*((log(1+f./700)));
mel=log(mel);

d=abs(dct(mel));
features=d(1:12); % just first 12 Feature

end

