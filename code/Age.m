function [ res] = Age( prob )
%AGE Summary of this function goes here
%   Detailed explanation goes here


total = 0;
turns = 100000;

for i=1:turns
    dead = 0;
    age = 0;
    while dead == 0,
        if rand < prob
            dead = 1;
        end
        age = age + 1;
    end
    total = total + age;
end

res = total/turns;
end

