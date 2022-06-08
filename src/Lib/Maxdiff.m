function [ difference ] = Maxdiff( T1, T2, cflag ) 
% calculate the difference between two tensors with the same element number
% one of {T1, T2} can be a constant, if cflag = 'c'
% Modified on 2019.05.15, Tao Qing @ RUC

if( nargin < 3 )
    cflag = 'n';
end

if( ~strcmp( cflag, 'c' ) )
    Size2 = size( T2 );

    if( numel( T1 ) ~= prod( Size2 ) )
        error( 'In Maxdiff: The element numbers in T1 and T2 are not equal!' );
    else
        T1 = reshape( T1, Size2 );
    end
end

difference = max( max( max( max( max( max( max( max( max( max( max( max( max( max( max( max( abs( T1 - T2 )))))))))))))))));


% difference = max( abs( T1 - T2 ), [], 'all' );

end



% the end

