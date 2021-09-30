%% 读取groundtruth

cd('D:\IC\BioMedical\Individual Project\Code\Centroid\Groundtruth');
GT_dinfo = dir('*.txt');

cd('D:\IC\BioMedical\Individual Project\Code\Centroid\CEUS');
CEUS_dinfo = dir('*.jpg');

num_mb = 0;
for K = 1 : length(GT_dinfo)
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
    
    FileNames = sprintf('%s', C_name);
    cd('D:\IC\BioMedical\Individual Project\Code\Centroid\CEUS'); 
    I= imread(FileNames); 
    I = mat2gray(I,[0 256]);
    BW = imbinarize(I,0.5);
    s = regionprops(BW,I,{'Centroid','WeightedCentroid'});
    centroids = cat(1,s.WeightedCentroid);
    
    for k = 1:length(centroids)
        R_cent(k,:) = centroids(k,:);
        cent_gt(k,1:2) = R_cent(k,1:2); 
        
    end
    
    % centroid vs groundtruth
    cent_gt(1:15,3:4) = gt(1:15,1:2);
    cd('D:\IC\BioMedical\Individual Project\Code\Centroid\STD_ULM'); 
    
    writematrix(cent_gt,'Centroid_STDULM.xlsm','WriteMode','append');
      
    num_mb = num_mb + length(centroids);
    
end
