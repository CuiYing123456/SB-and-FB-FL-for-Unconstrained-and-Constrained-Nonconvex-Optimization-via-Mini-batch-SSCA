clr = ['r'; 'g'; 'b'; 'c'; 'm'; 'k'; 'y'];
str = {'-'; '--'; ':'; '-.'};

%% =========== Plot Test Accuracy ===========
Lgd1 = {};
figure(1);
cnt = 1;
B = [6000, 3000, 600];
E = [1, 2, 10];

for i = 1 : length(B)
    if E(i) ~= 1
        continue;
    else
        load(sprintf('./SaveData/SUa1_B%d.mat', B(i)));
        p = plot(a_mean1, 'LineWidth', 1.2);  p.Color = clr(i,:);  p.LineStyle = str{1};  hold on;
    end
end
for i = 1 : length(B)
    load(sprintf('./SaveData/SUa2_B%dE%d.mat', B(i), E(i)));
    p = plot(a_mean2, 'LineWidth', 1.2);  p.Color = clr(i,:);  p.LineStyle = str{2};  hold on;
end
for i = 1 : length(B)
    load(sprintf('./SaveData/SUa3_B%dE%d.mat', B(i), E(i)));
    p = plot(a_mean3, 'LineWidth', 1.2);  p.Color = clr(i,:);  p.LineStyle = str{3};  hold on;
end

for i = 1 : length(B)
    if E(i) ~= 1
        continue;
    else
        Lgd1{cnt} = sprintf('Alg.1, B=%d', B(i));
        cnt = cnt + 1;
    end
end
for i = 1 : length(B)
    Lgd1{cnt} = sprintf('SGD, B=%d, E=%d', B(i), E(i));
    cnt = cnt + 1;
end
for i = 1 : length(B)
    Lgd1{cnt} = sprintf('SGD.mom, B=%d, E=%d', B(i), E(i));
    cnt = cnt + 1;
end

hold off;
legend(Lgd1);
grid on;
axis([-Inf, Inf, 70, 100]);
xlabel('Iteration');
ylabel('Test accuracy');

%% =========== Plot Cost Function ===========
Lgd2 = {};
figure(2);
cnt = 1;

for i = 1 : length(B)
    if E(i) ~= 1
        continue;
    else
        load(sprintf('./SaveData/SUc1_B%d.mat', B(i)));
        p = plot(c_mean1, 'LineWidth', 1.2);  p.Color = clr(i,:);  p.LineStyle = str{1};  hold on;
    end
end
for i = 1 : length(B)
    load(sprintf('./SaveData/SUc2_B%dE%d.mat', B(i), E(i)));
    p = plot(c_mean2, 'LineWidth', 1.2);  p.Color = clr(i,:);  p.LineStyle = str{2};  hold on;
end
for i = 1 : length(B)
    load(sprintf('./SaveData/SUc3_B%dE%d.mat', B(i), E(i)));
    p = plot(c_mean3, 'LineWidth', 1.2);  p.Color = clr(i,:);  p.LineStyle = str{3};  hold on;
end


for i = 1 : length(B)
    if E(i) ~= 1
        continue;
    else
        Lgd2{cnt} = sprintf('Alg.1, B=%d', B(i));
        cnt = cnt + 1;
    end
end
for i = 1 : length(B)
    Lgd2{cnt} = sprintf('SGD, B=%d, E=%d', B(i), E(i));
    cnt = cnt + 1;
end
for i = 1 : length(B)
    Lgd2{cnt} = sprintf('SGD.mom, B=%d, E=%d', B(i), E(i));
    cnt = cnt + 1;
end

hold off;
legend(Lgd2);
grid on;
axis([-Inf, Inf, 0, 2]);
xlabel('Iteration');
ylabel('Training cost');
