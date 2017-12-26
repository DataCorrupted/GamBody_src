function [ score ] = position_score( position_1, position_2 )

% disp (strcat('norm =', num2str(norm(position_1 - position_2))));

dist = norm(position_1 - position_2);
if (dist < 100)
    score = 100;
    return;
end
if (dist < 300)
    score = 80;
    return;
end
if (dist < 400)
    score = 50;
    return;
end
if (dist < 600)
    score = 30;
    return;
end

score = 0;

end

