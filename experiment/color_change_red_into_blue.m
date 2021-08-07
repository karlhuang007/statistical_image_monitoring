% Converts RGB image to HSV colorspace, then changes red to blue, and purple to green.
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 20;

% Check that user has the Image Processing Toolbox installed.
hasIPT = license('test', 'image_toolbox');   % license('test','Statistics_toolbox'), license('test','Signal_toolbox')
if ~hasIPT
	% User does not have the toolbox installed.
	message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
	reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
	if strcmpi(reply, 'No')
		% User said No, so exit.
		return;
	end
end

%===============================================================================
% Read in a standard MATLAB color demo image.
folder = fileparts(which('peppers.png')); % Determine where demo folder is (works with all versions).
baseFileName = 'peppers.png';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
if ~exist(fullFileName, 'file')
	% Didn't find it there.  Check the search path for it.
	fullFileName = baseFileName; % No path this time.
	if ~exist(fullFileName, 'file')
		% Still didn't find it.  Alert user.
		errorMessage = sprintf('Error: %s does not exist.', fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end
rgbImage = imread(fullFileName);
% Get the dimensions of the image.  numberOfColorBands should be = 3.
[rows, columns, numberOfColorChannels] = size(rgbImage)
% Display the original color image.
subplot(2, 3, 1);
imshow(rgbImage);
axis on;
title('Original Color Image', 'FontSize', fontSize, 'Interpreter', 'None');
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'Outerposition', [0, 0.05, 1, .95]);
drawnow;
hp = impixelinfo();

% Convert to HSV color space
hsvImage = rgb2hsv(rgbImage);
% Extract components:
hueImage = hsvImage(:, :, 1);
saturationImage = hsvImage(:, :, 2);
valueImage = hsvImage(:, :, 3);

% Display the HSV images
subplot(2, 3, 2);
imshow(hueImage);
hp = impixelinfo();
title('H Channel Image', 'FontSize', fontSize, 'Interpreter', 'None');
subplot(2, 3, 3);
imshow(saturationImage);
hp = impixelinfo();
title('S Channel Image', 'FontSize', fontSize, 'Interpreter', 'None');
subplot(2, 3, 6);
imshow(valueImage);
hp = impixelinfo();
% axis on;
title('V Channel Image', 'FontSize', fontSize, 'Interpreter', 'None');

% "Increase" hue.
someFactor = 1.6; % Whatever you want.
hueImage = hueImage * someFactor;
% Wrap around if it goes more than 1.
% moreThan1 = hueImage > 1;
% imshow(moreThan1);
hueImage = mod(hueImage, 1);
% Display the New hue image
subplot(2, 3, 5);
imshow(hueImage);
hp = impixelinfo();
title('New H Channel Image', 'FontSize', fontSize, 'Interpreter', 'None');

% Recombine original saturation and value channels
% with new hue channel.
hsvImage = cat(3, hueImage, saturationImage, valueImage);
% Convert back to RGB color space.
rgbImage = hsv2rgb(hsvImage);
% Display the image.
subplot(2, 3, 4);
imshow(rgbImage);
hp = impixelinfo();
axis on;
title('Hue "Increased" Image', 'FontSize', fontSize, 'Interpreter', 'None');
