% clr = [[1, 0, 0]; [1, 0.5, 0]; [1, 1, 0]; 
%     [0, 0.5, 0]; [0.5, 1, 0]; [0.5, 1, 0.5];
%     [0, 0.2, 1]; [0, 0.8, 1]; [0.5, 1, 1]];
% clr = [[1, 0, 0]; [1, 0.5, 0]; [1, 1, 0]; 
%     [0, 0.8, 0]; [0, 1, 0.5]; [0, 1, 1];
%     [0.3, 0.2, 1]; [0.8, 0.3, 1]; [1, 0.5, 1]];
clr = [[1, 0, 0]; [1, 0.5, 0]; [1, 0.8, 0.2]; 
    [0, 0.5, 0]; [0.2, 0.8, 0]; [0.6, 1, 0];
    [0, 0.2, 1]; [0, 0.6, 1]; [0, 1, 1]];
str = {'-'; '--'; '-.'; ':'};

%% =========== Plot Test Accuracy ===========
Lgd1 = {};
figure(1);
cnt = 1;
B = [5, 10, 50, 100];
E = [2, 1, 2, 1];

load(sprintf('./SaveData/SUa1_B10.mat'));
p = plot(a_mean1, 'MarkerIndices', 1:100:1000);  p.LineWidth = 1.2;  p.Color = clr(1,:);  p.LineStyle = str{1};  p.MarkerSize = 8;  hold on;
Lgd1{1} = sprintf('Alg.1,B=10');
load(sprintf('./SaveData/SUa1_B100.mat'));
p = plot(a_mean1, 'MarkerIndices', 1:100:1000);  p.LineWidth = 1.2;  p.Color = clr(2,:);  p.LineStyle = str{1};  p.MarkerSize = 8;  hold on;
Lgd1{2} = sprintf('Alg.1,B=100');

load(sprintf('./SaveData/SUa2_B10E1.mat'));
p = plot(a_mean2);  p.LineWidth = 1.2;  p.Color = clr(4,:);  p.LineStyle = str{1};  hold on;
Lgd1{3} = sprintf('SGD,B=10,E=1');
load(sprintf('./SaveData/SUa2_B5E2.mat'));
p = plot(a_mean2);  p.LineWidth = 1.2;  p.Color = clr(4,:);  p.LineStyle = str{2};  hold on;
Lgd1{4} = sprintf('SGD,B=5,E=2');
load(sprintf('./SaveData/SUa2_B100E1.mat'));
p = plot(a_mean2);  p.LineWidth = 1.2;  p.Color = clr(5,:);  p.LineStyle = str{1};  hold on;
Lgd1{5} = sprintf('SGD,B=100,E=1');
load(sprintf('./SaveData/SUa2_B50E2.mat'));
p = plot(a_mean2);  p.LineWidth = 1.2;  p.Color = clr(5,:);  p.LineStyle = str{2};  hold on;
Lgd1{6} = sprintf('SGD,B=50,E=2');

load(sprintf('./SaveData/SUa3_B10E1.mat'));
p = plot(a_mean3);  p.LineWidth = 1.2;  p.Color = clr(7,:);  p.LineStyle = str{1};  hold on;
Lgd1{7} = sprintf('SGD-m,B=10,E=1');
load(sprintf('./SaveData/SUa3_B5E2.mat'));
p = plot(a_mean3);  p.LineWidth = 1.2;  p.Color = clr(7,:);  p.LineStyle = str{2};  hold on;
Lgd1{8} = sprintf('SGD-m,B=5,E=2');
load(sprintf('./SaveData/SUa3_B100E1.mat'));
p = plot(a_mean3);  p.LineWidth = 1.2;  p.Color = clr(8,:);  p.LineStyle = str{1};  hold on;
Lgd1{9} = sprintf('SGD-m,B=100,E=1');
load(sprintf('./SaveData/SUa3_B50E2.mat'));
p = plot(a_mean3);  p.LineWidth = 1.2;  p.Color = clr(8,:);  p.LineStyle = str{2};  hold on;
Lgd1{10} = sprintf('SGD-m,B=50,E=2');

% for i = 1 : length(B)
%     if E(i) ~= 1
%         continue;
%     else
%         load(sprintf('./SaveData/SUa1_B%d.mat', B(i)));
%         p = plot(a_mean1, 'LineWidth', 1.5);  p.Color = clr(i,:);  p.LineStyle = str{1};  hold on;
%     end
% end
% for i = 1 : length(B)
%     load(sprintf('./SaveData/SUa2_B%dE%d.mat', B(i), E(i)));
%     p = plot(a_mean2, 'LineWidth', 1.5);  p.Color = clr(i,:);  p.LineStyle = str{2};  hold on;
% end
% for i = 1 : length(B)
%     load(sprintf('./SaveData/SUa3_B%dE%d.mat', B(i), E(i)));
%     p = plot(a_mean3, 'LineWidth', 1.5);  p.Color = clr(i,:);  p.LineStyle = str{3};  hold on;
% end
% 
% for i = 1 : length(B)
%     if E(i) ~= 1
%         continue;
%     else
%         Lgd1{cnt} = sprintf('Alg.1, B=%d', B(i));
%         cnt = cnt + 1;
%     end
% end
% for i = 1 : length(B)
%     Lgd1{cnt} = sprintf('SGD, B=%d, E=%d', B(i), E(i));
%     cnt = cnt + 1;
% end
% for i = 1 : length(B)
%     Lgd1{cnt} = sprintf('SGD.mom, B=%d, E=%d', B(i), E(i));
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

