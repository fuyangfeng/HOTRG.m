function [ Weight ] = GetIdxWeight( Shape, fmt )
% fmt = 'cd': column-dominated, like Matlab/Fortran
% fmt = 'rd': row-dominated, like C/C++
% Modified on 2019.05.15, Tao Qing @ RUC

if( ~isvector( Shape ) )
    error( 'In GetIdxWeight: Shape should be a vector!' );
end

Order = numel( Shape );
Weight = zeros( GetTensorSize( Shape, numel( Shape ) ) );

if( nargin < 2 )
    fmt = 'cd';
end
if( strcmp( fmt, 'cd' ) )
    Weight( 1 ) = 1;
    for iterNo = 2 : Order
        Weight( iterNo ) = prod( Shape( 1 : (iterNo-1) ) );
    end
elseif( strcmp( fmt, 'rd' ) )
    Weight( Order ) = 1;
    for iterNo = 1 : (Order - 1)
        Weight( iterNo ) = prod( Shape( (iterNo+1) : Order ) );
    end
else
    error( 'In GetIdxWeight: invalid input strings!' );
end

end

