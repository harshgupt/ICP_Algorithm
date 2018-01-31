function [R, T] = icpAlgo(P,Q)

% [nP, ~] = size(P);
% [nQ, ~] = size(Q);
avgP(1) = mean(P(:,1));
avgP(2) = mean(P(:,2));
avgP(3) = mean(P(:,3));
avgQ(1) = mean(Q(:,1));
avgQ(2) = mean(Q(:,2));
avgQ(3) = mean(Q(:,3));
dirP = [P(:,1) - avgP(1), P(:,2) - avgP(2), P(:,3) - avgP(3)];
dirQ = [Q(:,1) - avgQ(1), Q(:,2) - avgQ(2), Q(:,3) - avgQ(3)];
dirQ = dirQ';
A = dirQ * dirP;
[U, ~, V] = svd(A);
U = U';
R = V * U;
avgQ = avgQ';
avgP = avgP';
T = avgP - (R * avgQ);
end