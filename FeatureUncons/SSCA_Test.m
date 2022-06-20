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
tau=0.05;

T=1000;
B_list = [10];
a1_list = [0.7];  % [0.3, 0.7]--> opt: [0.7, 0.7, 0.7]
a2_list = [0.3];  % [0.3, 0.7]--> opt: [0.3, 0.3, 0.3]
alpha_list = [0.1, 0.2, 0.4, 0.5, 0.6];  % [0.3, 0.7]--> opt: [0.3, 0.3, 0.3]-->[0.3, 0.2, 0.2]
for i = 1 : length(B_list)
    B = B_list(i);
    for j = 1 : length(a1_list)
        a1 = a1_list(j);
        for k = 1 : length(a2_list)
            a2 = a2_list(k);
            for l = 1 : length(alpha_list)
                alpha = alpha_list(l);
                for iter=1:L
                    fprintf('\nTraining Neural Network... \n')
                    Theta1a=initial_Theta1;
                    Theta2a=initial_Theta2;
                    Total_grad1=zeros(size(Theta1a));
                    Total_grad2=zeros(size(Theta2a));
                    % training
                    t1 = clock;
                    for t=1:T
                        rho = a1/t^alpha;  gamma = a2/t^(alpha);
                        % sampling
                        rand_set = randperm(img_train_num); % ѵ��������
                        minibatch = rand_set(1:B*N);        % ȡһ��minibatch
                        X = img_train(:, minibatch);      % minibatch sample set
                        y = lab_train(minibatch);     % minibatch label set
                        
                        % SSCA update
                        [Theta1_grad, Theta2_grad] = nnGradient(Theta1a,Theta2a, input_layer_size, hidden_layer_size, num_labels, X, y, lambda);  %�ݶ�
                        Total_grad1 = (1-rho)*Total_grad1+rho*(Theta1_grad-2*tau*Theta1a);
                        Total_grad2 = (1-rho)*Total_grad2+rho*(Theta2_grad-2*tau*Theta2a);
                        J = nnCostFunction(Theta1a, Theta2a, num_labels, img_train, lab_train, lambda);        %cost function
                        J_step1(t,iter)=J;    %������cost function��¼
                        Theta1 = -0.5*Total_grad1/tau;
                        Theta2 = -0.5*Total_grad2/tau;
                        Theta1a = (1-gamma)*Theta1a+gamma*Theta1;     %model update
                        Theta2a = (1-gamma)*Theta2a+gamma*Theta2;     %model update
                        pred = Predict(Theta1a, Theta2a, img_test);
                        %             pred = pred';
                        accur1(t,iter)=mean(double(pred == lab_test)) * 100;
                        fprintf('\nTest accuracy of step %d iteration %d (SSCA): %f\n', t, iter, mean(double(pred == lab_test)) * 100);    %׼ȷ��
                        
                    end
                    t2 = clock;
                    time4 = etime(t2, t1);
                    fprintf('\nComplete training of iteration %d for B=%d, a1=%0.1f, a2=%0.1f, alpha=%0.1f\n', iter, B, a1, a2, alpha);
                end
                a_mean1=mean(accur1,2);
                a_end1 = mean(a_mean1(end-20:end));
                c_mean1=mean(J_step1,2);
                c_end1 = mean(c_mean1(end-20:end));
                
                save(sprintf('./SaveData/FUa1_B%d_a1%0.1f_a2%0.1f_alpha%0.1f.mat', B, a1, a2, alpha), 'a_end1');
                save(sprintf('./SaveData/FUc1_B%d_a1%0.1f_a2%0.1f_alpha%0.1f.mat', B, a1, a2, alpha), 'c_end1');
                save(sprintf('./SaveData/FUt1_B%d_a1%0.1f_a2%0.1f_alpha%0.1f.mat', B, a1, a2, alpha), 'time4');
            end
        end
    end
end

