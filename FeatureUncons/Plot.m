% clr = [[1, 0, 0]; [1, 0.5, 0]; [1, 0.8, 0.2]; 
%     [0, 0.5, 0]; [0.2, 0.8, 0]; [0.6, 1, 0];
%     [0, 0.2, 1]; [0, 0.6, 1]; [0, 1, 1]];
clr = [[1, 0, 0]; [1, 0.5, 0]; [1, 0.8, 0.2]; 
    [0, 0.5, 0]; [0.2, 0.8, 0]; [0.6, 1, 0];
    [0, 0.2, 1]; [0, 0.6, 1]; [0, 1, 1]];
str = {'-'; '--'; ':'; '-.'};

%% =========== Plot Test Accuracy ===========
Lgd1 = {};
figure(1);
B = [10, 100, 1000];

load(sprintf('./SaveData/FUa1_B10.mat'));
p = plot(a_mean1);  p.LineWidth = 1.2;  p.Color = clr(1,:);  p.LineStyle = str{1};  hold on;
Lgd1{1} = sprintf('Alg.1,B=10');
load(sprintf('./SaveData/FUa1_B100.mat'));
p = plot(a_mean1);  p.LineWidth = 1.2;  p.Color = clr(2,:);  p.LineStyle = str{1};  hold on;
Lgd1{2} = sprintf('Alg.1,B=100');
load(sprintf('./SaveData/FUa1_B1000.mat'));
p = plot(a_mean1);  p.LineWidth = 1.2;  p.Color = clr(3,:);  p.LineStyle = str{1};  hold on;
Lgd1{3} = sprintf('Alg.1,B=1000');

load(sprintf('./SaveData/FUa2_B10.mat'));
p = plot(a_mean2);  p.LineWidth = 1.2;  p.Color = clr(4,:);  p.LineStyle = str{1};  hold on;
Lgd1{4} = sprintf('SGD,B=10');
load(sprintf('./SaveData/FUa2_B100.mat'));
p = plot(a_mean2);  p.LineWidth = 1.2;  p.Color = clr(5,:);  p.LineStyle = str{1};  hold on;
Lgd1{5} = sprintf('SGD,B=100');
load(sprintf('./SaveData/FUa2_B1000.mat'));
p = plot(a_mean2);  p.LineWidth = 1.2;  p.Color = clr(6,:);  p.LineStyle = str{1};  hold on;
Lgd1{6} = sprintf('SGD,B=1000');

load(sprintf('./SaveData/FUa3_B10.mat'));
p = plot(a_mean3);  p.LineWidth = 1.2;  p.Color = clr(7,:);  p.LineStyle = str{1};  hold on;
Lgd1{7} = sprintf('SGD-m,B=10');
load(sprintf('./SaveData/FUa3_B100.mat'));
p = plot(a_mean3);  p.LineWidth = 1.2;  p.Color = clr(8,:);  p.LineStyle = str{1};  hold on;
Lgd1{8} = sprintf('SGD-m,B=100');
load(sprintf('./SaveData/FUa3_B1000.mat'));
p = plot(a_mean3);  p.LineWidth = 1.2;  p.Color = clr(9,:);  p.LineStyle = str{1};  hold on;
Lgd1{9} = sprintf('SGD-m,B=1000');

% for i = 1 : length(B)
%     load(sprintf('./SaveData/FUa1_B%d.mat', B(i)));
%     p = plot(a_mean1, 'LineWidth', 1.5);  p.Color = clr(i,:);  p.LineStyle = str{1};  hold on;
% end
% for i = 1 : length(B)
%     load(sprintf('./SaveData/FUa2_B%d', B(i)));
%     p = plot(a_mean2, 'LineWidth', 1.5);  p.Color = clr(i,:);  p.LineStyle = str{2};  hold on;
% end
% for i = 1 : length(B)
%     load(sprintf('./SaveData/FUa3_B%d', B(i)));
%     p = plot(a_mean3, 'LineWidth', 1.5);  p.Color = clr(i,:);  p.LineStyle = str{3};  hold on;
% end
% 
% cnt = 1;
% for i = 1 : length(B)
%     Lgd1{cnt} = strcat('Alg.1, B=', num2str(B(i)));
%     cnt = cnt + 1;
% end
% for i = 1 : length(B)
%     Lgd1{cnt} = strcat('SGD, B=', num2str(B(i)), ', E=1');
%     cnt = cnt + 1;
% end
% for i = 1 : length(B)
%     Lgd1{cnt} = strcat('SGD.mom, B=', num2str(B(i)), ', E=1');
%     cnt = cnt + 1;
% end


