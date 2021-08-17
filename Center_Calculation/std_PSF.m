%建立PSF的输入图
[X,Y] = meshgrid(-3:1:3);  % 128*128 grid
xdata=zeros(size(X,1),size(X,2),2); % create the xdata
xdata(:, :, 1) = X;  % load the X,Y into xdata
xdata(:, :, 2) = Y;

CEUS=zeros(7,7); % 背景图，128*128，值均为0

x1 = [12, 0, 1.4, 0, 1.4, 0];
%x1_2 = [120, 2, 1, 2, 2, 0];
%x1 = [Amplitude, x, diameter_x, y, diameter_y, angle]
Z1 = D2GaussFunctionRot2(x1,xdata);%将参数输入PSF中，得到模糊的白点
%Z1_2 = D2GaussFunctionRot2(x1_2,xdata);
CEUS = CEUS+Z1;  %+Z1_2;
%Z1 = Z1+CEUS;%将PSF的输出添加到背景图上
figure(1)
imshow(CEUS);

imwrite(CEUS,'std_PSF.png');

