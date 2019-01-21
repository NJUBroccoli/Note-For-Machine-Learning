%�Զ�����Ϊ��
data = load('data.txt');
[dataCnt, d] = size(data);
X = data(:, 1 : (d - 1));
y = data(:, d);

pos0 = find(y == 0);
pos1 = find(y == 1);
X0 = data(pos0, 1 : d - 1);
X1 = data(pos1, 1 : d - 1);

%������ɢ�Ⱦ���
M0 = mean(X0);
M1 = mean(X1);
p = size(X0, 1);
q = size(X1, 1);

Sw = 0;
for c = 1 : p
    Sw = Sw + (X0(c , :) - M0)' * (X0(c , :) - M0);
end
for c = 1 : q
    Sw = Sw + (X1(c , :) - M1)' * (X1(c , :) - M1);
end

%�����ɢ�Ⱦ���
Sb = (M0 - M1) * (M0 - M1)';

%����ֵ�ֽ�
[U, S, V] = svd(Sw);
Sw_inv = V * inv(S) * U';
w_ans = Sw_inv' * (M0 - M1)'