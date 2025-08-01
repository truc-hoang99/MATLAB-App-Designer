clear; clc; close all;
% Read file from input image
img = imread('Intensity.png');
% Convert to gray scale
gray_img = rgb2gray(img);
% Determine size of image
[height, width, channels] = size(gray_img);
% Display image
imshow(gray_img)
% Select the regions
  %h_1 = imrect(gca,[132.657866948258 98.6937697993664 67 268]); %[132, 60, 67, 268]
  %h_1 = drawrectangle('Label','Tube_1','color',[1 0 0]);
  % Use imrect() function to move the rectangle on picture and copy the position of
  % the rectangle area
  h_1 = drawrectangle('Position',[132.657866948258 98.6937697993664 67 268],'StripeColor','r');
  h_2 = drawrectangle('Position',[245.614210740891 100.449567889407 67 268],'StripeColor','g');
  h_3 = drawrectangle('Position',[351.54736217336 99.27903582938 67 268],'StripeColor','b');
  h_4 = drawrectangle('Position',[462.747907875952 101.034833919421 67 268],'StripeColor','y');

 % Create a binary mask of the selected region
 mask1 = createMask(h_1);
 mask2 = createMask(h_2);
 mask3 = createMask(h_3);
 mask4 = createMask(h_4);

% Replicate the mask along the RGB channels of the original image
 % Form 3D array
 mask3d_1 = repmat(mask1, [1 1 3]);
 mask3d_2 = repmat(mask2, [1 1 3]);
 mask3d_3 = repmat(mask3, [1 1 3]);
 mask3d_4 = repmat(mask4, [1 1 3]);

% Extract selected region
 % bsxfun function performs element-wise operations between arrays with 
 % singleton expansion, which allows you to multiply a 2D binary mask with 
 % a 3D image without explicitly replicating the mask.
region1 = bsxfun(@times, gray_img, cast(mask3d_1, 'like', gray_img));
region2 = bsxfun(@times, gray_img, cast(mask3d_2, 'like', gray_img));
region3 = bsxfun(@times, gray_img, cast(mask3d_3, 'like', gray_img));
region4 = bsxfun(@times, gray_img, cast(mask3d_4, 'like', gray_img));

% Display selected region
subplot(2, 2, 1), imshow(region1);
subplot(2, 2, 2), imshow(region2);
subplot(2, 2, 3), imshow(region3);
subplot(2, 2, 4), imshow(region4);

% Calculate the mean grayscale value of each row
z_1 = mean(region1, 2);
z_2 = mean(region2, 2);
z_3 = mean(region3, 2);
z_4 = mean(region4, 2);








