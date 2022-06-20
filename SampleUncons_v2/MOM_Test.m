%% Initialization
clear ; close all; clc

%% =========== Part 1: Loading and Visualizing Data =============
fprintf('Loading Data ...\n')

% load training data set
fid = fopen('./MNIST_data/train-images.idx3-ubyte', 'rb');
A_train_img = fread(fid, 4, 'uint32', 'ieee-be');
img_train_num = A_train_img(2);
row_num = A_train_img(3);
col_num = A_train_img(4);
img_train = fread(fid, [row_num*col_num, img_train_num], 'unsigned char', 'ieee-be');
img_train = (img_train/255);

% load training label set
fid = fopen('./MNIST_data/train-labels.idx1-ubyte', 'rb');
A_train_label = fread(fid, 2, 'uint32', 'ieee-be');
lab_train_num = A_train_label(2);
lab_train = fread(fid, lab_train_num, 'unsigned char',  'ieee-be');

% load test data set
fid = fopen('./MNIST_data/t10k-images.idx3-ubyte', 'rb');
A_test_img = fread(fid, 4, 'uint32', 'ieee-be');
img_test_num = A_test_img(2);
img_test = fread(fid, [row_num*col_num, img_test_num], 'unsigned char',  'ieee-be');
img_test = (img_test/255);

% load test label set
fid = fopen('./MNIST_data/t10k-labels.idx1-ubyte', 'rb');
A_test_label = fread(fid, 2, 'uint32', 'ieee-be');
lab_test_num = A_test_label(2);
lab_test = fread(fid, lab_test_num, 'unsigned char',  'ieee-be');
lab_test = lab_test';
%% Setup the parameters
% network hyperparameter
input_layer_size  = 784;  % 28 x 28 Input Images of Digits
hidden_layer_size = 128;   % number of hidden units
num_labels = 10;          % 10 labels, from 1 to 10

% initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
% initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
% J_epoch_init = nnCostFunction(initial_Theta1, initial_Theta2, num_labels, img_train, lab_train, lambda);
%
% pred = Predict(initial_Theta1, initial_Theta2, img_train);
% pred = pred';
% Accuracy_epoch_init = mean(double(pred == lab_train)) * 100;
% save(['initial_Theta1.mat'], 'initial_Theta1');
% save(['initial_Theta2.mat'], 'initial_Theta2');
% save(['J_epoch_init.mat'], 'J_epoch_init');
% save(['Accuracy_epoch_init.mat'], 'Accuracy_epoch_init');

% load initial point
load ('./InitialData/initial_Theta1.mat');
load ('./InitialData/initial_Theta2.mat');
load ('./InitialData/J_epoch_init.mat');
load ('./InitialData/Accuracy_epoch_init.mat');

% simulation parameters
lambda = 0;     % regularization
N = 10;     % N workers
L=1;

% local dataset
local_img = zeros(row_num * col_num, img_train_num/N, N);
local_lab = zeros( img_train_num/N, N);
for i = 1:N
    mini_idx = [ img_train_num/N * (i - 1) + 1:  img_train_num/N * i];
    local_img(:, :, i) = img_train(:, mini_idx);
    local_lab(:, i) = lab_train(mini_idx);
end

T=1000;
B_list = [600, 600, 300];
E_list = [1, 2];
lr_list = [0.1, 0.3, 1];  % [0.1, 0.3, 1] --> opt: [0.3, 1, 1]-->[0.3, 0.9, 1]
mon_list = [0.1, 0.3];  % [0.1, 0.2, 0.3] --> opt: [0.2(OK!), 0.1(OK!), 0.2]
for i = 1 : length(B_list)
    B = B_list(i);  E = E_list(i);
    for j = 1 : length(lr_list)
        lr = lr_list(j);
        for k = 1 : length(mon_list)
            mom = mon_list(k);
            
            fprintf('\nTraining Neural Network... \n')
            Theta1c=initial_Theta1;
            Theta2c=initial_Theta2;
            % training
            for t=1:T
                % model distribution
                for n = 1 : N
                    Theta1c_local(:, :, n) = Theta1c;
                    Theta2c_local(:, :, n) = Theta2c;
                    grad1c_local(:, :, n) = zeros(size(Theta1c));
                    grad2c_local(:, :, n) = zeros(size(Theta2c));
                end
                % local training
                for e = 1 : E
                    % baseline sampling
                    rand_idx = randperm(img_train_num/N);
                    rand_idx = rand_idx(1:B);
                    % baseline local training
                    for n = 1 : N
                        X = local_img(:, rand_idx, n);
                        y = local_lab(rand_idx, n);
                        % momSGD update
                        [local_Grad1c, local_Grad2c] = nnGradient(Theta1c_local(:,:,n),Theta2c_local(:,:,n), input_layer_size, hidden_layer_size, num_labels, X, y, lambda);  %�ݶ�
                        grad1c_local(:, :, n) = mom*grad1c_local(:, :, n) + (1-mom)*local_Grad1c;
                        grad2c_local(:, :, n) = mom*grad2c_local(:, :, n) + (1-mom)*local_Grad2c;
                        Theta1c_local(:, :, n) = Theta1c_local(:, :, n) - lr * grad1c_local(:, :, n);
                        Theta2c_local(:, :, n) = Theta2c_local(:, :, n) - lr * grad2c_local(:, :, n);
                    end
                    Theta1c = mean(Theta1c_local, 3);   %model update
                    Theta2c = mean(Theta2c_local, 3);
                end
                pred = Predict(Theta1c, Theta2c, img_test);
                accur3(t)=mean(double(pred == lab_test)) * 100;
                fprintf('\nTest accuracy of step %d for B=%d, E=%d (mom): %f', t, B, E,...
                    mean(double(pred == lab_test)) * 100);
            end
            a_end3 = mean(accur3(end-20:end));
            save(sprintf('./SaveData/SUa3_B%d_lr%0.1f_mom%0.1f.mat', B, lr, mom), 'a_end3');
        end
    end
end

