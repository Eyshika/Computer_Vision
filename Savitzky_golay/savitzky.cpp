#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include<iostream>
#include<cmath>
using namespace cv;
using namespace std;

int main(int argc, char** argv)
{
Mat im_rgb ; //original image
Mat im_gray; //grayscale image
Mat im_rgb_out;
Mat im_dst; //output image


int ddepth;
Point anchor;
double delta;
int kernel_size;
int order; //polynomial order
int terms; //total number of terms according to order


ddepth=-1; //indicates depth od destination image is similar to original
delta = 0; //value to be added to each pixel after convolution
anchor = Point(-1, -1); //indicates anchor is center that is center point will be changed by output value
kernel_size=5; //5X5 window (ideal)
order=3; //ideal
terms=10; //for order 3

char* window_name1 = "Savitzky Filter";
char* window_name2 ="Original";
char* window_name3= "Grayscale image";
char* window_name4= "Grayscale Output After Smoothing";

namedWindow(window_name1, CV_WINDOW_AUTOSIZE); //create window
namedWindow(window_name2, CV_WINDOW_AUTOSIZE); //create window
namedWindow(window_name3, CV_WINDOW_AUTOSIZE); //create window
namedWindow(window_name4, CV_WINDOW_AUTOSIZE); //create window

im_rgb =imread("/home/ubuntu/Downloads/bridge.jpeg");

//check image
if(!im_rgb.data)
return -1;


cvtColor(im_rgb, im_gray, CV_RGB2GRAY); //convert in grayscale

//create X for 3rd order

Mat X(kernel_size*kernel_size, terms, CV_32FC1);


int i=0; //data

while(i<kernel_size*kernel_size)
{
for(int j=-kernel_size/2;j<=kernel_size/2;j++)
{
for(int k=-kernel_size/2; k<=kernel_size/2; k++)
{
X.at<float>(i,0)=1;
X.at<float>(i,1)=j;
X.at<float>(i,2)=k;
X.at<float>(i,3)=pow(j,2);
X.at<float>(i,4)=pow(k,2);
X.at<float>(i,5)=j*k;
X.at<float>(i,6)=pow(j,3);
X.at<float>(i,7)=pow(k,3);
X.at<float>(i,8)=(pow(j,2))*k;
X.at<float>(i,9)= j*(pow(k,2));

++i;
}
}
}


//create kernel auto values
//float data[5][5]= {{-0.0743, 0.0114, 0.0400, 0.0114, -0.0743},{0.0114, 0.0971, 0.1257, 0.0971, 0.0114},{0.0400, 0.1257, 0.1543, 0.1257, 0.0400}, {0.0114, 0.0971, 0.1257, 0.0971, 0.0411},{-0.0743, 0.0114, 0.0400,  0.0114, -0.0743}};

//Mat kernel(kernel_size, kernel_size, CV_32FC1, data); // (size, size, type: CV_,NO_ofbits,type_of_bits,channel,number_of_channel)

Mat kernel(kernel_size,kernel_size,CV_32FC1);

Mat C= ((X.t()*X).inv())*X.t(); //kernel mathematics

vector<float> vec=C.row(0); //only C00 for smoothing C01 for 1st derivative


memcpy(kernel.data, vec.data(), vec.size()*sizeof(float)); //storing C00 into kernel


float s= cv::sum(kernel)[0];
kernel=kernel/s; //kernel to be convoluted

//float s= cv::sum(kernel)[0]; //0 for 1 channel
//kernel=kernel/s;

filter2D(im_rgb, im_rgb_out,ddepth, kernel, anchor, delta, BORDER_DEFAULT);

filter2D(im_gray, im_dst, ddepth, kernel, anchor, delta, BORDER_DEFAULT);



imshow(window_name1, im_rgb_out );
imshow(window_name2, im_rgb);
imshow(window_name3, im_gray);
imshow(window_name4,im_dst); //show manual created kernel for differentiating
cv::waitKey(0);
return 0;
}
