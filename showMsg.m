function [  ] = showMsg( judge )
%showMsg Summary of this function goes here
%
% Tell the user the result.
%
% Input: 
%   judge: boolean. Whether succeed or not.
%
% Output:
% 	None
%

if judge
    fprintf('Succeed!\n');
else
    fprintf('Fail.\n');
end

end

