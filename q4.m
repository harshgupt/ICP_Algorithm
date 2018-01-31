ptsP = pcread('bun000.ply');
ptsQ = pcread('bun045.ply');
iter = 50;
ptsSubP = ptsP.Location(1:10000,:);
[n, ~] = size(ptsSubP);
ptsOldQ = ptsQ.Location;
for x = 1:iter
neighbours = knnsearch(ptsOldQ,ptsSubP);
for index = 1:n
    ptsNear(index,:) = ptsOldQ(neighbours(index),:);
end
[R, T] = icpAlgo(ptsSubP,ptsNear);
for y = 1:ptsQ.Count
    ptsOldQ(y,:) = (R * ptsOldQ(y,:)' + T)';
end
end
ptsNew = pointCloud(ptsOldQ);
figure;
pcshowpair(ptsP,ptsNew);