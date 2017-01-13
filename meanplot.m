
function [xax, yax] = meanplot(input,stepsize,tottime)

numcells = size(input,2);

xax = stepsize:stepsize:tottime;
yax = zeros(numcells,size(xax,2));


for i=1:numcells
    X = input{i};
    maxx = size(input{i},2)-1;
    if (maxx>0 && X(1,maxx)==0)
        X(1,maxx) = 0.001;
    end
    X(3,1:maxx) = floor(X(2,1:maxx)/stepsize);

    %assert(max(X(3,:))<=size(xax,2),'ERROR: too big!');
    yax(i,X(3,1:maxx)) = X(1,1:maxx);
    
    ind = find(yax(i,:)==0);
    for j=2:numel(ind)
        yax(i,ind(j)) = yax(i,ind(j)-1);
    end
end
