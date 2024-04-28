[num]=readmatrix('./model/data/ir_data.xlsx');
case_list=num(11:25,2);
times=20000;
particle=200;
case_length=length(case_list);
%[R_0,D_E,D_I,d]
theta=[4,4,6,10,1,1];
N_bins = 20;
%武汉11000000 南京9650000 上海24900000
populations=11000000;

%是否采用累加
acc=false;

[acceptance_rate,thetas,newIrs,newIs,newEs]=pmmh_2(case_list,particle,case_length,theta,populations,times,acc);

save('./4-21/acceptance_rate','acceptance_rate');

%% R0,De,Di,d均值
figure(1)
final_theta = zeros(6,1);
for i=1:6
    subplot(2,3,i);
    x=thetas(:,i);
    [miu,~,muci,~]=normfit(x); %95 置信区间 muci均值的95%
    histfit(x,N_bins);
    switch(i)
        case 1
            title("R0="+miu+" (95% CI,"+muci(1,1)+"-"+muci(2,1)+" )");
        case 2
            title("DE="+miu+" (95% CI,"+muci(1,1)+"-"+muci(2,1)+" )");
        case 3
            title("DI="+miu+" (95% CI,"+muci(1,1)+"-"+muci(2,1)+" )");
        case 4
            title("d="+miu+" (95% CI,"+muci(1,1)+"-"+muci(2,1)+" )");
        case 5
            title("ρ="+miu+" (95% CI,"+muci(1,1)+"-"+muci(2,1)+" )");
        case 6
            title("τ="+miu+" (95% CI,"+muci(1,1)+"-"+muci(2,1)+" )");
    end
    hold on;
    ylim=get(gca,'Ylim');
    plot([miu,miu],ylim,'-r','LineWidth',2);
    switch(i)
        case 1
            %plot([2.2,2.2],ylim,'-b','LineWidth',2);
            %根据不同的疫情绘制理想值
            %h = fill([1.4 1.4 3.9 3.9],[0 ylim(2) ylim(2) 0],'b');
            %set(h,'facealpha',0.4) 
        case 2
            %plot([5.2,5.2],ylim,'-b','LineWidth',2);
        case 3
            %plot([2.7,2.7],ylim,'-b','LineWidth',2);
        case 4
            %h = fill([9 9 11 11],[0 ylim(2) ylim(2) 0],'b');
            %set(h,'facealpha',0.4) 
            %plot([11,13],ylim,'-b','LineWidth',2);
    end
    final_theta(i) = mean(x);
end
fitR = mean(newIrs(:,:),1);
saveas(1,"./4-21/figure1")

%% 实际和预测的对比
figure(2)
draw_max = max(newIrs(:,:));
draw_min = min(newIrs(:,:));
for i = 1:case_length
    [d_miu,~,d_muci,~]=normfit(newIrs(:,i));
    draw_norm(i,1) = d_muci(1,1);
    draw_norm(i,2) = d_muci(2,1);
end

for i= 1:length(case_list)
    upper_traj(i) = quantile(newIrs(0.2*times:times,i), .95);
    lower_traj(i) = quantile(newIrs(0.2*times:times,i), .05);
end

a=length(case_list);
x=1:a;
for j=1:a
    x1(j)=a+1-j;
    y2(j)=draw_max(a+1-j);
    y4(j) = upper_traj(a+1-j);
end
y1=draw_min;
y3=lower_traj;

%fill([x x1],[y1 y2],'y');
%hold on

fill([x x1],[y3 y4],'blue');
hold on

p1=plot(case_list, 'k','linewidth',2);
hold on
p2=plot(fitR,'r','linewidth',2);
hold on

ylim=get(gca,'Ylim');
p3 = plot([1,1],ylim,'yellow','LineWidth',2);
%legend([p1,p2,p3],'Observed cases','Fitting results','First case reported');
save('./4-21/draw_max','draw_max');
save('./4-21/draw_min','draw_min');
save('./4-21/draw_norm','draw_norm');
%saveas(2,"./4-21/5-6/model/5-23/figure2")
saveas(2,"./4-21/figure2")

%% 粒子分布
figure(3)
for i=1:4
    subplot(4,1,i);
    x=thetas(:,i);
    plot(x)
end
saveas(3,"./4-21/figure3")
meanI=mean(newIs(:,end));
meanE=mean(newEs(:,end));
save('./4-21/thetas','thetas');
save('./4-21/final_theta','final_theta');
save('./4-21/newIrs','newIrs');
save('./4-21/newIs','newIs');
save('./4-21/newEs','newEs');
save('./4-21/meanI','meanI');
save('./4-21/meanE','meanE');




%%小提琴图
%%figure(4)
%%violinx = 1:case_length;
%%Hdl1=violinChart(gca,violinx,newIrs(0.2*times:times,:),[0 0.447 0.741],0.5);