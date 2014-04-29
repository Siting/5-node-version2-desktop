clear all
clc

dbstop if error

global full_range

% set parameters
networkID = '5Node-network';
numNodes = 5;
numRoutes = 2;       % number of candidate routes
numFacilities = 3;
% numStations = 1;     % number of stations to locate
% numPads = 1;         % number of pads(routes) to locate
full_range = 5;      % set full capacity vehicle range (in mile)
c_station = 2;       % cost for charging station
c_pad = 5;           % cost for charging pad


b_qh_all = [];
a_hp_all = [];
keyboard
for numStations = 1 : numNodes
    
    numPads = numFacilities - numStations;
        
        keyboard
        % load critical infomation
        [shortest_paths_matrix, TOP_FLOWS, linkIDMatrix, LINK] = loadCriticalInfo(networkID,...
            numRoutes);
        
        % generate b_qh, a_hp
        [b_qh, a_hp] = generateCoefficientMatrices(shortest_paths_matrix,...
            TOP_FLOWS, numNodes, numStations, numPads, linkIDMatrix,...
            numRoutes, LINK);
        
        b_qh_all = [b_qh_all b_qh];
        a_hp_all = [a_hp_all; a_hp];

end










% 
% % compute refuled flow for each combination
% % map keys: combinationID
% % map structure: combinationID, refuled total flow, refueled flow ids
% % comMatrix, each row: [combinationID, cost, totalRefueledFlow]
% [COMBINATION, comMatrix] = generateCombinations(b_qh, a_hp, flows, numNodes, TOP_FLOWS);
% 
% 
% % sort combinations
% comIDs_sorted = sort(comMatrix,2);
% comIDs_sorted = flipud(comIDs_sorted);

% save variables
save('./result/b_qh', 'b_qh');
dlmwrite('./result/b_qh.txt', b_qh);
save('./result/a_hp', 'a_hp');
dlmwrite('./result/a_hp.txt', a_hp);
save('./result/COMBINATION', 'COMBINATION');
save('./result/comIDs_sorted', 'comIDs_sorted');
dlmwrite('./result/comIDs_sorted.txt', comIDs_sorted);


