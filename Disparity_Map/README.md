I used 2 grayscale images (Left and Right) and converted them into their disparity map.
Process:
1. Convert Image (Left and Right) into rank Transformed Image using 5X5 window.
2. Use Rank transformed Image to calculate SAD (Sum of Absolute Difference) by taking Right Image as refrence and sliding window in Left image.
    For this I considered 3X3 window and 15X15 window and compared their outputs.
    This step helps in detecting the corresponding pixels in left image.
3. Used sad values to find minimum disparity value and stored into new image to form disparity map.
