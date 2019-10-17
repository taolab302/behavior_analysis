function [binary_image, worm_xy_range] =...
    Denoise_And_Worm_Locate(binary_image_whole, worm_area)
% remove the noise outside and inside worm body

% define the hole (because of worm touched itself) area portition to the whole worm area
hole_portition = 0.05; 
hole_area = worm_area*hole_portition;

% ---------------------ѡ���߳����򣬲�ȥ��ͼ���ӵ�-------------------
[height,width] = size(binary_image_whole);
cc = bwconncomp(binary_image_whole);
worm_index = 1;
if cc.NumObjects > 1
    area_diff = zeros(cc.NumObjects, 1);
    for num = 1:cc.NumObjects
        area_diff(num) = abs(length(cc.PixelIdxList{num}) - worm_area);
    end
    worm_index = find(area_diff == min(area_diff), 1);
%     % ���������̫������Ϊû�ҵ��߳�
%     if area_diff(worm_index) > area_diff_thres*worm_area
%         binary_image = false(size(binary_image_whole));
%         worm_xy_range = [1,512,1,512];
%         return;
%     end
    for num = 1:cc.NumObjects
        if num ~= worm_index
             binary_image_whole(cc.PixelIdxList{num}) = 0;
        end
    end
end

if cc.NumObjects >= 1
    % ---------------------��ȡ�߳渽������Ķ�ֵͼ��-----------------------
    % ���߳�����������һά����õ�ÿ�������������
    worm = cc.PixelIdxList{worm_index};
    worm_row = mod(worm, height);
    worm_column = ceil(worm / height);

    % �����߳������������ĩ���Լ���ĩ��
    margin = 10;
    row_min = max(min(worm_row) - margin, 1);
    row_max = min(max(worm_row) + margin, height);
    column_min = max(min(worm_column) - margin, 1);
    column_max = min(max(worm_column) + margin, width);

    % ��ȡ�߳��������򣬲����������귶Χ
    binary_image = binary_image_whole;
    % binary_image = binary_image_whole(row_min:row_max,column_min:column_max);
    worm_xy_range = [row_min, row_max, column_min, column_max];
    % binary_image = binary_image_whole;
    % worm_xy_range= [1,height,1,width];

    % ----------------------����߳������ڲ��Ŀհ��ӵ�-----------------------
    binary_image = ~bwareaopen(~binary_image, floor(hole_area));
    % worm_area = length(find(binary_image == 1));
else
    binary_image = false(size(binary_image_whole));
    worm_xy_range = [1,height,1,width];
end

end