function [ T, Tidx, NewSize ] = TensorContract( A, B, Aidx, Bidx, Newidx, IdxShape )
% Revised on 2019.05.15, Tao Qing @ RUC
% aidx, bidx, Newidx are all strings, string can be number and letter or mixed
% IdxShape is the index shape, not the size shape
% If Newidx = []: no permutation is needed;
% If IdxShape = []: no reshape is needed.
% Tidx: the index without considering the IdxShape

if( nargin < 6 )
    IdxShape = [];
end

if( nargin < 5 )
    Newidx = [];
end

Arank = numel( Aidx );
Asize = GetTensorSize( A, Arank );
Brank = numel( Bidx );
Bsize = GetTensorSize( B, Brank );

[ PermA, PermB, MatrixAsize, MatrixBsize, TensorSize, ABorder, NewSize, Tidx ] = DeterCinfo( ...
    Aidx, Bidx, Newidx, Asize, Bsize, IdxShape );

[ T, NewSize ] = TensorContractFast( A, B, Asize, Bsize, PermA, PermB, MatrixAsize, MatrixBsize, TensorSize, ABorder, NewSize );
end

    
    
% the end
    
    
  