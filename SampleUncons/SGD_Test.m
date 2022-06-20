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
B_list = [10];
lr_init_list = [0.4, 0.5, 0.6, 0.7, 0.8, 0.9];  % [0.1, 0.3, 1] --> opt: [0.5, 1, 1]
dim_list = [0.1];  % [0.1, 0.3, 0.5] --> opt: [0.1, 0.1, 0.1]
for i = 1 : length(B_list)
    B = B_list(i);
    for j = 1 : length(lr_init_list)
        lr_init = lr_init_list(j);
        for k = 1 : length(dim_list)
            dim = dim_list(k);
            
            for iter=1:L
                fprintf('\nTraining Neural Network... \n')
                Theta1b=initial_Theta1;
                Theta2b=initial_Theta2;
                Total_grad1=zeros(size(Theta1b));
                Total_grad2=zeros(size(Theta2b));
                % training
                for t=1:T
                    lr = lr_init/(t^dim);
                    %                         lr = 0.4/t^0.5;  mom = 0.1; eta = 1;
                    % sampling
                    rand_set = randperm(img_train_num); % ѵ��������
                    minibatch = rand_set(1:B*N);        % ȡһ��minibatch
                    X = img_train(:, minibatch);      % minibatch sample set
                    y = lab_train(minibatch);     % minibatch label set
                    
                    % SGD update
                    [Theta1_grad, Theta2_grad] = nnGradient(Theta1b,Theta2b, input_layer_size, hidden_layer_size, num_labels, X, y, lambda);  %�ݶ�
                    J = nnCostFunction(Theta1b, Theta2b, num_labels, img_train, lab_train, lambda);        %cost function
                    J_step2(t,iter)=J;    %������cost function��¼
                    Theta1b = Theta1b-lr*Theta1_grad;   %model update
                    Theta2b = Theta2b-lr*Theta2_grad;
                    pred = Predict(Theta1b, Theta2b, img_test);
                    accur2(t,iter)=mean(double(pred == lab_test)) * 100;
                    fprintf('Test accuracy of step %d for B=%d, lrinit=%0.1f, dim=%0.1f (SGD): %f\n', t, B, lr_init, dim,...
                        mean(double(pred == lab_test)) * 100);    %׼ȷ��
                end
                fprintf('\nComplete training of iteration %d for B=%d, lrinit=%0.1f, dim=%0.1f\n', iter, B, lr_init, dim);
            end
            a_mean2=mean(accur2,2);
            a_end2 = mean(a_mean2(end-20:end));
            c_mean2=mean(J_step2,2);
            c_end2 = mean(c_mean2(end-20:end));
            
            save(sprintf('./SaveData/SUa2_B%d_lrinit%0.1f_dim%0.1f.mat', B, lr_init, dim), 'a_end2');
            save(sprintf('./SaveData/SUc2_B%d_lrinit%0.1f_dim%0.1f.mat', B, lr_init, dim), 'c_end2');
        end
    end
end

