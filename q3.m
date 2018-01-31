ptsP = pcread('bun000.ply');
ptsQ = pcread('bun045.ply');
iter = 80;
[n, ~] = size(ptsP.Location);
ptsOld = addNoise(ptsQ,0.05);
% for x = 1:iter
% neighbours = knnsearch(ptsOld,ptsP.Location);
% for index = 1:n
%     ptsNear(index,:) = ptsOld(neighbours(index),:);
% end
% [R, T] = icpAlgo(ptsP.Location,ptsNear);
% for y = 1:ptsQ.Count
%     ptsOld(y,:) = (R * ptsOld(y,:)' + T)';
% end
% end
ptsNew = pointCloud(ptsOld);
figure;
pcshowpair(ptsP,ptsNew);