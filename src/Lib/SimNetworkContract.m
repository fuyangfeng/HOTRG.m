function [ T, Tidx, Tsize ] = SimNetworkContract( TensorCell, IdxCell, Fidx, IdxShape )
% TensorCell is the data-set, IdxCell is the index-set
% Contract the cell data automatically, then give result to T and Tidx,
% Coef is the renormalized factor
% Modified on 2019.05.15, Tao Qing @ RUC

Ntensor = numel( TensorCell );
T = TensorCell{ 1 };
Tidx = IdxCell{ 1 };
Tsize = GetTensorSize( T, numel( Tidx ) );

for iterNo = 2 : Ntensor
    [ T, Tidx, Tsize ] = TensorContract( T, TensorCell{ iterNo }, Tidx, IdxCell{ iterNo } );
end

if( nargin < 4 )
    IdxShape = [];
end

if( nargin < 3 )||( isempty( Fidx ) )
    Fidx = Tidx;
end

Order = GetPermOrder( Tidx, Fidx );
Tidx = Fidx;

if( ~isempty( Tsize ) )
    [ T, Tsize ] = TensorRPR( T, Tsize, [], Order, IdxShape, 0 );
end
end

% the end
