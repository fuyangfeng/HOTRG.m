function [ Id, Weight ] = Vector2Scalar( Idvecr, Shape, rcstring, flag )
% (Id-1) = (I-1) + (J-1)*n1 + (K-1)*n1*n2 + (L-1)*n1*n2*n3; (IJKL)
% like matlab built-in funciton: sub2ind
% Idvec, Weight: a row vector
% Modified on 2019.05.15, Tao Qing @ RUC

if( ~( isrow( Idvecr )&&( isrow( Shape ) ) ) )
    error( 'In Vector2Scalar: Both Idvecr and Shape should be row-vectors.' );
end

if( nargin < 4 )
    flag = 0;
end
if( nargin < 3 )
    rcstring = 'cd';
end

if( flag == 1 )
    Weight = Shape;
else
    [ Weight ] = GetIdxWeight( Shape, rcstring );
end

Id = sum( ( Idvecr - 1 ) .* Weight ) + 1;
end
    
    
% the end
    
    