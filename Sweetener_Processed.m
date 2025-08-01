clear; clc; close all;

% Define the folder path
folder = "C:\Users\hoang\Documents\RU Subjects Senior\Spring 2023 Subjects\Aresty Research\data\SPI-Sweetener processed";
file_list = dir(fullfile(folder, '*.tiff'));

% Define the prefix and suffix of the image names
prefix = 'Image';
suffix = '.tiff';

% Define the number of images in the folder
num_images = length(file_list);
% Define the ROIs (In order: Tube 1, Tube 2, Tube 3, Tube 4)
ROIs = {round([62.297275815253 132.317415119564 276.213793103448 66.8807881773399]),...
        round([59.1839753226422 244.396232853554 271.232512315271 66.8807881773399]),...
        round([58.5613152241201 350.871109700844 274.968472906404 66.8807881773399]),...
        round([60.4292955196866 463.572587533357 271.855172413793 66.8807881773399])};

% Loop over each ROI
for j = 1:length(ROIs)
    
    % Initialize arrays to store the time and intensity values
    time = zeros(num_images, 1);
    intensity = zeros(num_images, ROIs{j}(3)+1);

    % Create a new figure to hold the plots
    figure;
    hold on;

    % Loop over the images
    % Time interval between images is 3 hours (18 images) 
    for i = 1:18:452
        % Construct the filename using sprintf with format string
        filename = fullfile(folder, sprintf('%s%05d%s', prefix, i, suffix));

        % Call the plot_intensity function to plot the intensity of the current image
        [Intensity, dist] = plot_intensity(filename, ROIs{j});

        % Store the intensity values for the current image
        intensity(i, :) = Intensity;

        % Call the plot_intensity function to plot the intensity of the current image
        plot_intensity(filename, ROIs{j});
        title(sprintf('Intensity at each Distance Pixel in Sweetener Processed - Tube %d', j));

    end

    hold off;

    % Create a new figure to hold the derivative plots
    figure;
    hold on;

    % Loop over the images
    for i = 1:18:452
        % Calculate the derivative of intensity with respect to time
        % Store the time value for the current image (assume a time interval of 1)
        time(i,1) = i;
        dy = diff(intensity(i,:))./diff(time);

        % Plot the derivative vs distance
        plot(dist(2:end), dy);
    end

    % Plot the derivative vs distance
    title(sprintf('Derivative of Intensity vs Distance in Sweetener Processed- Tube %d', j));
    xlabel('Distance (pixels)');
    ylabel('Derivative of Gray Value');
    hold off;
end

% FUNCTION HAS FILENAME AND ROI AS INPUTS
function [Intensity, dist] = plot_intensity(file, roi)
    % Read in the image
    img = imread(file);
    rot_img = imrotate(img,-90); %rotate image closewise 90 degree
    
    % Convert to gray scale
    gray_img = im2gray(rot_img);

    % Extract the coordinate of the ROI (Original point on the top left of img)
    x1 = roi(1); % x-coordinate of the upper-left corner of the rectangle.
    y1 = roi(2); % y-coordinate of the upper-left corner of the rectangle.

    % Initialize a matrix to store gray value
    gray_value = zeros(roi(4)+1,roi(3)+1); % #rows x #columns

    % Loop over every pixel in the ROI and calculate the gray value
    for j = 1:roi(3)
        for i = 1:roi(4)
            % Calculate the gray value at each coordinate/pixel
            gray_value(i,j) = gray_img(y1-1+i, x1-1+j);
        end
    end

    % Intensity at each pixel
    Intensity = mean(gray_value); % mean of each column
    % Distance for every pixel
    dist = zeros(1,roi(3)+1);
    for k = 1:(roi(3)+1)
        dist(k) = x1-1+k;
    end
    
%     % Define an array of colors
%     colors = ['r', 'g', 'b', 'm', 'c', 'y', 'k', 'w'];
%     
%     % Get the index of the current file based on the filename
%     [~, name, ~] = fileparts(file);
%     index = str2double(name(6:end));
    
    % Plot Intenity at each distance of pixel with a different color
    plot(dist,Intensity,'LineWidth',2)
    xlabel('Distance (pixels)')
    ylabel('Gray Value') 

end

