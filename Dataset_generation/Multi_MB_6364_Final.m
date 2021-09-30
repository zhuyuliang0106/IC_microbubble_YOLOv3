%% CEUS
n_MB = 15; % number of bubble each frame
n_f = 1600; % number of frames

%% Normal density
for j = 1:n_f
    [X,Y] = meshgrid(-63:1:64);  % 128*128 grid
    xdata=zeros(size(X,1),size(X,2),2); % create the xdata
    xdata(:, :, 1) = X;  % load the X,Y into xdata
    xdata(:, :, 2) = Y;
    
    %Create background and add noise
    CEUS_ini = zeros(128,128);
    CEUS_ini = CEUS_ini + 0.04 + rand(128,128)*0.09; 
    
    a = (rand(1,n_MB))*25+6;  %(6,31)
    x0 = (rand(1,n_MB)*2-1)*50;  %x0,y0, location of MB
    y0 = (rand(1,n_MB)*2-1)*50;
    
    sigmax = (rand(1,n_MB)*1.5+1.5)*1;  %sigma x, sigma y, shape of MB on x,y axis
    sigmay = (rand(1,n_MB)*1.15+1.1)*1;  %range:(0.9,3.15) to (1,3)
    angle = rand(1,n_MB).*pi;
    %angle = int16(rand(1,n_MB)*11);  %angle, angle between x and ym, 08/03 4 to pi
    %angle = double(angle)*pi/12+0.05; % 0, pi/12, 2*pi/12....11*pi/12 +0.05
 
    for i=1:n_MB
        x_C = [a(i),x0(i),sigmax(i),y0(i),sigmay(i),angle(i)];
        Z_C = D2GaussFunctionRot2(x_C,xdata); % Z_C=Z_CEUS
        CEUS_ini=CEUS_ini+Z_C;   
    end
    
    %导出CEUS
    filename = sprintf ('CEUS%d.jpg',j); 
    filepath=pwd;
    cd('D:\IC\BioMedical\Individual Project\Dataset\MultiMB_Final_Anchor\CEUS');
    imwrite(CEUS_ini,filename); % output the image and name
    cd(filepath);
    %CEUS = Addnoise(CEUS,10);
    %CEUS = imnoise(CEUS,'gaussian',0,0.002); % white noise  

    
    % 导出Label_location,groudtruth
    filename=strcat('Label',int2str(j),'.txt');
    fid=fopen(filename ,'wt');
    
    sigmax_x = zeros(1,20);
    sigmax_y = zeros(1,20);
    sigmay_x = zeros(1,20);
    sigmay_y = zeros(1,20);
    
    width_x = zeros(1,20);
    height_y = zeros(1,20);
    
    %可以利用fprintf函数把数据输入到txt文件中);
    for i = 1:n_MB
        sigmax_r(i) = sigmax(i).*4;%double(int16(sigmax(i).*4)); %4.5-15.75 to 5-15
        sigmay_r(i) = sigmay(i).*4;%double(int16(sigmay(i).*4));
        
        sigmax_x(i) = sigmax_r(i).*(abs(cos(angle(i))));
        sigmax_y(i) = sigmax_r(i).*sin(angle(i));
        sigmay_x(i) = sigmay_r(i).*sin(angle(i));
        sigmay_y(i) = sigmay_r(i).*(abs(cos(angle(i))));
        % choose the longer x and y
        width_x(i) = max(sigmax_x(i),sigmay_x(i));
        height_y(i) = max(sigmax_y(i),sigmay_y(i));

        fprintf(fid,'%f %f %f %f\n',x0(i), y0(i), width_x(i), height_y(i));
    end
    fclose(fid);

end


