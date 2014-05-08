function [prob] = expectedAgeToDeathProb(age)
	prob = 1-(age/(age+1));
end