function DrawCenterline_Fig(Folder, frame_seq)
% Draw centerline and save into figure

close all;

Image_Folder = [Folder 'images\'];
Centerline_Folder = [Folder 'centerline\'];

% Parameters setting
    % image_format = '.tiff';
    % seq = GetImageSeq(Image_Folder,image_format);
    % image_time = seq.image_time;
    % prefix = seq.image_name_prefix;
image_filenames = dir([Image_Folder '*' '.tiff']);
image_num = length(image_filenames);
image_time  = zeros(image_num,1);
for i=1:image_num
    image_name = image_filenames(i).name(1:(end-5));
    % processing char array of image name
    image_time (i) = str2double(image_name);
end
image_time = sort(image_time);


% figure paramters
line_width = 1.5;
marker_size = 5;

worm_regions = load([Folder 'WormRegionPos.mat']);
worm_regions = worm_regions.worm_regions;

for i=1:length(frame_seq)
    index = frame_seq(i);
    
    image_name = [Image_Folder num2str(index) '.tiff'];
    image = imread(image_name);
    image = image(worm_regions(index+1,1):worm_regions(index+1,2),worm_regions(index+1,3):worm_regions(index+1,4));
        
    centerline_name = [Centerline_Folder num2str(index) '.mat'];
    if ~exist(centerline_name, 'file')
        disp(['Image ' num2str(index) ' has no centerline data']);
        continue;
    end
    data = load(centerline_name);
    centerline = data.centerline;
    
%     % add worm region to centerline
%     centerline = centerline + ...
%         repmat([worm_region(i-Start_Index+1,1) worm_region(i-Start_Index+1,3)], length(centerline),1);
%    image = image(worm_region(i-Start_Index+1,1):worm_region(i-Start_Index+1,2),...
%                    worm_region(i-Start_Index+1,3):worm_region(i-Start_Index+1,4));
    
    imshow(image);colormap(gray);axis image;axis off;hold on;
    plot(centerline(:,2),centerline(:,1),'b-','LineWidth',line_width);hold on;
    plot(centerline(1,2),centerline(1,1),'r.','MarkerSize',marker_size,'LineWidth',line_width);

%     if (mod(i,50) == 0)
%         cla reset;
%     end

%     plot(worm_centroid(i-Start_Index+1,2), worm_centroid(i-Start_Index+1,1),...
%         'gs','MarkerSize',marker_size,'LineWidth',line_width);
%     plot(centerline(points_num,2),centerline(points_num,1),'go','MarkerSize',marker_size,...
%         'LineWidth',line_width);
    title(['Image ' num2str(index)]);
    hold off;
    %saveas(gcf,[Folder 'fig\Fig_' num2str(index) '.tiff']);
    saveas(gcf,[Folder 'fig\'  num2str(index) '.tiff']);
end
end

