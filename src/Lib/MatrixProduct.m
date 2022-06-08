function [ M ] = MatrixProduct( MatrixCell, sumflag, Tsize, Cdim )
% The 1st index will be the target index, with commen and public dimension Cdim
% Modified on 2019.05.15, Tao Qing @ RUC

N = numel( MatrixCell );
M = zeros( Tsize );
if( N == 2 )
    A = MatrixCell{ 1 };
    B = MatrixCell{ 2 };
    for nid = 1 : Cdim
        for jid = 1 : Tsize( 2 )
            b = B( nid, jid );
            for iid = 1 : Tsize( 1 )
                M( iid, jid, nid ) = A( nid, iid ) * b;
            end
        end
    end
elseif( N == 3 )
    A = MatrixCell{ 1 };
    B = MatrixCell{ 2 };
    C = MatrixCell{ 3 };
    for nid = 1 : Cdim
        for kid = 1 : Tsize( 3 )
            c = C( nid, kid );
            for jid = 1 : Tsize( 2 )
                b = B( nid, jid );
                for iid = 1 : Tsize( 1 )
                    M( iid, jid, kid, nid ) = A( nid, iid ) * b * c;
                end
            end
        end
    end
elseif( N == 4 )
    A = MatrixCell{ 1 };
    B = MatrixCell{ 2 };
    C = MatrixCell{ 3 };
    D = MatrixCell{ 4 };
    for nid = 1 : Cdim
        for lid = 1 : Tsize( 4 )
            d = D( nid, lid );
            for kid = 1 : Tsize( 3 )
                c = C( nid, kid );
                for jid = 1 : Tsize( 2 )
                    b = B( nid, jid );
                    for iid = 1 : Tsize( 1 )
                        M( iid, jid, kid, lid, nid ) = A( nid, iid ) * b * c * d;
                    end
                end
            end
        end
    end
elseif( N == 5 )
    A = MatrixCell{ 1 };
    B = MatrixCell{ 2 };
    C = MatrixCell{ 3 };
    D = MatrixCell{ 4 };
    E = MatrixCell{ 5 };
    for nid = 1 : Cdim
        for aid = 1 : Tsize( 5 )
            e = E( nid, aid );
            for lid = 1 : Tsize( 4 )
                d = D( nid, lid );
                for kid = 1 : Tsize( 3 )
                    c = C( nid, kid );
                    for jid = 1 : Tsize( 2 )
                        b = B( nid, jid );
                        for iid = 1 : Tsize( 1 )
                            M( iid, jid, kid, lid, aid, nid ) = A( nid, iid ) * b * c * d * e;
                        end
                    end
                end
            end
        end
    end
elseif( N == 6 )
    A = MatrixCell{ 1 };
    B = MatrixCell{ 2 };
    C = MatrixCell{ 3 };
    D = MatrixCell{ 4 };
    E = MatrixCell{ 5 };
    F = MatrixCell{ 6 };
    for nid = 1 : Cdim
        for bid = 1 : Tsize( 6 )
            f = F( nid, bid );
            for aid = 1 : Tsize( 5 )
                e = E( nid, aid );
                for lid = 1 : Tsize( 4 )
                    d = D( nid, lid );
                    for kid = 1 : Tsize( 3 )
                        c = C( nid, kid );
                        for jid = 1 : Tsize( 2 )
                            b = B( nid, jid );
                            for iid = 1 : Tsize( 1 )
                                M( iid, jid, kid, lid, aid, bid, nid ) = A( nid, iid ) * b * c * d * e * f;
                            end
                        end
                    end
                end
            end
        end
    end
end

if( sumflag )
    M = sum( M, N+1 );
end
    
end
            
                
            
    

