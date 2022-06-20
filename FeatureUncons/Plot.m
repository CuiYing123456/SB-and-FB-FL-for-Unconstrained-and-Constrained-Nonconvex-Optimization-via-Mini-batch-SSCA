clr = ['r'; 'g'; 'b'; 'c'; 'm'; 'k'; 'y'];
str = {'-'; '--'; ':'; '-.'};

%% =========== Plot Test Accuracy ===========
Lgd1 = {};
figure(1);
B = [10, 100, 1000];

for i = 1 : length(B)
    load(sprintf('./SaveData/FUa1_B%d.mat', B(i)));
    p = plot(a_mean1, 'LineWidth', 1.2);  p.Color = clr(i,:);  p.LineStyle = str{1};  hold on;
end
for i = 1 : length(B)
    load(sprintf('./SaveData/FUa2_B%d', B(i)));
    p = plot(a_mean2, 'LineWidth', 1.2);  p.Color = clr(i,:);  p.LineStyle = str{2};  hold on;
end
for i = 1 : length(B)
    load(sprintf('./SaveData/FUa3_B%d', B(i)));
    p = plot(a_mean3, 'LineWidth', 1.2);  p.Color = clr(i,:);  p.LineStyle = str{3};  hold on;
end

cnt = 1;
for i = 1 : length(B)
    Lgd1{cnt} = strcat('Alg.1, B=', num2str(B(i)));
    cnt = cnt + 1;
end
for i = 1 : length(B)
    Lgd1{cnt} = strcat('SGD, B=', num2str(B(i)), ', E=1');
    cnt = cnt + 1;
end
for i = 1 : length(B)
    Lgd1{cnt} = strcat('SGD.mom, B=', num2str(B(i)), ', E=1');
    cnt = cnt + 1;
end

hold off;
legend(Lgd1);
grid on;
axis([-Inf, Inf, 60, 100]);
xlabel('Iteration');
ylabel('Test accuracy');

%% =========== Plot Cost Function ===========
Lgd2 = {};
figure(2);
B = [10, 100, 1000];
for i = 1 : length(B)
    load(sprintf('./SaveData/FUc1_B%d.mat', B(i)));
    p = plot(c_mean1, 'LineWidth', 1.2);  p.Color = clr(i,:);  p.LineStyle = str{1};  hold on;
end
for i = 1 : length(B)
    load(sprintf('./SaveData/FUc2_B%d', B(i)));
    p = plot(c_mean2, 'LineWidth', 1.2);  p.Color = clr(i,:);  p.LineStyle = str{2};  hold on;
end
for i = 1 : length(B)
    load(sprintf('./SaveData/FUc3_B%d', B(i)));
    p = plot(c_mean3, 'LineWidth', 1.2);  p.Color = clr(i,:);  p.LineStyle = str{3};  hold on;
end

cnt = 1;
for i = 1 : length(B)
    Lgd2{cnt} = strcat('Alg.1, B=', num2str(B(i)));
    cnt = cnt + 1;
end
for i = 1 : length(B)
    Lgd2{cnt} = strcat('SGD, B=', num2str(B(i)), ', E=1');
    cnt = cnt + 1;
end
for i = 1 : length(B)
    Lgd2{cnt} = strcat('SGD.mom, B=', num2str(B(i)), ', E=1');
    cnt = cnt + 1;
end

hold off;
legend(Lgd2);
grid on;
axis([-Inf, Inf, 0, 2]);
xlabel('Iteration');
ylabel('Training cost');