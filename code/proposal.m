function next_theta=proposal(cur_theta)
next_theta=cur_theta;
next_theta(1)=normrnd(cur_theta(1),0.2);
next_theta(2)=normrnd(cur_theta(2),0.5);
next_theta(3)=normrnd(cur_theta(3),0.2);
next_theta(4)=normrnd(cur_theta(4),1);
next_theta(5)=normrnd(cur_theta(5),0.1);
next_theta(6)=normrnd(cur_theta(6),0.1);
end