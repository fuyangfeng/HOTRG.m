function [ T, Tsize ] = TensorPosActs( T, Matrix, Pls, Tsize )
% different from TensorPosAct
% Matrix is a cell, Pls is a vector
% Modified on 2019.05.15, Tao Qing @ RUC

if( numel( Tsize ) == 1 )
    Tsize = GetTensorSize( T, Tsize );
end

for id = 1 : numel( Matrix )
    [ T, Tsize ] = TensorPosAct( T, Matrix{ id }, Pls( id ), Tsize );
end

end

