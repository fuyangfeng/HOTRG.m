function [ T, NewSize ] = TensorPosAct( T, Matrix, Pls, Trs )
% sum{ T( i, j, k, l ) * Matrix( k, n ) } = T( i, j, n, l )
% to calculate passive act, one only has to transpose Matrix.
% Modified on 2019.05.15, Tao Qing @ RUC

if( numel( Trs ) == 1 )
    Trank = Trs;
    Tsize = GetTensorSize( T, Trank );
else
    Trank = numel( Trs );
    Tsize = Trs;
end

OtherId = [ 1:(Pls-1), (Pls+1):Trank ];
OtherDim = Tsize( OtherId );
NewDim = size( Matrix, 2 );
Cbond = Tsize( Pls );

% if Matrix transposition is more convenient: (ijkl)(in) => (njkl)
% i.e., if no permutation is necessary for the tensor: (ijkl)(ln) => (ijkn)
if( Pls == 1 )                                                        
    T = Matrix.' * reshape( T, [ Cbond, prod( OtherDim ) ] );
    T = reshape( T, [ NewDim, OtherDim ] );
    NewSize = [ NewDim, OtherDim ];
elseif( Pls == Trank )
    T = reshape( T, [ prod( OtherDim ), Cbond ] ) * Matrix;
    T = reshape( T, [ OtherDim, NewDim ] );
    NewSize = [ OtherDim, NewDim ];
else
% ============== general procedure: (ijkl)(kn) => (ijnl)    

% 1. To reshape T as a matrix, to compute multiplication
    T = reshape( permute( T, [ OtherId, Pls ] ), [ prod( OtherDim ), Cbond ] );                                % T(ijl, k )

% 2. Do matrix mulplication
    T = T * Matrix;

% 3. Return to the ordinary order: set the last index to the contracted pls.
    NewOrder = [ 1:Pls-1, Trank, Pls:Trank-1 ];
    NewSize = [ OtherDim, NewDim ];
    T = permute( reshape( T, [ OtherDim, NewDim ] ), NewOrder );                                                            % T(i,j,l,n) => T(i,j,n,l)
    NewSize = NewSize( NewOrder );
end
end
    
    
% the end
    
    


