function PirateGame()
%% Background
%
% Reference 1: https://en.wikipedia.org/wiki/Pirate_game
% Reference 2: https://baike.baidu.com/item/%E6%B5%B7%E7%9B%97%E5%88%86%E9%87%91/172169
%% Definition
global G;
global N;
global R;
G = 100;
N = 5;
R = zeros(N,N);

%% Main Iteration
CorePirate(1);
    
%% Output

if checkresult() == 1
    fprintf('Plan generated!\n')
    printLine(N);
    printHead(N)
    printLine(N);
    printResult(R,N)
    printLine(N);
    printData(R,N)
    printLine(N);
else
    printResult(R,N);
    error('PIRATEGOLD: Found inconsistency!\n')

end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function CorePirate(m)
global G;
global N;
global R;

    switch m
        case 1
            R(N,N) = G;
        case 2
            R(N-1, N-1) = G; % N-i+1 表示倒数第i个
            R(N-1, N) = 0;
        case 3
            R(N-m+1, N-m+1) = G; % N-i+1 表示倒数第i个
            R(N-m+1, N-m+2) = 0;
            R(N-m+1, N-m+3) = 0;
        otherwise
            % 基本策略：
            % 1. 给剩余的人前述方案由小到大排序
            % 2. 保留自己、放弃下一个人
            % 3. 如果是奇数个人，给排序后的(m-2-1)/2人每个人加1个;
            % 4. 如果是偶数个人，给排序后的(m-2)/2人每个人加1个

            % 核心策略差异：
            % 1. 核心是从第四个往后，反正也拿不到金币，那么是以后相安无事给人留条命，还是把人害死？
            % 2. 计算分配方案时，是让其他海盗的所得比之前多，还是不少就好？基本原则同上一条。

            R(N-m+1, N-m+2) = 0;
            [~,ind] = sort(R(N-m+2, (N-m+3:N)));

            if mod(m,2)==1
                NewDistribution = (m-2+1)/2;
            else
                NewDistribution = (m)/2;
            end
            
            GoldRemain = G - sum(R(N-m+2, (N-m+3:N))) - NewDistribution + sum(R(N-m+2, ((N-m+2)+ind(NewDistribution+1:end))));

            R(N-m+1, N-m+1) = GoldRemain; % N-i+1 表示倒数第i个
            R(N-m+1, ((N-m+2)+ind(1:NewDistribution))) = R(N-m+2, ((N-m+2)+ind(1:NewDistribution))) + 1;

    end
    if m<N
        CorePirate(m+1);
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function printLine(N)
for ii = 1 : N
    fprintf('----');
end
fprintf('-\n');
end

function printHead(N)
for ii = 1 : N
    fprintf('p%d\t', ii);
end
fprintf('\n');
end

function printData(R,N)
for ii = 1 : N
    for jj = 1 : N
        if jj < ii
            fprintf('\t');
        else
            fprintf('%d\t', R(ii,jj));
        end
    end
    fprintf('\n');
end
end

function printResult(R,N)
for ii = 1 : N
    fprintf('%d\t', R(1,ii));
end
fprintf('\n');
end


function r = checkresult()
    global G;
    global N;
    global R;
    r = 1;
    if sum(sum(R)) ~= G*N
        r = 0;
    else
        for ii = 1 : N
            if (sum(R,2) ~= G) & (r == 1)
                r = 0;
            end
        end
    end
    
end