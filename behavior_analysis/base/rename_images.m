function rename_images(Folder,OutFolder)

image_format = '.tif';
image_names = dir([Folder '*' image_format]);

for i=0:length(image_names)-1
    copyfile([Folder image_names(i+1).name],[OutFolder num2str(str2num(image_names(i+1).name(end-7:end-4))) '.tiff']);
    disp(['Proccessing: ' num2str(i+1) '/' num2str(length(image_names))]);
end
end