clr = ['r'; 'g'; 'b'; 'k'; 'y'];
str = {'-'; '--'; ':'; '-.'};

%% =========== Plot Test Accuracy ===========
Lgd1 = {};
figure(1);
cnt = 1;
B = [10, 100, 1000];

for i = 1 : length(B)
        load(sprintf('./SaveData/FCa1_B%d.mat', B(i)));
        p = plot(a_mean1, 'LineWidth', 1.2);  p.Color = clr(i,:);  p.LineStyle = str{1};  hold on;
end

for i = 1 : length(B)
        Lgd1{cnt} = sprintf('Alg.1, B=%d', B(i));
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
cnt = 1;

for i = 1 : length(B)
        load(sprintf('./SaveData/FCc1_B%d.mat', B(i)));
        p = plot(c_mean1, 'LineWidth', 1.2);  p.Color = clr(i,:);  p.LineStyle = str{1};  hold on;
end

for i = 1 : length(B)
        Lgd2{cnt} = sprintf('Alg.1, B=%d', B(i));
        cnt = cnt + 1;
end

hold off;
legend(Lgd2);
grid on;
axis([-inf, Inf, 0, 2]);
xlabel('Iteration');
ylabel('Training cost');
