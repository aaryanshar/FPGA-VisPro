imagepath = 'C:\Users\HP\Documents\MATLAB\sample\sample.bmp';

image_data = imread(imagepath); 


[height, width, ~] = size(image_data);


a = zeros(height * width * 3, 1);

k = 1;
for i = height:-1:1
    for j = 1:width
        a(k) = image_data(i, j, 1);
        a(k + 1) = image_data(i, j, 2);
        a(k + 2) = image_data(i, j, 3);
        k = k + 3;
    end
end


outputpath = 'C:\Users\HP\Documents\MATLAB\sample_img.hex';
fid = fopen(outputpath, 'wt');
fprintf(fid, '%x\n', a);
fclose(fid);

disp('Text file written. Task done!');

