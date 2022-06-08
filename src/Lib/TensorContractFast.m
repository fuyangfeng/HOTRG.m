function [ T, TensorSize ] = TensorContractFast( A, B, Arank, Brank, PermA, PermB, MatrixAsize, MatrixBsize, TensorSize, ABorder, NewSize )
% Revised on 2019.05.15, Tao Qing @ RUC
% Fast contraction: all the information was input manually!!


if( numel( Arank ) == 1 )
    Asize = GetTensorSize( A, Arank );
else
    Asize = Arank;
    Arank = numel( Asize );
end

if( numel( Brank ) == 1 )
    Bsize = GetTensorSize( B, Brank );
else
    Bsize = Brank;
    Brank = numel( Bsize );
end

% permute as suitable ordering
if( ( ~isempty( PermA ) )&&( ~isequal( PermA, 1:Arank ) ) )
    A = permute( A, PermA );
    Asize = Asize( PermA );
end

if( ( ~isempty( PermB ) )&&( ~isequal( PermB, 1:Brank ) ) )
    B = permute( B, PermB );
    Bsize = Bsize( PermB );
end

% reshape to matrix form
if( ( ~isempty( MatrixAsize ) )&&( ~isequal( MatrixAsize, Asize ) ) )
    A = reshape( A, MatrixAsize );
end

if( ( ~isempty( MatrixBsize ) )&&( ~isequal( MatrixBsize, Bsize ) ) )
    B = reshape( B, MatrixBsize );
end

% T is just a matrix
T = A * B;
Trank = 2;

% return as tensor form
if( ( ~isempty( TensorSize ) )&&( ~isequal( TensorSize, size( T ) ) ) )
    T = reshape( T, TensorSize );
    Trank = numel( TensorSize );
end

% Use permutation or not
if( ( ~isempty( ABorder ) )&&( ~isequal( ABorder, 1:Trank ) ) )
    T = permute( T, ABorder );
    TensorSize = TensorSize( ABorder );
end

% reshape to new form or not
if( ( ~isempty( NewSize ) )&&( ~isequal( NewSize, TensorSize ) ) )
    T = reshape( T, NewSize );
    TensorSize = NewSize;
end

end
    
    
% the end
    