% Configuration: Centerline
Partition_Num = 49; % 默认中心线等分49份，即有50个点

% Configuration: Binarization
Low_Binary_Thres = 2; % 线虫区域低阈值
Hole_Ratio = 0.03;     % 用于填充线虫身体中空洞，
BoundaryWidth = 20;    % 清除图像边缘。如果线虫靠近图像边缘，线虫身体也会被裁切。
Frame_Skip_Thres = 0.35; % 线虫面积若小于初始帧的35%，则将其加入到Skip list中

% Configuration: Worm Speed
% 由于线虫连续运动，因此相邻两帧间的运动量不会很大。一旦相邻两帧偏移量（MAX_LENGTH）较大时，
% 说明线虫区域分割出错。此时，代码会认为这一帧图像计算错误，保持线虫位置不动。
MAX_LENGTH = 50; % pixels

% Configuration: Omega turn
