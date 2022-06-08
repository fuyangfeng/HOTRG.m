function [ FEnergy, Energy, Mag, TrunError ] = RealSpaceRG( T, Te, Tm, Tem, Dbond, RGstep )

FEnergy = 0;

for iterNo = 1 : RGstep
    
    [ Dr, ~, Dc, ~ ] = size( T );
    [ U, ~, x ] = GetUTRGU4( T, T, Dr, Dr, Dc, Dc, Dbond, 1 );
    TrError( iterNo ) = x( 1 );
    RealD = min( size( U, 3 ), Dbond );
    [ Tnext, Coef ] = RenormTensor4( T, T, U, U, Dr, Dr, Dc, Dc, RealD );
    [ Te ] = RenormTensor4( T, Te, U, U, Dr, Dr, Dc, Dc, RealD, Coef );
    
    [ Tm ] = RenormTensor4( T, Tm, U, U, Dr, Dr, Dc, Dc, RealD, Coef );
    
    % print information
    Fcontrib = - Tem * log( Coef ) * ( 2^( -iterNo ) );
    FEnergy = FEnergy + Fcontrib;
    
    Denorm = abs( trace( SumIdx( T, [ 3, 4 ], 'd', 4, 1 ) ) );
    Enumer = trace( SumIdx( Te, [ 3, 4 ], 'd', 4, 1 ) );
    Mnumer = abs( trace( SumIdx( Tm, [ 3, 4 ], 'd', 4, 1 ) ) );
    Einter = Enumer / Denorm;
    Minter = Mnumer / Denorm;    
    
    if( ~mod( iterNo, 4 ) )
        fprintf( '\t\t i-Coef-F-E-M-Tr-Fcontrib: %d, %g, [ %g, %g, %g, ] %g, %g \n', iterNo, Coef, FEnergy, Einter, Minter, TrError( iterNo ), Fcontrib );
    end

    
    % do rotation
    T = permute( Tnext, [ 3, 4, 2, 1 ] );
    Te = permute( Te, [ 3, 4, 2, 1 ] );
    Tm = permute( Tm, [ 3, 4, 2, 1 ] );
    
    
end

FEnergy = FEnergy - Tem * log( Denorm ) * ( 2^( -RGstep ) );
Energy = Einter;
Mag = Minter;
TrunError( 1 ) = max( TrError );
TrunError( 2 ) = TrError( RGstep );