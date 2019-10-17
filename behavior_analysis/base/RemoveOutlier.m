function out = RemoveOutlier(data)

winsize = 30;        % 1 second, ���ݴ���
outlier_ratio = 1.5; % �쳣ֵϵ��(�ֲ���׼����ֲ�����ƫ��ı���ϵ����

out = private_remove_outlier(data, winsize, outlier_ratio);

end

function out = private_remove_outlier(data, winsize, outlier_ratio)
% Inner function: remove outlier by std and mean value of data

T = length(data);
out = data;
for i=1:T-winsize
    local_data = data(1:i+winsize-1);
    local_mean = mean(local_data);
    local_median = median(local_data);
    local_std = std(local_data);
    local_data(abs(local_data - local_mean) > outlier_ratio*local_std) = local_median;
    out(1:i+winsize-1) = local_data;
end

end