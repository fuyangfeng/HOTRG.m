function [ varargout ] = GetFields( ExamStruct, varargin )
% similarly as built-in function getfield
% Modified on 2019.05.15, Tao Qing @ RUC

d = numel( varargin );
varargout = cell( d, 1 );
for i = 1 : d
    varargout{ i } = ExamStruct.( varargin{ i } );
end
end
    
    
% the end
    
    