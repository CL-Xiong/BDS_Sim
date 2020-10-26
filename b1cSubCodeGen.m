function scode_pilot = b1cSubCodeGenerator(PRNs)
L = LegendreGenerator(3607);
w_pilot = [ 269,1448,1028,1324, 822,   5, 155, 458, 310, 959,...
    1238,1180,1288, 334, 885,1362, 181,1648, 838, 313,...
     750, 225,1477, 309, 108,1457, 149, 322, 271, 576,...
    1103, 450, 399, 241,1045, 164, 513, 687, 422, 303,...
     324, 495, 725, 780, 367, 882, 631,  37, 647,1043,...
      24, 120, 134, 136, 158, 214, 335, 340, 661, 889,...
     929,1002,1149];
p_pilot = [1889,1268,1593,1186,1239,1930, 176,1696,  26,1344,...
    1271,1182,1381,1604,1333,1185,  31, 704,1190,1646,...
    1385, 113, 860,1656,1921,1173,1928,  57, 150,1214,...
    1148,1458,1519,1635,1257,1687,1382,1514,   1,1583,...
    1806,1664,1338,1111,1706,1543,1813, 228,2871,2884,...
    1823,  75,  11,  63,1937,  22,1768,1526,1402,1445,...
    1680,1290,1245];
numPRNs = numel(PRNs);
scode_pilot = zeros(1800,numPRNs);
for ii = 1:numel(PRNs)
    Weil = WeilGenerator(L,-w_pilot(PRNs(ii)));
    tmp  = circshift(Weil,-p_pilot(PRNs(ii))+1);
    scode_pilot(:,ii) = tmp(1:1800);
end
end
function W = WeilGenerator(l,k)
W = xor(l,circshift(l,k));
W = 2*W - 1;
end
function L = LegendreGenerator(N)
L = false(1,N-1);
for ii = 1:N-1
    L(mod(ii*ii,N)) = true;
end
L = [false,L];
end