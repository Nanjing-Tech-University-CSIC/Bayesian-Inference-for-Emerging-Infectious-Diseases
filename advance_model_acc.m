function [Sn,En,Ir,In,Rn]= advance_model_acc(S,E,I,R,theta,populations,ir)
N=(1+0.01*normrnd(0,1,200,1));
Sn=S-N.*(S.*I.*theta(1))/(theta(3)*populations);
En=E+N.*(S.*I.*theta(1))/(theta(3)*populations)-E./theta(2);
Ir=ir+E/theta(2);
In=I+E./theta(2)-I./theta(3);
Rn=R+I./theta(3);
end