% clr = [[1, 0, 0]; [1, 0.5, 0]; [1, 0.8, 0.2]; 
%     [0, 0.8, 0]; [0.2, 1, 0.2]; [0.5, 1, 0.5];
%     [0.3, 0.2, 1]; [0.8, 0.3, 1]; [1, 0.5, 1]];
clr = [[1, 0, 0]; [1, 0.5, 0]; [1, 0.8, 0.2]; 
    [0, 0.5, 0]; [0.2, 0.8, 0]; [0.6, 1, 0];
    [0, 0.2, 1]; [0, 0.6, 1]; [0, 1, 1]];
str = {'-'; '--'; ':'; '-.'};

%% =========== Plot Test Accuracy ===========
Lgd1 = {};
figure(1);
cnt = 1;
B = [10, 100, 1000];

load(sprintf('./SaveData/FCa1_B10.mat'));
p = plot(a_mean1);  p.LineWidth = 1.2;  p.Color = clr(1,:);  p.LineStyle = str{1};  hold on;
Lgd1{1} = sprintf('Alg.1,B=10');
load(sprintf('./SaveData/FCa1_B100.mat'));
p = plot(a_mean1);  p.LineWidth = 1.2;  p.Color = clr(2,:);  p.LineStyle = str{1};  hold on;
Lgd1{2} = sprintf('Alg.1,B=100');
load(sprintf('./SaveData/FCa1_B1000.mat'));
p = plot(a_mean1);  p.LineWidth = 1.2;  p.Color = clr(3,:);  p.LineStyle = str{1};  hold on;
Lgd1{3} = sprintf('Alg.1,B=1000');

% for i = 1 : length(B)
%     load(sprintf('./SaveData/FCa1_B%d.mat', B(i)));
%     p = plot(a_mean1, 'LineWidth', 1.5);  p.Color = clr(i,:);  p.LineStyle = str{1};  hold on;
%     
% end
% 
% for i = 1 : length(B)
%     Lgd1{cnt} = sprintf('Alg.1, B=%d', B(i));
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
cnt = 1;

load(sprintf('./SaveData/FCc1_B10.mat'));
p = plot(c_mean1);  p.LineWidth = 1.2;  p.Color = clr(1,:);  p.LineStyle = str{1};  hold on;
Lgd2{1} = sprintf('Alg.1,B=10');
load(sprintf('./SaveData/FCc1_B100.mat'));
p = plot(c_mean1);  p.LineWidth = 1.2;  p.Color = clr(2,:);  p.LineStyle = str{1};  hold on;
Lgd2{2} = sprintf('Alg.1,B=100');
load(sprintf('./SaveData/FCc1_B1000.mat'));
p = plot(c_mean1);  p.LineWidth = 1.2;  p.Color = clr(3,:);  p.LineStyle = str{1};  hold on;
Lgd2{3} = sprintf('Alg.1,B=1000');

% for i = 1 : length(B)
%     load(sprintf('./SaveData/FCc1_B%d.mat', B(i)));
%     p = plot(c_mean1, 'LineWidth', 1.5);  p.Color = clr(i,:);  p.LineStyle = str{1};  hold on;
%     
% end
% 
% for i = 1 : length(B)
%     Lgd2{cnt} = sprintf('Alg.1, B=%d', B(i));
%     cnt = cnt + 1;
% end

hold off;
legend(Lgd2);
grid on;
axis([-Inf, Inf, 0, 1.5]);
xlabel('Iteration');
ylabel('Training cost');