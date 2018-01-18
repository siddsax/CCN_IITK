function actions = legal_actions(curr,mat)

actions= [];
if(curr-1>0); actions = [actions 1]; end; % left
if(rem(curr,length(mat))~=0); actions = [actions 2]; end; % right
if(curr-length(mat)>0); actions = [actions 3]; end; % down
if(curr+length(mat)<length(mat)^2); actions = [actions 4]; end; % up

return;