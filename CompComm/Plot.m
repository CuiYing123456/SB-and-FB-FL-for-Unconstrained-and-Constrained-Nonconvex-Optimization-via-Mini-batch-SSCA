clr = [[1, 0, 0]; [1, 0.5, 0]; [1, 0.8, 0.2]; 
    [0, 0.8, 0]; [0.2, 1, 0.2]; [0.5, 1, 0.5];
    [0.3, 0.2, 1]; [0.8, 0.3, 1]; [1, 0.5, 1]];
str = {'-'; '--'; '-.'; ':'};

%% 
Lgd1 = {};
figure(2);

% 85
comp = [10, 100, 6000];
comm1 = [28, 15, 14];
comm2 = [36, 25, 3];
comm3 = [33, 17, 3];
p = loglog(comp, comm1, 'o'); p.LineWidth = 1.3;  p.Color = clr(1,:);  p.LineStyle = 'none';  p.MarkerSize = 8;  hold on;
Lgd1{1} = sprintf('Alg.1,acc=85%s','%');
p = loglog(comp, comm2, 'o'); p.LineWidth = 1.3;  p.Color = clr(4,:);  p.LineStyle = 'none';  p.MarkerSize = 8;  hold on;
Lgd1{2} = sprintf('SGD,acc=85%s','%');
p = loglog(comp, comm3, 'o'); p.LineWidth = 1.3;  p.Color = clr(7,:);  p.LineStyle = 'none';  p.MarkerSize = 8;  hold on;
Lgd1{3} = sprintf('SGD-m,acc=85%s','%');

% 90
comp = [10, 100, 6000];
comm1 = [66, 26, 22];
comm2 = [153, 117, 13];
comm3 = [80, 49, 8];
p = loglog(comp, comm1, 's'); p.LineWidth = 1.3;  p.Color = clr(1,:);  p.LineStyle = 'none';  p.MarkerSize = 8;  hold on;
Lgd1{4} = sprintf('Alg.1,acc=90%s','%');
p = loglog(comp, comm2, 's'); p.LineWidth = 1.3;  p.Color = clr(4,:);  p.LineStyle = 'none';  p.MarkerSize = 8;  hold on;
Lgd1{5} = sprintf('SGD,acc=90%s','%');
p = loglog(comp, comm3, 's'); p.LineWidth = 1.3;  p.Color = clr(7,:);  p.LineStyle = 'none';  p.MarkerSize = 8;  hold on;
Lgd1{6} = sprintf('SGD-m,acc=90%s','%');

% 92
comp = [10, 100, 6000];
comm1 = [93, 52, 47];
comm2 = [415, 351, 38];
comm3 = [144, 100, 18];
p = loglog(comp, comm1, '*'); p.LineWidth = 1.3;  p.Color = clr(1,:);  p.LineStyle = 'none';  p.MarkerSize = 8;  hold on;
Lgd1{7} = sprintf('Alg.1,acc=92%s','%');
p = loglog(comp, comm2, '*'); p.LineWidth = 1.3;  p.Color = clr(4,:);  p.LineStyle = 'none';  p.MarkerSize = 8;  hold on;
Lgd1{8} = sprintf('SGD,acc=92%s','%');
p = loglog(comp, comm3, '*'); p.LineWidth = 1.3;  p.Color = clr(7,:);  p.LineStyle = 'none';  p.MarkerSize = 8;  hold on;
Lgd1{9} = sprintf('SGD-m,acc=92%s','%');

% % 95
% comp = [10, 100, 6000];
% comm1 = [357, 192, 183];
% comm2 = [1000, 1000, 260];
% comm3 = [414, 336, 70];
% p = loglog(comp, comm1); p.LineWidth = 1.2;  p.Color = clr(1,:);  p.LineStyle = str{3};  hold on;
% Lgd1{7} = sprintf('Alg.1,acc=95%s','%');
% p = loglog(comp, comm2); p.LineWidth = 1.2;  p.Color = clr(4,:);  p.LineStyle = str{3};  hold on;
% Lgd1{8} = sprintf('SGD,acc=95%s','%');
% p = loglog(comp, comm3); p.LineWidth = 1.2;  p.Color = clr(7,:);  p.LineStyle = str{3};  hold on;
% Lgd1{9} = sprintf('SGD-m,acc=95%s','%');

hold off;
legend(Lgd1);
grid on;
axis([-Inf, Inf, 1, 700]);
xlabel('Computation cost');
ylabel('Communication cost');


