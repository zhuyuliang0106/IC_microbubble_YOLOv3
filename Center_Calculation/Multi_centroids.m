
%% 读取pred_label的数据x1,y1, 用于确定每个bubble在图中的位置

cd('D:\IC\BioMedical\Individual Project\Code\Centroid\Pred_Label');
pred_label_dinfo = dir('*.txt');

cd('D:\IC\BioMedical\Individual Project\Code\Centroid\Groundtruth');
GT_dinfo = dir('*.txt');

cd('D:\IC\BioMedical\Individual Project\Code\Centroid\CEUS');
CEUS_dinfo = dir('*.jpg');
mis = 0;

for K = 1 : length(pred_label_dinfo)
  A_name = pred_label_dinfo(K).name;  %just the name
  %fprintf( 'File #%d, "%s"\n', K, thisfilename); 
  cd('D:\IC\BioMedical\Individual Project\Code\Centroid\Pred_Label');
  A = load(A_name);
  
  B_name = GT_dinfo(K).name;  %just the name
  %fprintf( 'File #%d, "%s"\n', k, thisfilename);
  cd('D:\IC\BioMedical\Individual Project\Code\Centroid\Groundtruth');
  B = load(B_name);
  B = B+64;
  gt = B(:,1:2); 
  
  C_name = CEUS_dinfo(K).name;
  
  cd('D:\IC\BioMedical\Individual Project\Code\Centroid\Pred_Bubble'); 
  Files=dir('CEUS*.*'); 
  R_cent =zeros(15,2);  %用于读取完整centroids列表的数组
  F_cent =zeros(15,2);  %最终的centroid
  cent_gt =zeros(15,4);
  A_cent = A(:,1:2);    %为每个centroid提供对应bubble的起始位置
  for k = 1:15
      FileNames = sprintf('%s_Bubble_%d.jpg', C_name, k-1);
      cd('D:\IC\BioMedical\Individual Project\Code\Centroid\Pred_Bubble'); 
      I= imread(FileNames); 
      I = mat2gray(I,[0 256]);
      BW = imbinarize(I,0.4);
      s = regionprops(BW,I,{'Centroid','WeightedCentroid'});
      %s = regionprops(BW,I,{'Centroid','WeightedCentroid'});
      centroids = cat(1,s.Centroid);
      if length(centroids) == 0
          centroids = [0,0];
          mis = mis +1;
      end
      R_cent(k,:) = centroids(1,:);                 %centroid列表
      F_cent(k,1) = R_cent(k,1)+A_cent(k,1);   %计算最终正确的centroid位置
      F_cent(k,2) = R_cent(k,2)+A_cent(k,2);
      cent_gt(k,1:2) = F_cent(k,1:2);          % centroid vs groundtruth
      cent_gt(k,3:4) = gt(k,1:2);
      cd('D:\IC\BioMedical\Individual Project\Code\Centroid\Output'); 
      writematrix(cent_gt(k,:),'Centroid.xlsm','WriteMode','append');
  end
  
  FileNames = sprintf('%s', C_name);
  cd('D:\IC\BioMedical\Individual Project\Code\Centroid\Pred_bbox'); 
  originalImage = imread(FileNames);
  originalImage = mat2gray(originalImage,[0 256]);

  figure('Name',C_name)
  set(gcf,'outerposition',get(0,'screensize'));
  imshow(originalImage)
  title('Predicted (red) and GroungTruth (blue) Centroids'); 
  hold on

  for k = 1:15
      plot(F_cent(k,1), F_cent(k,2), 'r*')  %Red
      plot(gt(k,1), gt(k,2), 'bo')          %Blue
  end
  hold off
  
  cd('D:\IC\BioMedical\Individual Project\Code\Centroid\Output\nobox'); 
  ImageNames = sprintf('%s', C_name);
  saveas(gcf,ImageNames);
end

