x = xlsread('data.xlsx', 'B2:I18');
y = xlsread('data.xlsx', 'J2:J18');
[sample_num, attr_num] = size(x);
dest_num = size(y(1, :));
x = x';
y = y';

%��һ��
[x_normal, inputStr] = mapminmax(x);
[y_normal, outputStr] = mapminmax(y);

%����BP������
net = newff(x_normal, y_normal, [attr_num, attr_num + 1, dest_num], {'purelin', 'logsig', 'logsig'});

%���ѵ������
net.trainParam.epochs = 5000;
%ѧϰ��
net.trainParam.lr = 0.1;
%Ŀ�����
net.trainParam.goal = 1 * 10^(-4);

net = train(net, x_normal, y_normal);