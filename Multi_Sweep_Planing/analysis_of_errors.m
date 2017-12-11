function [ mean_error, error_map ] = analysis_of_errors( base_map, predicted_map )
%analysis_of_errors Given a base_map as ground truth and a predicted_map as
%a predictor, plot a Histogram, And Error map of errors - and return mean
%error with the error map
error_map = abs(base_map - predicted_map);
mean_error = mean(error_map(:));
error_vec = error_map(:);

% Display Hisogram
display('Histogram');
histogram(error_vec);

% Display Error Map
display('Error Map');
figure;
imagesc(error_map); 
colormap jet; 

end

