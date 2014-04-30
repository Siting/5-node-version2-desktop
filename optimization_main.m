% This file contains the optimization problem
clear all
clc

% set parameters
numFacilities = 2;
numNodes = 5;       % number of nodes on the network
numRoutes = 4;      % number of candidate routes

% load b_qh, a_hp, flow
load('./result/b_qh');
load('./result/a_hp');
load('generated_flows_all.mat');

% assign variables into opt
% f, A, b, Aeq, beq
f = flows(:,2);
beq = numFacilities;
Aeq = 
