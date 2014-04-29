function[b_qh, a_hp] = pregenerateCoefficientMatrix(shor_paths, TOP_FLOWS,...
    numNodes, numStations, numPads)

numODPairsTotal = size(shor_paths,1);
numODPairsTop = length(TOP_FLOWS);

%% a_hp = 1 if a facility is assigned to potential location for combination
% h

% initialize all entries as 0
numColumns_a = numNodes + numODPairsTop;
numRows_a = nchoosek(numNodes, numStations) * nchoosek(numODPairsTop, numPads);
a_hp = zeros(numRows_a, numColumns_a); % pre-allocate space

% unit block for nodes
% list out all combinations
nodeCombinationMatrix = zeros(nchoosek(numNodes, numStations),numNodes);
indexCombinations_nodes = nchoosek(1:numNodes,numStations);
for i = 1 : size(nodeCombinationMatrix,1)
    nodeCombinationMatrix(i,indexCombinations_nodes(i,:)) = 1;
end

numCombination_pads = nchoosek(numODPairsTop, numPads);
nodeCombinationMatrix = repmat(nodeCombinationMatrix,numCombination_pads,1);

% for routes/flows (entire, not each unit)
routeCombinationMatrix = zeros(numRows_a, numODPairsTop);
indexCombinations_routes = nchoosek(1:numODPairsTop,numPads);

replicateRows = kron(indexCombinations_routes,ones(nchoosek(numNodes, numStations),1));
for i = 1 : length(replicateRows)
    routeCombinationMatrix(i, replicateRows(i,:)) = 1;
end

% first time generate a_hp
a_hp = [nodeCombinationMatrix routeCombinationMatrix];

% exclude combinations with overlapping charging station and charging pad
[a_hp, removeComs] = excludeCombinations_a_hp(a_hp, TOP_FLOWS, numNodes);

%% b_qh = 1 if combination h can refule path q\
% for now, initialize all elements to 0
numColumns_b = numRows_a;
numRows_b = numODPairsTotal;

b_qh = zeros(numRows_b, numColumns_b);

% exclude correspoding combinations
b_qh(:,removeComs) = [];


