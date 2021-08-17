% cross-correlation calculation
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%读取pred_label的数据x1,y1, 用于确定每个bubble在图中的位置
fileID = fopen('D:\IC\BioMedical\Individual Project\Code\Cross_corr\Pred_Label\CEUS234_label.txt','r');
formatSpec = '%d %d %d %d';
sizeA = [4,15];
A = fscanf(fileID,formatSpec,sizeA);
A = A';
fclose(fileID);

%% 读取groundtruth
fileID_gt = fopen('D:\IC\BioMedical\Individual Project\Code\Cross_corr\Groundtruth\Label234.txt','r');
formatSpec_gt = '%f %f %f %f';
sizeB = [4,15];
B = fscanf(fileID_gt,formatSpec_gt,sizeB);
B = B';
B = B+64;
gt = B(:,1:2);    %Groundtruth
fclose(fileID_gt);

%% Cross correlation calculation
cd('D:\IC\BioMedical\Individual Project\Code\Cross_corr\Pred_Bubble');
Files=dir('CEUS*.*');
R_corr =zeros(15,2);  %用于读取完整cross correlation center列表的数组
F_cent =zeros(15,2);  %最终的cross correlation center
cent_gt =zeros(15,4);
A_cent = A(:,1:2);    %为每个cross correlation center提供对应bubble的起始位置


std_PSF = im2gray(imread('D:\IC\BioMedical\Individual Project\Code\Cross_corr\std_PSF.png'));
for k = 1:length(Files)
 FileNames = sprintf('CEUS234.jpg_Bubble_%d.jpg', k-1);
 %FileNames_2=Files(k).name; 不按序号顺序
 I= imread(FileNames);
 I_pad = padarray(I,[3,3],0,'both');
 C_MB = im2gray(I_pad);
 c = normxcorr2(std_PSF, C_MB);
 
[ypeak,xpeak] = find(c==max(c(:)));

yoffSet = ypeak-size(std_PSF,1); %算出offset点,即xmin,ymin
xoffSet = xpeak-size(std_PSF,2);

xf = xoffSet + 3 +1 -3; %+3因为是从x,ymin到中心点的距离(7*7中心,+4), -3是因为padding,+1因为python和matlab 起始不同 0/1
yf = yoffSet + 3 +1 -3;
R_corr(k,1)=xf;
R_corr(k,2)=yf;

 F_cent(k,1) = R_corr(k,1) + A_cent(k,1);   %计算最终正确的cross correlation center位置
 F_cent(k,2) = R_corr(k,2) + A_cent(k,2);
 cent_gt(k,1:2) = F_cent(k,1:2);  % cross_correlation vs gt
 cent_gt(k,3:4) = gt(k,1:2);
end

%% 生成groundtruth和predicted centroid的对比图
%Without bbox

%With bbox
originalImage = imread('D:\IC\BioMedical\Individual Project\Code\Cross_corr\Pred_bbox\CEUS234.jpg');
originalImage = mat2gray(originalImage,[0 256]);

figure(1)
imshow(originalImage)
title('Predicted (red) and GroungTruth (blue) Cross-correlation'); 
hold on

for k = 1:length(Files)
    plot(F_cent(k,1), F_cent(k,2), 'r*')  %Red
    plot(gt(k,1), gt(k,2), 'bo')                  %Blue
end
hold off

%% Initial code
%A = imread('D:\IC\BioMedical\Individual Project\Code\Cross_corr\CEUS62.jpg_Bubble_0.jpg');
%B = padarray(A,[3,3],0,'both');

%std_PSF = im2gray(imread('std_PSF.png'));
%C_MB = im2gray(B);

%c = normxcorr2(std_PSF, C_MB);

%[ypeak,xpeak] = find(c==max(c(:)));

%yoffSet = ypeak-size(std_PSF,1);
%xoffSet = xpeak-size(std_PSF,2);

%xf = xoffSet + 3;
%yf = yoffSet + 3;




