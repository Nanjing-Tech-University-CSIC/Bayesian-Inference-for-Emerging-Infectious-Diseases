function [acceptance_rate,thetas,newIrs,newIs,newEs] = pmmh(case_list,particle,case_length,theta,populations,times,acc)

thetas=zeros(times,6);
newIrs=zeros(times,case_length);
newIs=zeros(times,case_length);
newEs=zeros(times,case_length);
reverseStr=[];
acceptance_rate=0;

[p,newIr,newI,newE] = particle_filter(case_list,particle,case_length,theta,populations,acc);
while (p == 0)
    theta = proposal(theta);
    [p,newIr,newI,newE] = particle_filter(case_list,particle,case_length,theta,populations,acc);
end

for it = 1 : times
    reverseStr = displayprogress(100*it/times, reverseStr);
    p_next = 0;
    while (p_next == 0)
        while 1
            theta_next = proposal(theta);
            c=isempty(find(theta_next<0, 1));
            if c==1
                break;
            end
        end
        [p_next,newIr_temp,newI_temp,newE_temp]= particle_filter(case_list,particle,case_length,theta_next,populations,acc);

    end

    Malpha = ( p_next * getThetaDensity(theta_next)) / ( p * getThetaDensity(theta));
    r = min(1,Malpha);
    u = rand(1,1);
    if r > u
        p = p_next;
        theta = theta_next;
        thetas(it,:) = theta_next;
        newIr=newIr_temp;
        newI=newI_temp;
        newE=newE_temp;
        newIrs(it,:)=newIr_temp;
        newIs(it,:)=newI_temp;
        newEs(it,:)=newE_temp;
        acceptance_rate= acceptance_rate + 1;
    else
        thetas(it,:) = theta;
        newIrs(it,:)=newIr;
        newIs(it,:)=newI;
        newEs(it,:)=newE;
    end
end

acceptance_rate = acceptance_rate/times;
end

