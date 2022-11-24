clear
clc
close all

image_name =  'C:\Users\kc\Desktop\2022.jpg';
I=imread(image_name);
Is = double(I); %转换为双精度
figure,imshow(uint8(I)), title('原图');
[h, w, z] = size(I);
IR = Is(:,:,1);         
IG = Is(:,:,2);
IB = Is(:,:,3);

Ga = fspecial('gaussian', [1501 1501],250); %fspecial生成一个高斯滤波器,3*sigma等于窗口半径
Gb = fspecial('gaussian', [481 481],80);%最大尺度大于100
Gc = fspecial('gaussian', [91 91],15);
LRa = imfilter(IR,Ga,'conv','replicate');
LRb = imfilter(IR,Gb,'conv','replicate');
LRc = imfilter(IR,Gc,'conv','replicate');
LGa = imfilter(IG,Ga,'conv','replicate');
LGb = imfilter(IG,Gb,'conv','replicate');
LGc = imfilter(IG,Gc,'conv','replicate');
LBa = imfilter(IB,Ga,'conv','replicate');
LBb = imfilter(IB,Gb,'conv','replicate');
LBc = imfilter(IB,Gc,'conv','replicate');

AR = (3*log(IR+1) - log(LRa+1)- log(LRb+1)- log(LRc+1))/3;
AG = (3*log(IG+1) - log(LGa+1)- log(LGb+1)- log(LGc+1))/3;
AB = (3*log(IB+1) - log(LBa+1)- log(LBb+1)- log(LBc+1))/3;

AR1 = AR(:);
RMax = max(AR1);
RMin = min(AR1)
R = ( AR - RMin ) / (RMax - RMin) * 255;
AG1 = AG(:);
GMax = max(AG1);
GMin = min(AG1)
G = ( AG - GMin ) / (GMax - GMin) * 255;
AB1 = AB(:);
BMax = max(AB1);
BMin = min(AB1)
B = ( AB - BMin ) / (BMax - BMin) * 255;

I1 = cat(3,R,G,B);
figure,imshow(uint8(I1)), title('增强图');
imwrite(uint8(I1),'C:\Users\kc\Desktop\aaa1.jpg')
%imwrite(uint8(I1),'E:\学习\Retinex\图片\MSR\8.jpg');
%[m1,v1,d1,s1] = zhibiao(uint8(I1),w,h)
