clr = ['r'; 'g'; 'b'; 'k'; 'y'];
str = {'-'; '--'; ':'; '-.'};

%% =========== Plot Test Accuracy ===========
Lgd1 = {};
figure(1);

B_list = [100];
a1_list = [0.7];  % [0.3, 0.7]--> opt: [0.3, 0.7, 0.7]
a2_list = [0.7];  % [0.3, 0.7]--> opt: [0.3, 0.7, 0.7]-->[0.2(OK!), 0.7, 0.7]
alpha_list = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6];  % [0.3, 0.7] --> opt: [0.3, 0.3, 0.3]-->[0.4(OK!), 0.3, 0.3]
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
                load(sprintf('./SaveData/SUa1_B%d_a1%0.1f_a2%0.1f_alpha%0.1f.mat', B, a1, a2, alpha));
                plot(cnt, a_end1, 's'); hold on;
                cnt = cnt + 1;
            end
        end
    end
end