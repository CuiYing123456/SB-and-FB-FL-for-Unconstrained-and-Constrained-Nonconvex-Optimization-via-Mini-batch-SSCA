clr = ['r'; 'g'; 'b'; 'k'; 'y'];
str = {'-'; '--'; ':'; '-.'};

%% =========== Plot Test Accuracy ===========
Lgd1 = {};
figure(1);

% B_list = [1, 10, 100];
% lr_init_list = [0.1, 0.3, 1];
% dim_list = [0.1, 0.3, 0.5];
B_list = [10];
lr_init_list = [0.4, 0.5, 0.6, 0.7, 0.8, 0.9];  % [0.1, 0.3, 1] --> opt: [0.5, 1, 1]
dim_list = [0.1];  % [0.1, 0.3, 0.5] --> opt: [0.1, 0.1, 0.1]
acc = [];
cnt = 1;

for i = 1 : length(B_list)
    B = B_list(i);
    for j = 1 : length(lr_init_list)
        lr_init = lr_init_list(j);
        for k = 1 : length(dim_list)
            dim = dim_list(k);
            load(sprintf('./SaveData/SUa2_B%d_lrinit%0.1f_dim%0.1f.mat', B, lr_init, dim));
            plot(cnt, a_end2, 's'); hold on;
            cnt = cnt + 1;
        end
    end
end