%% High density _ more overlapped
for j = 1:n_f

    [X_over,Y_over] = meshgrid(-63:1:64);  % 128*128 grid
    xdata_over=zeros(size(X_over,1),size(X_over,2),2); % create the xdata
    xdata_over(:, :, 1) = X_over;  % load the X,Y into xdata
    xdata_over(:, :, 2) = Y_over;
   
    
    %Create background and add noise
    CEUS_over= zeros(128,128);
    CEUS_over = CEUS_over + 0.04 + rand(128,128)*0.09; 
    
    a_over = (rand(1,n_MB))*25+6;
    x0_over = (rand(1,n_MB)*2-1)*25;  %x0,y0, location of MB
    y0_over = (rand(1,n_MB)*2-1)*25;
    
    sigmax_over = (rand(1,n_MB)*1.5+1.5)*1;  %sigma x, sigma y, shape of MB on x,y axis
    sigmay_over = (rand(1,n_MB)*1.15+1.1)*1;  %range:(0.9,3.15) to (1,3)
    %angle_over = int16(rand(1,n_MB)*11);  %angle, angle between x and ym, 08/03 4 to pi
    %angle_over = double(angle_over)*pi/12+0.05; % 0, pi/12, 2*pi/12....11*pi/12 +0.05
    angle_over = rand(1,n_MB)*pi;

    for i=1:n_MB
        x_C_over = [a_over(i),x0_over(i),sigmax_over(i),y0_over(i),sigmay_over(i),angle_over(i)];
        Z_C_over = D2GaussFunctionRot2(x_C_over,xdata_over); % Z_C=Z_CEUS
        CEUS_over=CEUS_over+Z_C_over;
    end
    
    %导出CEUS
    j_over = j + n_f;
    filename = sprintf ('CEUS%d.jpg',j_over); 
    filepath=pwd;
    cd('D:\IC\BioMedical\Individual Project\Dataset\MultiMB_Final_Anchor\CEUS');
    imwrite(CEUS_over,filename); % output the image and name
    cd(filepath);
    %CEUS = Addnoise(CEUS,10);
    %CEUS = imnoise(CEUS,'gaussian',0,0.002); % white noise  

    
    % 导出Label_location,groudtruth
    filename=strcat('Label',int2str(j_over),'.txt');
    fid=fopen(filename ,'wt');
    
    sigmax_x_over = zeros(1,20);
    sigmax_y_over = zeros(1,20);
    sigmay_x_over = zeros(1,20);
    sigmay_y_over = zeros(1,20);
    
    width_x_over = zeros(1,20);
    height_y_over = zeros(1,20);
    
    %可以利用fprintf函数把数据输入到txt文件中);
    for i = 1:n_MB
        sigmax_r_over(i) = sigmax_over(i).*4;%double(int16(sigmax_over(i).*4)); %4.5-15.75 to 5-15
        sigmay_r_over(i) = sigmay_over(i).*4;%double(int16(sigmay_over(i).*4));
        
        sigmax_x_over(i) = sigmax_r_over(i).*(abs(cos(angle_over(i))));
        sigmax_y_over(i) = sigmax_r_over(i).*sin(angle_over(i));
        sigmay_x_over(i) = sigmay_r_over(i).*sin(angle_over(i));
        sigmay_y_over(i) = sigmay_r_over(i).*(abs(cos(angle_over(i))));
        % choose the longer x and y
        width_x_over(i) = max(sigmax_x_over(i),sigmay_x_over(i));
        height_y_over(i) = max(sigmax_y_over(i),sigmay_y_over(i));

        fprintf(fid,'%f %f %f %f\n',x0_over(i), y0_over(i), width_x_over(i), height_y_over(i));
    end
    fclose(fid);
    
end
%GroundTruth = [x0',y0',sigmax',sigmay',a',angle'];
%save('GroundTruth.mat','GroundTruth');       % Save data as mat
%writematrix(GroundTruth,'GroundTruth_multi.xls');  % Save data into Excel
%readmatrix('GroundTruth_multi.xls');              % Read data from Excel

    %figure
    %imshow(CEUS);
    %Label = imresize(Label,8,'method','nearest');
    %figure(2)
    %imshow(Label);
    %for i = 1:20
    %text(x0(i)+63,y0(i)+63,['（',num2str(x0(i)),',',num2str(y0(i)),'）'],'color','red','Fontsize',10)
    %end