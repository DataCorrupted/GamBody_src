# GamBody_src
Source file, test set goes here.
All develop work should happen under branch dev.

	git checkout dev

For details of this project, check our [document](https://github.com/DataCorrupted/GamBody_doc)

# Requirements and Usage
Now this game works best in Windows 10. You can try modify it to work on Ubuntu or Mac
This is able to run by 

	main

You can specify preparing time by typing:

	main(time)

[Openpose](https://github.com/CMU-Perceptual-Computing-Lab/openpose) is used in our project. Cuda is required for this program to run. You also need to fill bin/ and model/ with files in the [link](http://posefs1.perception.cs.cmu.edu/OpenPose/OpenPose_demo_1.0.1.zip).

Please leave tmp/ unchanged or MATLAB will have no permission to generate temp files.

# Demo
<p align="center">
  <a href="https://www.youtube.com/watch?v=bjdkzoLk7e8&feature=youtu.be">
	  <img src="https://img.youtube.com/vi/bjdkzoLk7e8/0.jpg">
  </a>
</p>

# Branch Spec
v1.0 is our first implementation and it's naive.

v2.0 is the most stable version, which is the same with master.

v2.1 is the version with cloth added.

v2.2 is the version with noise cancellation (body region tracking).

# Contact
Any bug founded, feel free to contact any of the contributors.