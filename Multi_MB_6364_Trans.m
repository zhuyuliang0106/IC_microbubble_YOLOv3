%% CEUS
n_MB = 15; % number of bubble each frame
n_f = 120; % number of frames
Trans = 6;

for j = 1:n_f
    [X,Y] = meshgrid(-63:1:64);  % 128*128 grid
    xdata=zeros(size(X,1),size(X,2),2); % create the xdata
    xdata(:, :, 1) = X;  % load the X,Y into xdata
    xdata(:, :, 2) = Y;
    
    j_right = j + n_f;
    j_left = j + 2*n_f;
    j_up = j + 3*n_f;
    j_down = j + 4*n_f;
    
    %Create background and add noise
    CEUS_ini = zeros(128,128);
    CEUS_ini = CEUS_ini + 0.04 + rand(128,128)*0.08; 
    CEUS_right = zeros(128,128);
    CEUS_right = CEUS_right + 0.04 + rand(128,128)*0.08;
    CEUS_left = zeros(128,128);
    CEUS_left = CEUS_left + 0.04 + rand(128,128)*0.08;
    CEUS_up = zeros(128,128);
    CEUS_up = CEUS_up + 0.04 + rand(128,128)*0.08;
    CEUS_down = zeros(128,128);
    CEUS_down = CEUS_down + 0.04 + rand(128,128)*0.08;
    
    %Label=zeros(128,128);
    
    a = (rand(1,n_MB)+1)*9;
    x0 = (rand(1,n_MB)*2-1)*50;  %x0,y0, location of MB
    y0 = (rand(1,n_MB)*2-1)*50;
    sigmax = (rand(1,n_MB)*1.5+0.6)*1.5;  %sigma x, sigma y, shape of MB on x,y axis
    sigmay = (rand(1,n_MB)*1.5+0.6)*1.5;  %range:(0.9,3.15)
    angle=rand(1,n_MB)*pi;  %angle, angle between x and ym, 08/03 4 to pi

    x0_right=zeros(1,n_MB);    
    x0_right = x0 + Trans;
    x0_left=zeros(1,n_MB);    
    x0_left = x0 - Trans;
    y0_up=zeros(1,n_MB);    
    y0_up = y0 - Trans;
    y0_down=zeros(1,n_MB);    
    y0_down = y0 + Trans;
    

    for i=1:n_MB
        x_C = [a(i),x0(i),sigmax(i),y0(i),sigmay(i),angle(i)];
        Z_C = D2GaussFunctionRot2(x_C,xdata); % Z_C=Z_CEUS
        CEUS_ini=CEUS_ini+Z_C;
        
        x_C_right = [a(i),x0_right(i),sigmax(i),y0(i),sigmay(i),angle(i)];
        Z_C_right = D2GaussFunctionRot2(x_C_right,xdata);
        CEUS_right=CEUS_right+Z_C_right;
        
        x_C_left = [a(i),x0_left(i),sigmax(i),y0(i),sigmay(i),angle(i)];
        Z_C_left = D2GaussFunctionRot2(x_C_left,xdata);
        CEUS_left=CEUS_left+Z_C_left;
        
        x_C_up = [a(i),x0(i),sigmax(i),y0_up(i),sigmay(i),angle(i)];
        Z_C_up = D2GaussFunctionRot2(x_C_up,xdata);
        CEUS_up=CEUS_up+Z_C_up;
        
        x_C_down = [a(i),x0_right(i),sigmax(i),y0_down(i),sigmay(i),angle(i)];
        Z_C_down = D2GaussFunctionRot2(x_C_down,xdata);
        CEUS_down=CEUS_down+Z_C_down;
             
        %x_L = [140,x0(i),0.15,y0(i),0.15,0];
        %Z_L = D2GaussFunctionRot2(x_L,xdata); % Z_L=Z_label
        %Label=Label+Z_L;
    end
    
    %CEUS = Addnoise(CEUS,10);
    %CEUS = imnoise(CEUS,'gaussian',0,0.002); % white noise
    
    %导出CEUS
    filename = sprintf ('CEUS%d.jpg',j); 
    filepath=pwd;
    cd('D:\IC\Biomedical\Individual Project\Dataset\MultiMBTS\CEUS');
    imwrite(CEUS_ini,filename); % output the image and name
    cd(filepath);
    
    filename = sprintf ('CEUS%d.jpg',j_right); 
    filepath=pwd;
    cd('D:\IC\Biomedical\Individual Project\Dataset\MultiMBTS\CEUS');
    imwrite(CEUS_right,filename); % output the image and name
    cd(filepath);
    
    filename = sprintf ('CEUS%d.jpg',j_left); 
    filepath=pwd;
    cd('D:\IC\Biomedical\Individual Project\Dataset\MultiMBTS\CEUS');
    imwrite(CEUS_left,filename); % output the image and name
    cd(filepath);
    
    filename = sprintf ('CEUS%d.jpg',j_up); 
    filepath=pwd;
    cd('D:\IC\Biomedical\Individual Project\Dataset\MultiMBTS\CEUS');
    imwrite(CEUS_up,filename); % output the image and name
    cd(filepath);
    
    filename = sprintf ('CEUS%d.jpg',j_down); 
    filepath=pwd;
    cd('D:\IC\Biomedical\Individual Project\Dataset\MultiMBTS\CEUS');
    imwrite(CEUS_down,filename); % output the image and name
    cd(filepath);
    %导出label_image
    %filename = sprintf ('Label%d.jpg',j); 
    %filepath=pwd;
    %cd('D:\IC\Biomedical\Individual Project\Dataset\MultiMB\Label_image');
    %imwrite(Label,filename); % output the image and name
    %cd(filepath);
    
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
        sigmax_r(i) = sigmax(i).*5;
        sigmay_r(i) = sigmay(i).*5;
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
    
    
    % right version txt
    filename=strcat('Label',int2str(j_right),'.txt');
    fid=fopen(filename ,'wt');
   
    
    %可以利用fprintf函数把数据输入到txt文件中);
    for i = 1:n_MB
        fprintf(fid,'%f %f %f %f\n',x0_right(i), y0(i), width_x(i), height_y(i));
    end
    fclose(fid);
    
    % left version txt
    filename=strcat('Label',int2str(j_left),'.txt');
    fid=fopen(filename ,'wt');
    
    %可以利用fprintf函数把数据输入到txt文件中);
    for i = 1:n_MB
        fprintf(fid,'%f %f %f %f\n',x0_left(i), y0(i), width_x(i), height_y(i));
    end
    fclose(fid);
    
    % up version txt
    filename=strcat('Label',int2str(j_up),'.txt');
    fid=fopen(filename ,'wt');
    
    %可以利用fprintf函数把数据输入到txt文件中);
    for i = 1:n_MB
        fprintf(fid,'%f %f %f %f\n',x0(i), y0_up(i), width_x(i), height_y(i));
    end
    fclose(fid);
    
    % down version txt
    filename=strcat('Label',int2str(j_down),'.txt');
    fid=fopen(filename ,'wt');
    
    %可以利用fprintf函数把数据输入到txt文件中);
    for i = 1:n_MB
        fprintf(fid,'%f %f %f %f\n',x0(i), y0_down(i), width_x(i), height_y(i));
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