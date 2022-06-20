clr = ['r'; 'g'; 'b'; 'k'; 'y'];
str = {'-'; '--'; ':'; '-.'};

%% =========== Plot Test Accuracy ===========
Lgd1 = {};
figure(3);

B_list = [100, 10];
E_list = [60, 600];
lr_list = [0.1, 0.3, 1];  % [0.1, 0.3, 1] --> opt: 0.3  [0.2, 0.3, 0.4] --> opt: 0.3 (OK!)
acc = [];
cnt = 1;

for i = 1 : length(B_list)
    B = B_list(i);  E = E_list(i);
    for j = 1 : length(lr_list)
        lr = lr_list(j);
        
        load(sprintf('./SaveData/SUa4_B%d_E%d_lr%0.1f.mat', B, E, lr));
        plot(cnt, a_end4, 's'); hold on;
        cnt = cnt + 1;
        
    end
end