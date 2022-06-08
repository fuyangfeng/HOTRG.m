function [ z, xid ] = GetOtherId( x, y )
% z is in x but not in y, and z = x(xid)
% Modified on 2019.05.15, Tao Qing @ RUC 

[ z, xid ] = setdiff( x, y, 'stable' );

end