function update_index = UpdateCenterline_ByHand(Folder)
% Update curve (may be centerline, boundary), new curve are determined by hand
% Hint: Be carefully with the index of image and centerline!!!

Partition_Num = 49;
line_width = 0.5;
marker_size = 5;

Image_Folder = [Folder 'images\'];
Curve_Folder = [Folder 'centerline\'];
Check_Folder = [Folder 'error\'];

% Image_Seq = GetImageSeq(Image_Folder,'.tiff');
% image_time = Image_Seq.image_time;
% image_prefix = Image_Seq.image_name_prefix;
% 
% Seq = GetImageSeq(Check_Folder,'.tiff.txt');
% seq_index = Seq.image_time;
% curve_prefix = Seq.image_name_prefix;

worm_regions = load([Folder 'WormRegionPos.mat']);
worm_regions = worm_regions.worm_regions;

image_filenames = dir([Image_Folder '*' '.tiff']);
image_num = length(image_filenames);
image_time  = zeros(image_num,1);
for i=1:image_num
    image_name = image_filenames(i).name(1:(end-5));
    % processing char array of image name
    image_time (i) = str2double(image_name);
end
image_time = sort(image_time);

image_filenames = dir([Check_Folder '*' '.tiff.txt']);
image_num = length(image_filenames);
seq_index  = zeros(image_num,1);
for i=1:image_num
    image_name = image_filenames(i).name(1:(end-9));
    % processing char array of image name
    seq_index (i) = str2double(image_name);
end
seq_index = sort(seq_index);

update_index = zeros(1,length(seq_index));

for i=1:length(seq_index)
    curve_index = seq_index(i);
    % curve_file = [Res_Folder curve_prefix num2str(curve_index) '.mat'];
    
    % Load curve file
%     curve = load([Check_Folder num2str(curve_index) '.tiff.txt']);
    curve = load([Check_Folder num2str(curve_index) '.tiff.txt']);
    curve = spline_fitting_partition(curve,Partition_Num);

    % Get by ImageJ, data is [x,y]
    centerline = zeros(size(curve));
    centerline(:,1) = curve(:,2);% change [x,y] to [y,x]
    centerline(:,2) = curve(:,1);
%     save([Curve_Folder num2str(curve_index-1) '.mat'],'centerline');
    
    % Save the curve
    index = find(curve_index == image_time);
    update_index(i) = index;
    
    % redraw the centerline figure
    image = imread([Check_Folder num2str(curve_index) '.tiff']);
    imshow(image);colormap(gray);axis image;axis off;hold on;
    plot(centerline(:,2),centerline(:,1),'b-','LineWidth',line_width);hold on;
    plot(centerline(1,2),centerline(1,1),'r.','MarkerSize',marker_size,'LineWidth',line_width);
    title(['Image ' num2str(image_time(index))]);
    hold off;
    saveas(gcf,[Folder 'fig\' num2str(image_time(index)) '.tiff']);

    
    %out_file = [Curve_Folder num2str(index) '.mat'];
    out_file = [Curve_Folder num2str(image_time(index)) '.mat'];
    save(out_file,'centerline');
    
    % wirte centerline into text file
    filename = [Folder 'centerline_txt\' num2str(index) '.txt'];
    dump_centerline(centerline,filename);
end

end