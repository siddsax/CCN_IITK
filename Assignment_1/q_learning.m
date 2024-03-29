alpha = 0.3;
gamma = 0.9;

% importing a 10x10 grid with punishment at 1,1 and 5,5 while a reward at 9,9 and 2,2
environment_design;


vec = reshape(mat,1,length(mat)^2);

V = zeros(1,length(vec));
Q = zeros(4,length(vec));

% defining the inital position randomly
curr = ceil(rand*length(mat)^2);

% list of legal actions at this position
possible_actions = legal_actions(curr,mat);

rew = 0;
iters = 10000;
for time = 1:iters
    Q_val = -inf;
    action_optimal_1 = 0;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Epsilon Greedy Policy %%%%%%%%%%%%%%%%%%%%%%%% 
    p = .5 + time/(2*iters);
    epsln = binornd(1,p);
    for indx = 1:length(possible_actions)
        pos = update_position(curr,possible_actions(indx),mat);
        
        if(Q(possible_actions(indx),curr)>Q_val);
            action_optimal_1 = possible_actions(indx);
            Q_val = Q(possible_actions(indx),curr);
        end;
    end;
    action_optimal_2 = possible_actions(ceil(rand*length(possible_actions)));
    if(epsln==1);
        action_optimal = action_optimal_1;
    else;
        action_optimal = action_optimal_2;
    end;    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
    R = vec(curr);
    rew = rew + R;
    new = update_position(curr,action_optimal,mat);
    if(time==1);
        action_now = action_optimal;      
        curr = new;
        possible_actions = legal_actions(curr,mat);

    else;

        % best action at s'
        t1 = legal_actions(new,mat);
        t2 = -inf;
        for indx = 1:length(t1)
            pos = update_position(new,t1(indx),mat);
            
            if(Q(t1(indx),new)>t2);
                t3 = t1(indx);
                t2 = Q(t1(indx),new);
            end;
        end;
        % Q(s,a) = (1-alpha)Q(s,a) + alpha*(R + gamma*(max over actions at s' Q(a',s'))) 
        action_now = action_optimal;      
        Q(action_now,curr) = (1-alpha)*Q(action_now,curr) + alpha*(R + gamma*Q(t3,new));
        % updating the value function as \sum_i^N p_i*R_i over actions 
        V(curr) = p*Q(action_optimal_1,curr) + (1-p)*(sum(Q(:,curr))-Q(action_optimal_1,curr))/(length(possible_actions)-1);
        curr = new;
        possible_actions = legal_actions(curr,mat);
        Vmat = reshape(V,length(mat), length(mat));
        % Learning Error
        error(time) = sqrt(sum((mat(mat~=0) - Vmat(mat~=0)).^2));    
        cumR(time) = R;
    end;
end;
% disp(Q)
disp(rew)
display(Vmat);
 plot(error);
 plot(cumR);
  imagesc(Vmat);    
% close(vidObj);
