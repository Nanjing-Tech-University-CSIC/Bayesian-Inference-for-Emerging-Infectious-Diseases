function [likelihood,newIrs,newIs,newEs,newIr]= particle_filter(case_list,particle,case_length,theta,populations,acc)
day=ceil(theta(4));
total_days=case_length+day;
S = zeros(particle,total_days);
E = zeros(particle,total_days);
I = zeros(particle,total_days);
R = zeros(particle,total_days);
w = zeros(particle,total_days);
Ir = zeros(particle,total_days);
parent = zeros(particle,total_days);

%初始
I(:,1)=1;
E(:,1)=0;
S(:,1)=populations-I(:,1)-E(:,1);
w(:,1) = 1;
W=w(:,1)./sum(w(:,1));
%idx;
parent(:,1) = 1:particle;


for j =2:total_days
    idx=resampling(W);
    parent(:,j) = idx;
    if acc
        [S(:,j),E(:,j),Ir(:,j),I(:,j),R(:,j)] = advance_model_acc(S(parent(:,j),j-1),E(parent(:,j),j-1),I(parent(:,j),j-1),R(parent(:,j),j-1),theta,populations,Ir(parent(:,j),j-1));
    else
        [S(:,j),E(:,j),Ir(:,j),I(:,j),R(:,j)] = advance_model(S(parent(:,j),j-1),E(parent(:,j),j-1),I(parent(:,j),j-1),R(parent(:,j),j-1),theta,populations);
    end
    if j<=day
        E(E<0)=0;
        I(I<0)=0;
        parent(:,j)=1:particle;
        w(:,j)=1;
    else
        real_case_number=case_list(j-day); % 真实新增
        E(E<0)=0;
        Ir(Ir<0)=0;
        % -> try: poisspdf
        % if later report rate is incorporated,
        % Bernoulli distribution is prefered
        % w(:,j) = poisspdf(real_case_number,Ir(:,j));% 预测新增 = 真实新增的概率的次数
        w(:,j) = normpdf(real_case_number,theta(5) .* Ir(:,j),sqrt(theta(5) * theta(6) .*Ir(:,j)));
        W=w(:,j-1)./sum(w(:,j-1));
    end
end

J = find(rand(1) < cumsum(w(:,total_days)),1);
if isempty(J)==0
    ind = parent(:,total_days);
    for t = total_days:-1:2
        nIr(:,t) = Ir(ind,t);
        nE(:,t) = E(ind,t);
        nI(:,t) = I(ind,t);
        ind = parent(ind,t);
    end
    newIr=nIr(:,day+1:total_days);
    NewI=nI(:,day+1:total_days);
    newE=nE(:,day+1:total_days);
    newIrs(1,:) = newIr(J,:);
    newIs(1,:) = NewI(J,:);
    newEs(1,:) = newE(J,:);
    likelihood = sum(w(:,day+1:total_days))/particle;
    likelihood = sum(log(likelihood));
    likelihood = exp(likelihood);
else
    likelihood=0;
    newIrs=0;
    newIs=0;
    newEs=0;
end
end