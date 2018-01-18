
function final_pos = update_position(curr,action,mat)


if(action == 1); final_pos = curr-1; end; 
if(action == 2); final_pos = curr+1; end;
if(action == 3); final_pos = curr-length(mat); end;
if(action == 4); final_pos = curr+length(mat); end;

return;


% function moves = legal_moves(curr,mat)

% moves= [];
% if(curr-1>0); moves = [moves curr-1]; end;
% if(rem(curr,length(mat))~=0); moves = [moves curr+1]; end;
% if(curr-length(mat)>0); moves = [moves curr-length(mat)]; end;
% if(curr+length(mat)<length(mat)^2); moves = [moves curr+length(mat)]; end;

% return;
