alpha = 0.3;
gamma = 0.9;

% importing a 10x10 grid with punishment at 1,1 and 5,5 while a reward at 9,9 and 2,2
environment_design;


vec = reshape(mat,1,length(mat)^2);
% initializing expected future reward at each position to zero
V = zeros(1,length(vec));
Q = zeros(4,length(vec));

% defining the inital position randomly
curr = 24%ceil(rand*length(mat)^2);

% list of legal actions at this position
possible_actions = legal_actions(curr,mat);

rew = 0;
iters = 100;
for time = 1:iters
% reward at present position
    Q_val = -1000;
    action_optimal = 0;
    epsln = binornd(1,.5 + time/(2*iters));
    if(epsln==1);
        for indx = 1:length(possible_actions)
            pos = update_position(curr,possible_actions(indx),mat);
            
            if(Q(possible_actions(indx),curr)>Q_val);
                action_optimal = possible_actions(indx);
            end;
        end;
    else;
        action_optimal = possible_actions(ceil(rand*length(possible_actions)));
    end;    
    R = vec(curr);
    % choosing a random move
    new = update_position(curr,action_optimal,mat);
    % updating the expected future reward at present position
    if(time==1);
        action_now = action_optimal;      
        curr = new;
        possible_actions = legal_actions(curr,mat);

    else;
        % display(action_now)
        % display(curr)
        % display('----------')
        % display(action_optimal);
        % display(new)
        Q(action_now,curr) = Q(action_now,curr) + alpha*(R + Q(action_optimal,new) - Q(action_now,curr));
        V(curr) = sum(Q(:,curr))/length(possible_actions);
        action_now = action_optimal;      
        curr = new;
        possible_actions = legal_actions(curr,mat);
        Vmat = reshape(V,length(mat), length(mat));
        % TD Learning Error
        error(time) = sqrt(sum((mat(mat~=0) - Vmat(mat~=0)).^2));    
        cumR(time) = R;
        rew = rew + R;
    end;
end;
display(rew);
 plot(error);
 plot(cumR);
  % imagesc(Vmat);    
% close(vidObj);