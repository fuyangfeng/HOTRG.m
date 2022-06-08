function [ U, DiagC, CalError ] = SortEVD( A, StandString, SymFlag )
% T = U*diag(DiagC)/U
% StandString = 'agb': from algebra-large to algebra-small, for complex it is same as 'abs'
% StandString = 'abs': from dominant to negligible
% StandString = 'real': from real-part-large to real-part-small
% StandString = 'absreal': form dominant-real to negligibal-real
% Modified on 2019.05.15, Tao Qing @ RUC

if( nargin < 3 )
    SymFlag = 0;
end

if( SymFlag )
    A = ( A + A' ) / 2;
end

[ U, C ] = eig( A ) ;
DiagC = diag( C );
if( strcmp( StandString, 'agb' ) )
    [ ~, Idx ] = sort( DiagC, 'descend' );
elseif( strcmp( StandString, 'abs' ) )
    [ ~, Idx ] = sort( abs( DiagC ), 'descend' );
elseif( strcmp( StandString, 'real' ) )
    [ ~, Idx ] = sort( real( DiagC ), 'descend' );
elseif( strcmp( StandString, 'absreal') )
    [ ~, Idx ] = sort( abs( real( DiagC ) ), 'descend' );
end

DiagC = DiagC( Idx );
U = U( :, Idx );

if( SymFlag )
    CalError = Maxdiff( U * diag( DiagC ) * U', A )/Maxdiff( A, 0, 'c' );
else
    CalError = Maxdiff( U * diag( DiagC ) / U, A )/Maxdiff( A, 0, 'c' );
end

end
    
    
% the end
    
    
