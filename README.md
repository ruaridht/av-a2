# Image Processing and Classification (AV2) #
Luke Brown & Ruaridh Thomson

Image processing techniques and a simple Naive Bayes classifier, done in MATLAB.
(For Advanced Vision, UG4)

## What does it do? ##
* detects a moving hand against a background (using background removal)
* computes a bounding box that surrounds the moving hand/arm in all frames in a given action (i.e. all frames in a subdirectory).
* computes a Motion History Image for the action,
* computes a moment invariant descriptor of the motion,
* trains and tests a Naive Bayes classifier for the three actions (rock, paper, scissors).