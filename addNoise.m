function newPts = addNoise(pts,deviation)

newPts = pts.Location;
xLim = pts.XLimits * deviation;
yLim = pts.YLimits * deviation;
zLim = pts.ZLimits * deviation;

for i = 1:pts.Count
newPts(i,1) = newPts(i,1) + xLim(1) + (xLim(1) - xLim(2)) * randn(1);
newPts(i,2) = newPts(i,2) + yLim(1) + (yLim(1) - yLim(2)) * randn(1);
newPts(i,3) = newPts(i,3) + zLim(1) + (zLim(1) - zLim(2)) * randn(1);
end
end