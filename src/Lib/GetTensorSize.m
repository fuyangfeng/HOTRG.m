function [ TensorSize ] = GetTensorSize( T, Trank )
% To show forcely the latter singleton dimension
% Modified on 2019.05.15,  Tao Qing @ RUC 

TensorSize = size( T );
TensorSize( ( numel( TensorSize ) + 1 ) : Trank ) = 1;

end


% the end

 