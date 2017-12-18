function blurIm=gaussian(image, sigma, k)
    kernelSize = round(sigma*3*k - 1); 
    if(kernelSize<1)
        kernelSize = 1; 
    end 
	kernel = fspecial('gaussian', [kernelSize kernelSize], sigma);

	blurIm = imfilter(image,kernel,'replicate');
end