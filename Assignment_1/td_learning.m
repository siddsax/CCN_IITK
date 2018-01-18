alpha = 0.3;
gamma = 0.9;

% importing a 10x10 grid with punishment at 1,1 and 5,5 while a reward at 9,9 and 2,2
environment_design;


vec = reshape(mat,1,length(mat)^2);
% initializing expected future reward at each position to zero
V = zeros(1,length(vec));
% defining the inital position randomly
curr = ceil(rand*length(mat)^2);

% finding the legal moves from initial position
moves= legal_moves(curr,mat);

rew = 0;
for time = 1:100
		% reward at present position
    R = vec(curr);
    % choosing a random move
    new = moves(ceil(rand*length(moves)));
    % updating the expected future reward at present position
    V(curr) = V(curr) + alpha*(R + gamma*V(new) - V(curr));        
    %updating position
    curr = new;
    moves= legal_moves(curr,mat);
    Vmat = reshape(V,length(mat), length(mat));
    % TD Learning Error
    error(time) = sqrt(sum((mat(mat~=0) - Vmat(mat~=0)).^2));    
    cumR(time) = R;
    rew = rew + R;

end;    
display(rew);
plot(error);
plot(cumR);
 % imagesc(Vmat);    
