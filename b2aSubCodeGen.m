function [code_d,code_p] = b2aSubCodeGen(PRNs)
numPRNs = numel(PRNs);
code_d = [-1;-1;-1;1;-1];
code_d = repmat(code_d,[1 numPRNs]);
w_pilot = [123, 55, 40,139, 31,175,350,450,478,  8,...
     73, 97,213,407,476,  4, 15, 47,163,280,...
    322,353,375,510,332,  7, 13, 16, 18, 25,...
     50, 81,118,127,132,134,164,177,208,249,...
    276,349,439,477,498, 88,155,330,  3, 21,...
     84,111,128,153,197,199,214,256,265,291,...
    324,326,340];
p_pilot = [138,570,351, 77,885,247,413,180,  3, 26,...
     17,172,30,1008,646,158,170, 99, 53,179,...
    925,114, 10,584, 60,  3,684,263,545, 22,...
    546,190,303,234, 38,822, 57,668,697, 93,...
     18, 66,318,133, 98, 70,132, 26,354, 58,...
     41,182,944,205, 23,  1,792,641, 83,  7,...
    111, 96, 92];
L = LegendreGeneratro(1021);
code_p = zeros(100,numPRNs);
for ii = 1:numPRNs
    Weil = WeilGenerator(L,-w_pilot(PRNs(ii)));
    tmp = circshift(Weil,-p_pilot(PRNs(ii))+1);
    code_p(:,ii) = tmp(1:100);
end
end
function W = WeilGenerator(l,k)
W = xor(l,circshift(l,k));
% [0,1] ==> [-1,1]
W = 2*W-1;
end
function L = LegendreGenerator(N)
L = false(1,N-1);
for ii = 1:N-1
    L(mod(ii*ii,N)) = true;
end
L = [false,L];
end