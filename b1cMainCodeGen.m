function [mcode_d,mcode_p] = b1cMainCodeGen(PRNs)
L = LegendreGenerator(10243);
% 数据分量data 参数
w_d = [2678,4802, 958, 859,3843,2232, 124,4352,1816,1126,...
     1860,4800,2267, 424,4192,4333,2656,4148, 243,1330,...
     1593,1470, 882,3202,5095,2546,1733,4795,4577,1627,...
     3638,2553,3646,1087,1843, 216,2245, 726,1966, 670,...
     4130,  53,4830, 182,2181,2006,1080,2288,2027, 271,...
      915, 497, 139,3693,2054,4342,3342,2592,1007, 310,...
     4203, 455,4318];
p_d = [ 699, 694,7318,2127, 715,6682,7850,5495,1162,7682,...
     6792,9973,6596,2092, 19,10151,6297,5766,2359,7136,...
     1706,2128,6827, 693,9729,1620,6805, 534, 712,1929,...
     5355,6139,6339,1470,6867,7851,1162,7659,1156,2672,...
     6043,2862, 180,2663,6940,1645,1582, 951,6878,7701,...
     1823,2391,2606, 822,6403, 239, 442,6769,2560,2502,...
     5072,7268, 341];
% 导频分量pilot 参数
w_p = [ 796, 156,4198,3941,1374,1338,1833,2521,3175, 168,...
     2715,4408,3160,2796, 459,3594,4813, 586,1428,2371,...
     2285,3377,4965,3779,4547,1646,1430, 607,2118,4709,...
     1149,3283,2473,1006,3670,1817, 771,2173, 740,1433,...
     2458,3459,2155,1205, 413, 874,2463,1106,1590,3873,...
     4026,4272,3556, 128,1200, 130,4494,1871,3073,4386,...
     4098,1923,1176];
p_p = [7575,2369,5688, 539,2270,7306,6457,6254,5644,7119,...
     1402,5557,5764,1073,7001,5910,10060,2710,1546,6887,...
     1883,5613,5062,1038,10170,6484,1718,2535,1158,526,...
     7331,5844,6423,6968,1280,1838,1989,6468,2091,1581,...
     1453,6252,7122,7711,7216,2113,1095,1628,1713,6102,...
     6123,6070,1115,8047,6795,2575,  53,1729,6388, 682,...
     5565,7160,2277];
numPRNs = numel(PRNs);
mcode_d = zeros(10230,numPRNs);
mcode_p = zeros(10230,numPRNs);
for ii = 1:numPRNs
    Weil = WeilGenerator(L,-w_d(PRNs(ii)));
    tmp  = circshift(Weil,-p_d(PRNs(ii))+1);
    mcode_d(:,ii) = tmp(1:10230);
    Weil = WeilGenerator(L,-w_p(PRNs(ii)));
    tmp = circshift(Weil,-p_p(PRNs(ii))+1);
    mcode_p(:,ii) = tmp(1:10230);
end
% 逻辑电平[0,1] ==> 信号电平[-1,1]
mcode_d = 2*mcode_d - 1;
mcode_p = 2*mcode_p - 1;
end
function W = WeilGenerator(l,k)
W = xor(l,circshift(l,k));
end
function L = LegendreGenerator(N)
L = false(1,N-1);
for ii = 1:N-1
    L(mod(ii*ii,N)) = true;
end
L = [false,L];
end