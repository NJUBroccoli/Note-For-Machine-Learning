%Ŀǰֻ������������ݼ�3.0��ģ�ͣ������ı�����ֵ�����������Ϊ���ݡ��ڴ˻����Ͼ����ܱ�֤ͨ���ԡ�
%�ο���https://blog.csdn.net/icefire_tyh/article/details/52106069�ṩ��ʵ��
clear

%�������ݼ�
x = xlsread('data.xlsx', 'B2:I18');
y_sample = xlsread('data.xlsx', 'J2:J18');
[sample_num, attr_num] = size(x);

%�����Ľ�����
input_num = attr_num;

%�����Ľ�����
output_num = 1;

%������Ľ�����
hidden_num = attr_num + 1;

%BP�㷨�ĸ��������ͱ����������������еķ��ţ�
v = rand(input_num, hidden_num);
w = rand(hidden_num, output_num);
gamma = rand(hidden_num);
theta = rand(output_num);
eta = 0.6;
b = zeros(sample_num, hidden_num);
y = zeros(sample_num, output_num);

%�ж���ֹ����
last_E = 0;
count = 0;
threshold = 0.00001;
max_count = 50;

while (1)
    E = 0;
    for s = 1 : sample_num
        %�������
        for h = 1 : hidden_num
            tmp = 0;
            for i = 1 : input_num
                tmp = tmp + v(i, h) * x(s, i);
            end
            b(s, h) = 1 / (1 + exp(-(tmp - gamma(h))));
        end
        %��������
        for j = 1 : output_num
            tmp = 0;
            for h = 1 : hidden_num
                tmp = tmp + w(h, j) * b(s, h);
            end
            y(s, j) = 1 / (1 + exp(-(tmp - theta(j))));
        end
    end
    %�ۻ������ĸ��������½�����
    v_k = zeros(input_num, hidden_num);
    w_k = zeros(hidden_num, output_num);
    gamma_k = zeros(hidden_num);
    theta_k = zeros(output_num);
    for s = 1 : sample_num
       %�����ۻ����
       for j = 1 : output_num
           E = E + ((y_sample(s) - y(s, j))^2) / 2;
       end
       %����gj
       for j = 1 : output_num
           gj(j) = y(s, j) * (1 - y(s,j)) * (y_sample(s) - y(s, j));
       end
       %����eh
       for h = 1 : hidden_num
           tmp = 0;
           for j = 1 : output_num
               tmp = tmp + w(h, j) * gj(j);
           end
           eh(h) = tmp * b(s, h) * (1 - b(s, h));
       end
       %����w_k, theta_k
       for j = 1 : output_num
           theta_k(j) = theta_k(j) + (-eta) * gj(j);
           for h = 1 : hidden_num
               w_k(h, j) = w_k(h, j) + eta * gj(j) * b(s, h);
           end
       end
       %����v_k, gamma_k
       for h = 1 : hidden_num
           gamma_k(h) = gamma_k(h) + (-eta) * eh(h);
           for i = 1 : input_num
               v_k(i, h) = v_k(i, h) + eta * eh(h) * x(s, i);
           end
       end
    end
    %���²���
    v = v + eta * v_k;
    w = w + eta * w_k;
    theta = theta + eta * theta_k;
    gamma = gamma + eta * gamma_k;
    %������ֹ�ж�
    if(abs(last_E - E) < threshold)
        count = count + 1;
        if(count >= max_count)
            break;
        end
    else
        last_E = E;
        count = 0;
    end
end
y
