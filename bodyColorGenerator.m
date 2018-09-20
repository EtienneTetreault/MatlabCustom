function multibodies = bodyColorGenerator(patchBody, colorMapsArray)

dim = size(colorMapsArray);
if rem(dim(2),3) ~= 0
    error('Number of columns in colorMapsArray cannot be divided by 3')
end
nBodies = dim(2)/3;
colorMapsArray = reshape(colorMapsArray, dim(1),3, nBodies);
bodyOut = patchBody;

multibodies = cell(1, nBodies);
for i = 1:nBodies
    cMap = colorMapsArray(:,:,i);
    bodyOut.FaceVertexCData = cMap(floor(1+patchBody.FaceVertexCData*(length(cMap)-1)),:);
    multibodies{i} = bodyOut;
end