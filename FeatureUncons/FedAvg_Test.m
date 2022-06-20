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
tau=0.1;

% local dataset
local_img = zeros(row_num * col_num, img_train_num/N, N);
local_lab = zeros( img_train_num/N, N);
for i = 1:N
    mini_idx = [ img_train_num/N * (i - 1) + 1:  img_train_num/N * i];
    local_img(:, :, i) = img_train(:, mini_idx);
    local_lab(:, i) = lab_train(mini_idx);
end

T=1000;
B_list = [100, 10];
E_list = [10, 100];
lr_list = [0.1, 0.3, 1];  % [0.1, 0.3, 1] --> opt: [0.1, 0.3, 1; 0.1, 0.3] (OK!)
for i = 1 : length(B_list)
    B = B_list(i);  E = E_list(i);
    for j = 1 : length(lr_list)
        lr = lr_list(j);
        
        for iter=1:L
            fprintf('\nTraining Neural Network... \n')
            Theta1d=initial_Theta1;
            Theta2d=initial_Theta2;
            Theta1_local = zeros(size(Theta1d, 1), size(Theta1d, 2), N);
            Theta2_local = zeros(size(Theta2d, 1), size(Theta2d, 2), N);
            % training
            for t=1:T
                for n = 1 : N
                    Theta1_local(:, :, n) = Theta1d;
                    Theta2_local(:, :, n) = Theta2d;
                end
                % FedAvg update
                J = nnCostFunction(Theta1d, Theta2d, num_labels, img_train, lab_train, lambda);        %cost function
                J_step4(t,iter)=J;    % Record cost function
                for e = 1 : E  % local training
                    % sampling
                    rand_idx = randperm(img_train_num/N);
                    rand_idx = rand_idx(1:B);
                    for n = 1 : N
                        X = local_img(:, rand_idx, n);
                        y = local_lab(rand_idx, n);
                        [local_Grad1, local_Grad2] = nnGradient(Theta1_local(:,:,n),Theta2_local(:,:,n), input_layer_size, hidden_layer_size, num_labels, X, y, lambda);  %�ݶ�
                        Theta1_local(:, :, n) = Theta1_local(:, :, n) - lr * local_Grad1;
                        Theta2_local(:, :, n) = Theta2_local(:, :, n) - lr * local_Grad2;
                    end
                end
                Theta1d = mean(Theta1_local, 3);   %model update
                Theta2d = mean(Theta2_local, 3);
                pred = Predict(Theta1d, Theta2d, img_test);
%                 pred = pred';
                accur4(t,iter)=mean(double(pred == lab_test)) * 100;
                fprintf('Test accuracy of step %d for B=%d, E=%d, lr=%0.1f (FedAvg): %f\n', t, B, E, lr,...
                    mean(double(pred == lab_test)) * 100);    %׼ȷ��
            end
            fprintf('\nComplete training of iteration %d for B=%d, E=%d, lr=%0.1f\n', iter, B, E, lr);
        end
        a_mean4=mean(accur4,2);
        a_end4 = mean(a_mean4(end-20:end));
        c_mean4=mean(J_step4,2);
        c_end4 = mean(c_mean4(end-20:end));
        
        save(sprintf('./SaveData/FUa4_B%d_E%d_lr%0.1f.mat', B, E, lr), 'a_end4');
        save(sprintf('./SaveData/FUc4_B%d_E%d_lr%0.1f.mat', B, E, lr), 'c_end4');
        
    end
end

