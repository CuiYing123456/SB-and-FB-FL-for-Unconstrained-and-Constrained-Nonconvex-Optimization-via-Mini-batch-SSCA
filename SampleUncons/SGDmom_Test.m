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

T=1000;
B_list = [100];
lr_list = [0.7, 0.8, 0.9];  % [0.1, 0.3, 1] --> opt: [0.3, 1, 1]-->[0.3, 0.9, 1]
mon_list = [0.2];  % [0.1, 0.2, 0.3] --> opt: [0.2(OK!), 0.1(OK!), 0.2]
for i = 1 : length(B_list)
    B = B_list(i);
    for j = 1 : length(lr_list)
        lr = lr_list(j);
        for k = 1 : length(mon_list)
            mom = mon_list(k);
            
            for iter=1:L
                fprintf('\nTraining Neural Network... \n')
                Theta1c=initial_Theta1;
                Theta2c=initial_Theta2;
                Total_grad1=zeros(size(Theta1c));
                Total_grad2=zeros(size(Theta2c));
                grad1 = zeros(size(Theta1c));
                grad2 = zeros(size(Theta2c));
                % training
                for t=1:T
                    %                         lr = 0.4/t^0.5;  mom = 0.1; eta = 1;
                    % sampling
                    rand_set = randperm(img_train_num); % ѵ��������
                    minibatch = rand_set(1:B*N);        % ȡһ��minibatch
                    X = img_train(:, minibatch);      % minibatch sample set
                    y = lab_train(minibatch);     % minibatch label set
                    
                    % SGD-momentum update
                    [Theta1_grad, Theta2_grad] = nnGradient(Theta1c,Theta2c, input_layer_size, hidden_layer_size, num_labels, X, y, lambda);  %�ݶ�
                    J = nnCostFunction(Theta1c, Theta2c, num_labels, img_train, lab_train, lambda);        %cost function
                    J_step3(t,iter)=J;    % Record cost function
                    grad1 = mom*grad1 + (1-mom)*Theta1_grad;
                    grad2 = mom*grad2 + (1-mom)*Theta2_grad;
                    Theta1c = Theta1c-lr*grad1;   %model update
                    Theta2c = Theta2c-lr*grad2;
                    pred = Predict(Theta1c, Theta2c, img_test);
                    %             pred = pred';
                    accur3(t,iter)=mean(double(pred == lab_test)) * 100;
                    fprintf('Test accuracy of step %d for B=%d, lr=%0.1f, mom=%0.1f (SGD): %f\n', t, B, lr, mom,...
                        mean(double(pred == lab_test)) * 100);    %׼ȷ��
                end
                fprintf('\nComplete training of iteration %d for B=%d, lr=%0.1f, mom=%0.1f\n', iter, B, lr, mom);
            end
            a_mean3=mean(accur3,2);
            a_end3 = mean(a_mean3(end-20:end));
            c_mean3=mean(J_step3,2);
            c_end3 = mean(c_mean3(end-20:end));
            
            save(sprintf('./SaveData/SUa3_B%d_lr%0.1f_mom%0.1f.mat', B, lr, mom), 'a_end3');
            save(sprintf('./SaveData/SUc3_B%d_lr%0.1f_mom%0.1f.mat', B, lr, mom), 'c_end3');
        end
    end
end

