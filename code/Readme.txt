In Phase_I folder:
There are 4  *_main.m file:
Phase_I_max_variance_color_main.m： maximum variance based X control chart in Phase I with different color samples
Phase_I_max_variance_main.m :            maximum variance based X control chart in Phase I with original samples
Phase_I_T2_color_main.m:                     wavelet based Hotelling T2 control chart in Phase I with different color samples
Phase_I_T2_main.m:                              wavelet based Hotelling T2 control chart in Phase I with original samples

In Phase_II folder:
There are also 4  *_main.m file:
Phase_II_max_variance_color_main.m： maximum variance based X control chart in Phase II with different color samples
Phase_II_max_variance_main.m :            maximum variance based X control chart in Phase II with original samples
Phase_II_T2_color_main.m:                     wavelet based Hotelling T2 control chart in Phase II with different color samples
Phase_II_T2_main.m:                              wavelet based Hotelling T2 control chart in Phase II with original samples

Both folder have 4 function.m file:
haar2_wavelet.m :                                This function take an original image as input and apply 2-D haar wavelet on the input image and output 3 maximal coefficient of 3 detail coefficinet matrix.
haar2_wavelet_color.m :                       This function take an color changed image as input and apply 2-D haar wavelet on the input image and output 3 maximal coefficient of 3 detail coefficinet matrix.
max_variance_of_colorpic.m :               This function take an color changed image as input and apply sliding-window approach to extract the maximum variance of the input image and output it.
max_variance_of_pic.m :                       This function take an original image as input and apply sliding-window approach to extract the maximum variance of the input image and output it.