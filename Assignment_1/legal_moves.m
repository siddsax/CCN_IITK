
function moves = legal_moves(curr,mat)

moves= [];
if(curr-1>0); moves = [moves curr-1]; end;
if(rem(curr,length(mat))~=0); moves = [moves curr+1]; end;
if(curr-length(mat)>0); moves = [moves curr-length(mat)]; end;
if(curr+length(mat)<length(mat)^2); moves = [moves curr+length(mat)]; end;

return;


% function actions = legal_moves(curr,mat)

% actions= [];
% if(curr-1>0); actions = [actions 1]; end; % left
% if(rem(curr,length(mat))~=0); actions = [actions 2]; end; % right
% if(curr-length(mat)>0); actions = [actions 3]; end; % down
% if(curr+length(mat)<length(mat)^2); actions = [actions 4]; end; % up

% return;