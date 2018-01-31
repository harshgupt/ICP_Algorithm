ptsP = pcread('bun000.ply');
ptsQ = pcread('bun000.ply');
rotate = pi/6;
translate = [0 0 0];
iter = 30;
tformMat = [cos(rotate) sin(rotate) 0 0; -sin(rotate) cos(rotate) 0 0; 0 0 1 0; translate 1];
tformMat = affine3d(tformMat);
ptsQ = pctransform(ptsQ,tformMat);
[n, ~] = size(ptsP.Location);
ptsOld = ptsQ.Location;
for x = 1:iter
neighbours = knnsearch(ptsOld,ptsP.Location);
for index = 1:n
    ptsNear(index,:) = ptsOld(neighbours(index),:);
end
[R, T] = icpAlgo(ptsP.Location,ptsNear);
for y = 1:ptsQ.Count
    ptsOld(y,:) = (R * ptsOld(y,:)' + T)';
end
end
ptsNew = pointCloud(ptsOld);
figure;
pcshowpair(ptsP,ptsNew);