function [ Order, AntiOrder ] = GetPermOrder( Idfrom, Idto )
% Idrom( Order ) = Idto, i.e., permute( Idfrom, Order ) = Idto
% Idto( AntiOrder ) = Idfrom, i.e., permute( Idto, AntiOrder ) = Idfrom
% Modified on 2019.05.15, Tao Qing @ RUC

if( ~isequal( sort( Idfrom ), sort( Idto ) ) )
    Idfrom
    Idto
    error( 'In GetPermOrder: Ifrom and Idto should be equal after sorted, but the two above are not!' );
end

d = numel( Idto );
if( isequal( Idfrom, Idto ) )
    Order = 1 : d;
    AntiOrder = Order;
else
    Order = zeros( 1, d );
    AntiOrder = zeros( 1, d );
    for iterNo = 1 : d
        Order( iterNo ) = find( Idfrom == Idto( iterNo) );
        AntiOrder( iterNo ) = find( Idto == Idfrom( iterNo ) );
    end
end

end