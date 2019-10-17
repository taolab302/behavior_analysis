function reverse_centerline(CenterlineFolder,reverse_index)
% ע��reverse_index�ǰ���ͼ����򣬴���ʱ���������

num = length(reverse_index);
for i=1:num
    image_index = reverse_index(i);
    curve_file = [CenterlineFolder num2str(image_index) '.mat'];
    if ~exist(curve_file,'file')
        continue;
    end

    % reverse and save centerline
    data = load(curve_file);
    centerline = data.centerline(end:-1:1,:);
    save([CenterlineFolder num2str(image_index) '.mat'],'centerline');
    filename = [CenterlineFolder(1:end-11) 'centerline_txt\' num2str(i) '.txt'];
    dump_centerline(centerline,filename);
end
    DrawCenterline_Fig(CenterlineFolder(1:end-11),reverse_index);
end