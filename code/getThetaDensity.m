function p = getThetaDensity(theta)
p1=unifpdf(theta(1),0,4);
p2=unifpdf(theta(2),0,10);
p3=unifpdf(theta(3),0,6);
p4=unifpdf(theta(4),0,20);
p5=normpdf(theta(5),1,0.1);
p6=unifpdf(theta(6),0,3);
p=p1*p2*p3*p4*p5*p6;
end

% 仿真实验
% p1=unifpdf(theta(1),0,4);
% p2=unifpdf(theta(2),0,10);
% p3=unifpdf(theta(3),0,6);
% p4=unifpdf(theta(4),0,20);
% p5=normpdf(theta(5),1,0.1);
% p6=unifpdf(theta(6),0,3);


% 南京
% p1=normpdf(theta(1),5,1);
% p2=normpdf(theta(2),3,2);
% p3=normpdf(theta(3),4,2);
% p4=unifpdf(theta(4),0,30);
% p5=normpdf(theta(5),1,0.1);
% p6=unifpdf(theta(6),0,10);

% 上海
% p1=normpdf(theta(1),4,2);
% p2=normpdf(theta(2),3,2);
% p3=unifpdf(theta(3),0,10);
% p4=unifpdf(theta(4),0,30);
% p5=normpdf(theta(5),1,0.1);
% p6=unifpdf(theta(6),0,10);
% p=p1*p2*p3*p4*p5*p6;

%武汉
%p1=normpdf(theta(1),3,1);
%p2=normpdf(theta(2),6,2);
%p3=normpdf(theta(3),4,2);
%p4=normpdf(theta(4),0,20);
% p5=normpdf(theta(5),1,0.1);
% p6=unifpdf(theta(6),0,10);