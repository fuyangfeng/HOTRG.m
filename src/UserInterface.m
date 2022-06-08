function [ Inface ] = UserInterface
% D=64, 2.5 minutes/RG
% triangle lattice

Inface.Temp = [ 2 : 1 : 3.8 ];

Inface.Dbond = 16;
Inface.RGstep = 64;
Inface.Field = 1E-10;

Inface.Jxy = 1;
Inface.Jz = 1;
