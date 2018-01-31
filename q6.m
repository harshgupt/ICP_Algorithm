ptsP = pcread('bun000.ply');
ptsQ = pcread('bun045.ply');
normals = pcnormals(ptsP);

[n,~] = size(ptsP.Location);
sample = 40000;
iter = 10;
ptsOld = ptsQ.Location;
for x = 1:iter
    B = zeros(sample,1);
    A1 = B;
    A2 = B;
    A3 = B;
    ptsOld = ptsQ.Location;
    neighbours = knnsearch(ptsOld,ptsP.Location);
    for index = 1:sample
        ptsNear(index,:) = ptsOld(neighbours(index),:);
    end
    for index = 1:sample
        B(index) = ((normals(index,1)*ptsP.Location(index,1)) + (normals(index,2)*ptsP.Location(index,2)) + (normals(index,3)*ptsP.Location(index,3)) - (normals(index,1)*ptsNear(index,1)) - (normals(index,2)*ptsNear(index,2)) - (normals(index,3)*ptsNear(index,3)));
        A1(index) = (normals(index,3)*ptsNear(index,2)) - (normals(index,2)*ptsNear(index,3));
        A2(index) = (normals(index,1)*ptsNear(index,3)) - (normals(index,3)*ptsNear(index,1));
        A3(index) = (normals(index,2)*ptsNear(index,1)) - (normals(index,1)*ptsNear(index,2));
    end
    A = [A1 A2 A3 normals(1:sample,:)];
    X = (A' * A) \ (A' * B);
    tform = makehgtform('xrotate',X(1),'yrotate',X(2),'zrotate',X(3),'translate',[X(4) X(5) X(6)]);
    tform = affine3d(tform');
    ptsQ = pctransform(ptsQ,tform);
end
normalsQ = pcnormals(ptsQ);
figure;
pcshowpair(ptsP,ptsQ);
hold on
x = ptsP.Location(1:10:end,1);
y = ptsP.Location(1:10:end,2);
z = ptsP.Location(1:10:end,3);
u = normals(1:10:end,1);
v = normals(1:10:end,2);
w = normals(1:10:end,3);
quiver3(x,y,z,u,v,w);
x = ptsQ.Location(1:10:end,1);
y = ptsQ.Location(1:10:end,2);
z = ptsQ.Location(1:10:end,3);
u = normalsQ(1:10:end,1);
v = normalsQ(1:10:end,2);
w = normalsQ(1:10:end,3);
quiver3(x,y,z,u,v,w);
hold off