load(sprintf('./SaveData/SUc1_B10.mat'));
p = plot(c_mean1, 'MarkerIndices', 1:100:1000);  p.LineWidth = 1.2;  p.Color = clr(1,:);  p.LineStyle = str{1};  p.MarkerSize = 8;  hold on;
Lgd2{1} = sprintf('Alg.1,B=10');
load(sprintf('./SaveData/SUc1_B100.mat'));
p = plot(c_mean1, 'MarkerIndices', 1:100:1000);  p.LineWidth = 1.2;  p.Color = clr(2,:);  p.LineStyle = str{1};  p.MarkerSize = 8;  hold on;
Lgd2{2} = sprintf('Alg.1,B=100');

load(sprintf('./SaveData/SUc2_B10E1.mat'));
p = plot(c_mean2);  p.LineWidth = 1.2;  p.Color = clr(4,:);  p.LineStyle = str{1};  hold on;
Lgd2{3} = sprintf('SGD,B=10,E=1');
load(sprintf('./SaveData/SUc2_B5E2.mat'));
p = plot(c_mean2);  p.LineWidth = 1.2;  p.Color = clr(4,:);  p.LineStyle = str{2};  hold on;
Lgd2{4} = sprintf('SGD,B=5,E=2');
load(sprintf('./SaveData/SUc2_B100E1.mat'));
p = plot(c_mean2);  p.LineWidth = 1.2;  p.Color = clr(5,:);  p.LineStyle = str{1};  hold on;
Lgd2{5} = sprintf('SGD,B=100,E=1');
load(sprintf('./SaveData/SUc2_B50E2.mat'));
p = plot(c_mean2);  p.LineWidth = 1.2;  p.Color = clr(5,:);  p.LineStyle = str{2};  hold on;
Lgd2{6} = sprintf('SGD,B=50,E=2');

load(sprintf('./SaveData/SUc3_B10E1.mat'));
p = plot(c_mean3);  p.LineWidth = 1.2;  p.Color = clr(7,:);  p.LineStyle = str{1};  hold on;
Lgd2{7} = sprintf('SGD-m,B=10,E=1');
load(sprintf('./SaveData/SUc3_B5E2.mat'));
p = plot(c_mean3);  p.LineWidth = 1.2;  p.Color = clr(7,:);  p.LineStyle = str{2};  hold on;
Lgd2{8} = sprintf('SGD-m,B=5,E=2');
load(sprintf('./SaveData/SUc3_B100E1.mat'));
p = plot(c_mean3);  p.LineWidth = 1.2;  p.Color = clr(8,:);  p.LineStyle = str{1};  hold on;
Lgd2{9} = sprintf('SGD-m,B=100,E=1');
load(sprintf('./SaveData/SUc3_B50E2.mat'));
p = plot(c_mean3);  p.LineWidth = 1.2;  p.Color = clr(8,:);  p.LineStyle = str{2};  hold on;
Lgd2{10} = sprintf('SGD-m,B=50,E=2');
% 
% for i = 1 : length(B)
%     if E(i) ~= 1
%         continue;
%     else
%         load(sprintf('./SaveData/SUc1_B%d.mat', B(i)));
%         p = plot(c_mean1, 'LineWidth', 1.5);  p.Color = clr(i,:);  p.LineStyle = str{1};  hold on;
%     end
% end
% for i = 1 : length(B)
%     load(sprintf('./SaveData/SUc2_B%dE%d.mat', B(i), E(i)));
%     p = plot(c_mean2, 'LineWidth', 1.5);  p.Color = clr(i,:);  p.LineStyle = str{2};  hold on;
% end
% for i = 1 : length(B)
%     load(sprintf('./SaveData/SUc3_B%dE%d.mat', B(i), E(i)));
%     p = plot(c_mean3, 'LineWidth', 1.5);  p.Color = clr(i,:);  p.LineStyle = str{3};  hold on;
% end
% 
% for i = 1 : length(B)
%     if E(i) ~= 1
%         continue;
%     else
%         Lgd2{cnt} = sprintf('Alg.1, B=%d', B(i));
%         cnt = cnt + 1;
%     end
% end
% for i = 1 : length(B)
%     Lgd2{cnt} = sprintf('SGD, B=%d, E=%d', B(i), E(i));
%     cnt = cnt + 1;
% end
% for i = 1 : length(B)
%     Lgd2{cnt} = sprintf('SGD.mom, B=%d, E=%d', B(i), E(i));
%     cnt = cnt + 1;
% end

hold off;
legend(Lgd2);
grid on;
axis([-Inf, Inf, 0, 1.5]);
xlabel('Iteration');
ylabel('Training cost');