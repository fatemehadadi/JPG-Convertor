%% 
clc;
close all;
clear all;

%Read The Image
img=imread('lena.tif');

%calculate the size of image
[m,n]=size(img);
A=zeros(m,n);
jpgc=A;
datastorerate=6;
N=8;

for i=1:N:m
    for j=1:N:n
        %take the sample NxN
        sample=img(i:i+N-1,j:j+N-1);
        %insert tranformated to jpgimg
        transformed=dct2(sample);
        A(i:i+N-1,j:j+N-1)=transformed;
        jpgc(i:i+N-1,j:j+N-1)=idct2(transformed);
    end
end
imge=double(img);
distortion1=100*norm(imge-real(jpgc),'fro')^2/norm(imge,'fro')^2;
disp('The Distortion is:');
disp(distortion1);
C=jpgc/255;
figure,imshow(C);
imwrite(C,'lena.jpeg');
%% 
costrans=zeros(m,n);
jpgreduce=zeros(m,n);
for i=1:N:m
    for j=1:N:n
        %take the sample NxN
        sample=img(i:i+N-1,j:j+N-1);
        %insert tranformated to jpgimg
        transformed=dct2(sample);
        %remove noise
        transformed(N:-1:datastorerate+1,:)=0;
        transformed(:,N:-1:datastorerate+1)=0;
        costrans(i:i+N-1,j:j+N-1)=transformed;
        jpgreduce(i:i+N-1,j:j+N-1)=idct2(transformed);
    end
end
distortion2=100*norm(imge-real(jpgreduce),'fro')^2/norm(imge,'fro')^2;
disp('The Distortion is:');
disp(distortion2);
B=jpgreduce/255;
imwrite(B,'lena-reduce.jpg');
figure,imshow(B);