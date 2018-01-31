pts1 = pcread('bun045.ply');
pts2 = pcread('bun045.ply');
pts3 = pcread('bun045.ply');
pts4 = pcread('bun045.ply');
pts5 = pcread('bun045.ply');
iter = 50;
tformMat = [cos(pi/6) sin(pi/6) 0 0; -sin(pi/6) cos(pi/6) 0 0; 0 0 1 0; 0 0 0 1];
tformMat2 = [cos(pi/8) sin(pi/8) 0 0; -sin(pi/8) cos(pi/8) 0 0; 0 0 1 0; 0 0 0 1];
tformMat = affine3d(tformMat);
tformMat2 = affine3d(tformMat2);
pts2 = pctransform(pts2,tformMat);
pts3 = pctransform(pts3,tformMat);
pts3 = pctransform(pts3,tformMat);
pts4 = pctransform(pts4,tformMat2);
pts5 = pctransform(pts5,tformMat2);
pts5 = pctransform(pts5,tformMat2);
[n, ~] = size(pts1.Location);
ptsOld2 = pts2.Location;
for x = 1:iter
neighbours = knnsearch(ptsOld2,pts1.Location);
for index = 1:n
    ptsNear(index,:) = ptsOld2(neighbours(index),:);
end
[R, T] = icpAlgo(pts1.Location,ptsNear);
for y = 1:pts2.Count
    ptsOld2(y,:) = (R * ptsOld2(y,:)' + T)';
end
end
ptsNew2 = pointCloud(ptsOld2);
ptsOld3 = pts3.Location;
for x = 1:iter
neighbours = knnsearch(ptsOld3,pts1.Location);
for index = 1:n
    ptsNear(index,:) = ptsOld3(neighbours(index),:);
end
[R, T] = icpAlgo(pts1.Location,ptsNear);
for y = 1:pts3.Count
    ptsOld3(y,:) = (R * ptsOld3(y,:)' + T)';
end
end
ptsNew3 = pointCloud(ptsOld3);
ptsOld4 = pts4.Location;
for x = 1:iter
neighbours = knnsearch(ptsOld4,pts1.Location);
for index = 1:n
    ptsNear(index,:) = ptsOld4(neighbours(index),:);
end
[R, T] = icpAlgo(pts1.Location,ptsNear);
for y = 1:pts4.Count
    ptsOld4(y,:) = (R * ptsOld4(y,:)' + T)';
end
end
ptsNew4 = pointCloud(ptsOld4);
ptsOld5 = pts5.Location;
for x = 1:iter
neighbours = knnsearch(ptsOld5,pts1.Location);
for index = 1:n
    ptsNear(index,:) = ptsOld5(neighbours(index),:);
end
[R, T] = icpAlgo(pts1.Location,ptsNear);
for y = 1:pts5.Count
    ptsOld5(y,:) = (R * ptsOld5(y,:)' + T)';
end
end
ptsNew5 = pointCloud(ptsOld5);
figure;
pcshow(pts1);
hold on;
pcshow(ptsNew2);
hold on;
pcshow(ptsNew3);
hold on;
pcshow(ptsNew4);
hold on;
pcshow(ptsNew5);