hold off;
legend(Lgd1);
grid on;
axis([-Inf, Inf, 80, 100]);
xlabel('Iteration');
ylabel('Test accuracy');

%% =========== Plot Cost Function ===========
Lgd2 = {};
figure(2);
B = [10, 100, 1000];

load(sprintf('./SaveData/FUc1_B10.mat'));
p = plot(c_mean1);  p.LineWidth = 1.2;  p.Color = clr(1,:);  p.LineStyle = str{1};  hold on;
Lgd2{1} = sprintf('Alg.1,B=10');
load(sprintf('./SaveData/FUc1_B100.mat'));
p = plot(c_mean1);  p.LineWidth = 1.2;  p.Color = clr(2,:);  p.LineStyle = str{1};  hold on;
Lgd2{2} = sprintf('Alg.1,B=100');
load(sprintf('./SaveData/FUc1_B1000.mat'));
p = plot(c_mean1);  p.LineWidth = 1.2;  p.Color = clr(3,:);  p.LineStyle = str{1};  hold on;
Lgd2{3} = sprintf('Alg.1,B=1000');

load(sprintf('./SaveData/FUc2_B10.mat'));
p = plot(c_mean2);  p.LineWidth = 1.2;  p.Color = clr(4,:);  p.LineStyle = str{1};  hold on;
Lgd2{4} = sprintf('SGD,B=10');
load(sprintf('./SaveData/FUc2_B100.mat'));
p = plot(c_mean2);  p.LineWidth = 1.2;  p.Color = clr(5,:);  p.LineStyle = str{1};  hold on;
Lgd2{5} = sprintf('SGD,B=100');
load(sprintf('./SaveData/FUc2_B1000.mat'));
p = plot(c_mean2);  p.LineWidth = 1.2;  p.Color = clr(6,:);  p.LineStyle = str{1};  hold on;
Lgd2{6} = sprintf('SGD,B=1000');

load(sprintf('./SaveData/FUc3_B10.mat'));
p = plot(c_mean3);  p.LineWidth = 1.2;  p.Color = clr(7,:);  p.LineStyle = str{1};  hold on;
Lgd2{7} = sprintf('SGD-m,B=10');
load(sprintf('./SaveData/FUc3_B100.mat'));
p = plot(c_mean3);  p.LineWidth = 1.2;  p.Color = clr(8,:);  p.LineStyle = str{1};  hold on;
Lgd2{8} = sprintf('SGD-m,B=100');
load(sprintf('./SaveData/FUc3_B1000.mat'));
p = plot(c_mean3);  p.LineWidth = 1.2;  p.Color = clr(9,:);  p.LineStyle = str{1};  hold on;
Lgd2{9} = sprintf('SGD-m,B=1000');

% for i = 1 : length(B)
%     load(sprintf('./SaveData/FUc1_B%d.mat', B(i)));
%     p = plot(c_mean1, 'LineWidth', 1.5);  p.Color = clr(i,:);  p.LineStyle = str{1};  hold on;
% end
% for i = 1 : length(B)
%     load(sprintf('./SaveData/FUc2_B%d', B(i)));
%     p = plot(c_mean2, 'LineWidth', 1.5);  p.Color = clr(i,:);  p.LineStyle = str{2};  hold on;
% end
% for i = 1 : length(B)
%     load(sprintf('./SaveData/FUc3_B%d', B(i)));
%     p = plot(c_mean3, 'LineWidth', 1.5);  p.Color = clr(i,:);  p.LineStyle = str{3};  hold on;
% end
% 
% cnt = 1;
% for i = 1 : length(B)
%     Lgd2{cnt} = strcat('Alg.1, B=', num2str(B(i)));
%     cnt = cnt + 1;
% end
% for i = 1 : length(B)
%     Lgd2{cnt} = strcat('SGD, B=', num2str(B(i)), ', E=1');
%     cnt = cnt + 1;
% end
% for i = 1 : length(B)
%     Lgd2{cnt} = strcat('SGD.mom, B=', num2str(B(i)), ', E=1');
%     cnt = cnt + 1;
% end

hold off;
legend(Lgd2);
grid on;
axis([-Inf, Inf, 0, 1.5]);
xlabel('Iteration');
ylabel('Training cost');