# Edge-Detection-Ant-Colony-Optimization
This is an image processing edge detection technique.

This approach for edge detection using Ant Colony Optimization (ACO) algorithm is used to obtain a well-connected image edge map. Initially, the edge map of the image is obtained using various matlab toolbox conventional edge detectors & adaptive thresholding. The end points obtained using such detectors are calculated. The ants are then placed at these points. The movement of the ants is guided by the local variation in the pixel intensity values. The probability factor of only undetected neighboring pixels is taken into consideration while moving an ant to the next probable edge pixel. The two stopping rules are implemented to prevent the movement of ants through the pixel already detected.
