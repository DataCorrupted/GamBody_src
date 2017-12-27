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

(Openpose)[https://github.com/CMU-Perceptual-Computing-Lab/openpose] is used in our project. Cuda is required for this program to run. You also need to fill bin/ and model/ with files in the [link](http://posefs1.perception.cs.cmu.edu/OpenPose/OpenPose_demo_1.0.1.zip).

Please leave tmp/ unchanged or MATLAB will have no permission to generate temp files.

<video id="video" controls="" preload="none" poster="http://media.w3.org/2010/05/sintel/poster.png">
      <source id="mp4" src="http://media.w3.org/2010/05/sintel/trailer.mp4" type="video/mp4">
      <source id="webm" src="http://media.w3.org/2010/05/sintel/trailer.webm" type="video/webm">
      <source id="ogv" src="http://media.w3.org/2010/05/sintel/trailer.ogv" type="video/ogg">
      <p>Your user agent does not support the HTML5 Video element.</p>
    </video>

<video id="video" controls="" preload="none" poster="demo/success.png">
    <source id="mp4" src="demo/v2.0.mp4" type="video/mp4">
</video>