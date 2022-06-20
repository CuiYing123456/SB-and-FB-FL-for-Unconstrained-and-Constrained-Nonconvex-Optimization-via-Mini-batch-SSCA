clr = ['r'; 'g'; 'b'; 'k'; 'y'];
str = {'-'; '--'; ':'; '-.'};

%% =========== Plot Test Accuracy ===========
Lgd1 = {};
figure(4);

B_list = [10, 100, 1000];
a1_list = [0.3, 0.7];  % [0.3, 0.7]--> opt: [0.7, 0.7, 0.7]
a2_list = [0.3, 0.7];  % [0.3, 0.7]--> opt: [0.3, 0.3, 0.3]
alpha_list = [0.3, 0.7];  % [0.3, 0.7]--> opt: [0.3, 0.3, 0.3]-->[0.3, 0.2, 0.2]
acc = [];
cnt = 1;

for i = 1 : length(B_list)
    B = B_list(i);
    for j = 1 : length(a1_list)
        a1 = a1_list(j);
        for k = 1 : length(a2_list)
            a2 = a2_list(k);
            for l = 1 : length(alpha_list)
                alpha = alpha_list(l);
                load(sprintf('./SaveData/FUa1_B%d_a1%0.1f_a2%0.1f_alpha%0.1f.mat', B, a1, a2, alpha));
                plot(cnt, a_end1, 's'); hold on;
                cnt = cnt + 1;
            end
        end
    end
end