clr = ['r'; 'g'; 'b'; 'k'; 'y'];
str = {'-'; '--'; ':'; '-.'};
mkr = ['o'; 's'];

%% =========== Plot Test Accuracy ===========
Lgd1 = {};
figure(1);
cnt = 1;
B = [10, 100, 6000];
marker_idx = 1:5:1000;
load(sprintf('./SaveData/SCa1_B10.mat'));
p1 = plot(a_mean1, '-o');
       
for i = 1 : length(B)
        load(sprintf('./SaveData/SCa1_B%d.mat', B(i)));
        p = plot(a_mean1, 'LineWidth', 1.2, 'MarkerIndices', 1:20:1000);  p.Color = clr(i,:);  p.LineStyle = str{1};	hold on;
end

for i = 1 : length(B)
        Lgd1{cnt} = sprintf('Alg.1, B=%d', B(i));
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
        load(sprintf('./SaveData/SCc1_B%d.mat', B(i)));
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
