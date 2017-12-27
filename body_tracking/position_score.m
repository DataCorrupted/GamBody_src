function [ score ] = position_score( position_1, position_2 )

% disp (strcat('norm =', num2str(norm(position_1 - position_2))));

dist = norm(position_1 - position_2);
if (dist < 300)
    score = 100;
    return;
end
if (dist < 400)
    score = 0.8 * (400-dist);
    return;
end
if (dist < 500)
    score = 0.5*(500-dist);
    return;
end
if (dist < 600)
    score = 0.3*(600-dist);
    return;
end

score = 0;

end

