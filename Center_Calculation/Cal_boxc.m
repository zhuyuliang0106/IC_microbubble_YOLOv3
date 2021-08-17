% Bbox center calculation
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%读取pred_label的数据x1,y1, 用于确定每个bubble在图中的位置
fileID = fopen('D:\IC\BioMedical\Individual Project\Code\Box_center\Pred_Label\CEUS62_label.txt','r');
formatSpec = '%d %d %d %d';
sizeA = [4,15];
A = fscanf(fileID,formatSpec,sizeA);
A = A';  %A:xmin, ymin, xmax, ymax
fclose(fileID);

%% 读取groundtruth
fileID_gt = fopen('D:\IC\BioMedical\Individual Project\Code\Box_center\Groundtruth\Label62.txt','r');
formatSpec_gt = '%f %f %f %f';
sizeB = [4,15];
B = fscanf(fileID_gt,formatSpec_gt,sizeB);
B = B';
B = B+64;
gt = B(:,1:2);    %Groundtruth
fclose(fileID_gt);

%% box_center calculation

R_bc =zeros(15,2);  %用于读取完整box_center
for k = 1:15
    xmin = A(k,1)+1;  % +1 因为python里数据从0开始,MATLAB从1开始
    ymin = A(k,2)+1;
    xmax = A(k,3)+1;
    ymax = A(k,4)+1;
    x = (xmin + xmax)./2;
    y = (ymin + ymax)./2;
    R_bc(k,1) = x;
    R_bc(k,2) = y;
end


%% 生成groundtruth和predicted centroid的对比图
%Without bbox

%With bbox
originalImage = imread('D:\IC\BioMedical\Individual Project\Code\Box_center\Pred_bbox\CEUS62.jpg');
originalImage = mat2gray(originalImage,[0 256]);

figure(1)
imshow(originalImage)
title('Predicted (red) and GroungTruth (blue) Box_center'); 
hold on

for k = 1:15
    plot(R_bc(k,1), R_bc(k,2), 'r*')  %Red
    plot(gt(k,1), gt(k,2), 'bo')          %Blue
end
hold off
