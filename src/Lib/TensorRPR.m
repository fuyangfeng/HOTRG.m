function [ M, Msize ] = TensorRPR( M, Mrs, InitShape, Order, FinShape, flag )
% flag=1: FinShape is real shape; flag=0: FinShape is idx shape
% Modified on 2019.05.15, Tao Qing @ RUC

if( nargin < 6 )
    flag = 1;
end

flag1 = isempty( InitShape );
flag2 = isempty( Order );
flag3 = isempty( FinShape );

if( flag1&&flag2&&flag3 )
    error( 'In TensorRPR: One has to do sth in this subroutine, after all!' );
end

% to find the initial size
if( numel( Mrs ) == 1 )
    Msize = GetTensorSize( M, Mrs );
else
    Msize = Mrs;
end

% Begin
if( (~flag1)&&( ~isequal( InitShape, Msize ) ) )
    M = reshape( M, InitShape );
    Msize = InitShape;
end
if( (~flag2)&&( ~isequal( Order, 1:numel( Msize ) ) ) )
    M = permute( M, Order );
    Msize = Msize( Order );
end
if( ~flag3 )
    if( flag == 1 )
        M = reshape( M, FinShape );                                        % real Shape
        Msize = FinShape;
    else
        [ M, Msize ] = TensorReshape( M, FinShape );          % IdxShape, can obtain real size
    end
end

end    
    
    
% the end
    
    