clr = ['r'; 'g'; 'b'; 'k'; 'y'];
str = {'-'; '--'; ':'; '-.'};

%% =========== Plot Test Accuracy ===========
Lgd1 = {};
figure(2);

% B_list = [1, 10, 100];
% lr_list = [0.1, 0.3, 1];
% mon_list = [0.1, 0.2, 0.3];
B_list = [100];
lr_list = [0.7, 0.8, 0.9];  % [0.1, 0.3, 1] --> opt: [0.3, 1, 1]-->[0.3, 0.9, 1]
mon_list = [0.2];  % [0.1, 0.2, 0.3] --> opt: [0.2(OK!), 0.1(OK!), 0.2]
acc = [];
cnt = 1;

for i = 1 : length(B_list)
    B = B_list(i);
    for j = 1 : length(lr_list)
        lr = lr_list(j);
        for k = 1 : length(mon_list)
            mom = mon_list(k);

            load(sprintf('./SaveData/SUa3_B%d_lr%0.1f_mom%0.1f.mat', B, lr, mom));
            plot(cnt, a_end3, 's'); hold on;
            cnt = cnt + 1;
        end
    end
end