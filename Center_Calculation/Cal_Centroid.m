% Centroid calculation
%% 读取pred_label的数据x1,y1, 用于确定每个bubble在图中的位置
fileID = fopen('D:\IC\BioMedical\Individual Project\Code\Centroid\Pred_Label\CEUS62_label.txt','r');
formatSpec = '%d %d %d %d';
sizeA = [4,15];
A = fscanf(fileID,formatSpec,sizeA);
A = A';
fclose(fileID);

%% 读取groundtruth
fileID_gt = fopen('D:\IC\BioMedical\Individual Project\Code\Centroid\Groundtruth\Label62.txt','r');
formatSpec_gt = '%f %f %f %f';
sizeB = [4,15];
B = fscanf(fileID_gt,formatSpec_gt,sizeB);
B = B';
B = B+64;
gt = B(:,1:2);    %Groundtruth
fclose(fileID_gt);

%% Centroids calculation
cd('D:\IC\BioMedical\Individual Project\Code\Centroid\Pred_Bubble');
Files=dir('CEUS*.*');
R_cent =zeros(15,2);  %用于读取完整centroids列表的数组
F_cent =zeros(15,2);  %最终的centroid
cent_gt =zeros(15,4);
A_cent = A(:,1:2);    %为每个centroid提供对应bubble的起始位置
for k = 1:length(Files)
 FileNames = sprintf('CEUS62.jpg_Bubble_%d.jpg', k-1);
 %FileNames_2=Files(k).name; 不按序号顺序
 I= imread(FileNames);
 %I = mat2gray(I,[0 256]);
 BW = imbinarize(I,0.3);
 s = regionprops(BW,'centroid');
 %s = regionprops(BW,I,{'Centroid','WeightedCentroid'});
 centroids = cat(1,s.Centroid);
 R_cent(k,:) = centroids;                 %centroid列表
 F_cent(k,1) = R_cent(k,1)+A_cent(k,1);   %计算最终正确的centroid位置
 F_cent(k,2) = R_cent(k,2)+A_cent(k,2);
 cent_gt(k,1:2) = F_cent(k,1:2);          % centroid vs groundtruth
 cent_gt(k,3:4) = gt(k,1:2);
 writematrix(cent_gt(k,:),'Centroid.xlsm','WriteMode','append');
end

%% 生成groundtruth和predicted centroid的对比图
%Without bbox
%originalImage = imread('D:\IC\BioMedical\Individual Project\Code\Centroid\CEUS\CEUS92.jpg');

%With bbox
originalImage = imread('D:\IC\BioMedical\Individual Project\Code\Centroid\Pred_bbox\CEUS62.jpg');
originalImage = mat2gray(originalImage,[0 256]);

figure(1)
imshow(originalImage)
title('Predicted (red) and GroungTruth (blue) Centroids'); 
hold on

for k = 1:length(Files)
    plot(F_cent(k,1), F_cent(k,2), 'r*')  %Red
    plot(gt(k,1), gt(k,2), 'bo')                  %Blue
end
hold off
