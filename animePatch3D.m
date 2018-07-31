function animePatch3D(PosCG,quat,PatchBodies,skip,delay)


%Data pour boucle
nTime = size(PosCG,1);
nBodies = size(PosCG,3);

for j = 1:nBodies
    nIter = 1;
    Point = PatchBodies{j}.Vertices;
    nPoint = size(Point,1);
    for i = 1:skip:nTime
        q0 = quat(i,1,j);
        qx = quat(i,2,j);
        qy = quat(i,3,j);
        qz = quat(i,4,j);
        
        %Matrice de rotation WingToNewtonframe
        MatWtoN = [qx^2+q0^2-qy^2-qz^2  2*(qx*qy-qz*q0)  2*(qx*qz+qy*q0) ;...
            2*(qx*qy+qz*q0)  qy^2+q0^2-qx^2-qz^2  2*(qy*qz-qx*q0) ;...
            2*(qx*qz-qy*q0)  2*(qy*qz+qx*q0)  qz^2+q0^2-qx^2-qy^2 ];
        
        PosN = MatWtoN*Point.';
        PosN = PosN.' + repmat(PosCG(i,:,j),nPoint,1); %Distance par-rapport à N0 dans le référentiel N
        PosTemp(:,:,nIter) = PosN;
        nIter = nIter+1;
    end
    LimMax(j,:) = max(max(PosTemp,[],3));
    LimMin(j,:) = min(min(PosTemp,[],3));
    PosOutput{j} = PosTemp;
end

LimMax2 = max(LimMax);
LimMin2 = min(LimMin);
Plage = 1.2*max(LimMax2-LimMin2);
Center = mean([LimMax2;LimMin2]);
VecAxis = [Center(1)-Plage/2 , Center(1)+Plage/2 , ...
    Center(2)-Plage/2  , Center(2)+Plage/2  ...
    Center(3)-Plage/2  , Center(3)+Plage/2 ];

figure('Units','Normalized','Position',[0.05 0.03 0.9 0.9])
xlabel('x');ylabel('y');zlabel('z');
set(gca, 'YDir', 'reverse')
set(gca, 'ZDir', 'reverse')
grid on;
axis equal
view(3)
axis vis3d
axis(VecAxis)
% v = VideoWriter('test.avi');
% v.Quality = 95;
% open(v);

%         frame = getframe(gcf);
%         writeVideo(v,frame);


for i = 1:length(1:skip:nTime)
    for j = 1:nBodies
        PosTemp = PosOutput{j};
        PosDraw = PosTemp(:,:,i);
        patch('Vertices',PosDraw,'Faces',PatchBodies{j}.Faces,'FaceVertexCData',PatchBodies{j}.FaceVertexCData,'FaceColor','flat')
    end
    drawnow;
    pause()
    %     cla
end

% close(v)