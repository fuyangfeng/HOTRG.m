function [ U, R0Gam, TrunError ] = GetUTRGU4( Ta, Tb, Dra, Drb, Dcol, Dcom, Dbond, TensorFlag )
% Get HOTRG Gauge for rank-4 tensor {up-Ta, dn-Tb}
% Ta(lrud):Dra*Dra*Dcol*Dcom; Tb(lrud):Drb*Drb*Dcom*Dcol
% R0Gam: renormalized vector of the spectra by the dominant element is set to be 1, R1Gam by trace, R2Gam by length
% TensorFlag = 1: U is a rank-3 tensor, =0 is a matrix
% Modified on 2019.05.15, Tao Qing @ RUC

if( nargin < 8 )
    TensorFlag = 1;
end

% 1. determine the left U
% Ta(1234)Ta(1'234')=>Ta(1423)Ta(231'4')=>T1(141'4')=>T1(11',44'), 
T1 = TensorContractFast( Ta, conj( Ta ), 3, 3, [ 1, 4, 2, 3 ], [ 2, 3, 1, 4 ], [ Dra*Dcom, Dra*Dcol ], [ Dra*Dcol, Dra*Dcom ], ...
    [ Dra, Dcom, Dra, Dcom ], [ 1, 3, 2, 4 ], [ Dra^2, Dcom^2 ] );
% Tb(5647)Tb(5'64'7)=>Tb(5467)Tb(675'4')=>T2(545'4')=>T2(44',55')
T2 = TensorContractFast( Tb, conj( Tb ), 3, 3, [ 1, 3, 2, 4 ], [ 2, 4, 1, 3 ], [ Drb*Dcom, Drb*Dcol ], [ Drb*Dcol, Drb*Dcom ], ...
    [ Drb, Dcom, Drb, Dcom ], [ 2, 4, 1, 3 ], [ Dcom^2, Drb^2 ] );
% T1(11',44')T2(44',55')=>RDM(11',55')=>RDM(15,1'5')
RDM = reshape( permute( reshape( T1*T2, [ Dra, Dra, Drb, Drb ] ), [ 1, 3, 2, 4 ] ), [ Dra*Drb, Dra*Drb ] );
RDM = ( RDM + RDM' ) / 2;
[ U1, Lam1, UnitaryError1 ] = SortEVD( RDM, 'abs', 1 );
R0Gam1 = Lam1 / Lam1( 1 );

% 2. determine the right U
% Ta(1234)Ta(12'34')=>Ta(2413)Ta(132'4')=>T1(242'4')=>T1(22',44')
T1 = TensorContractFast( Ta, conj( Ta ), 3, 3, [ 2, 4, 1, 3 ], [ 1, 3, 2, 4 ], [ Dra*Dcom, Dra*Dcol ], [ Dra*Dcol, Dra*Dcom ], ...
    [ Dra, Dcom, Dra, Dcom ], [ 1, 3, 2, 4 ], [ Dra^2, Dcom^2 ] );
% Tb(5647)Tb(56'4'7)=>Tb(6457)Tb(576'4')=>T2(646'4')=>T2(44',66')
T2 = TensorContractFast( Tb, conj( Tb ), 3, 3, [ 2, 3, 1, 4 ], [ 1, 4, 2, 3 ], [ Drb*Dcom, Drb*Dcol ], [ Drb*Dcol, Drb*Dcom ], ...
    [ Drb, Dcom, Drb, Dcom ], [ 2, 4, 1, 3 ], [ Dcom^2, Drb^2 ] );
% T1(22',44')T2(44',66')=>RDM(22',66')=>RDM(26,2'6')
RDM = reshape( permute( reshape( T1*T2, [ Dra, Dra, Drb, Drb ] ), [ 1, 3, 2, 4 ] ), [ Dra*Drb, Dra*Drb ] );
RDM = ( RDM + RDM' ) / 2;
[ U2, Lam2, UnitaryError2 ] = SortEVD( RDM, 'abs', 1 );
R0Gam2 = Lam2 / Lam2( 1 );

% 3. determine the appropriate U

if( Dbond < Dra*Drb )
    Tr1 = 1 - sum( R0Gam1( 1 : Dbond ) )/sum( R0Gam1 );
    Tr2 = 1 - sum( R0Gam2( 1 : Dbond ) )/sum( R0Gam2 );
    TrunError = [ min( Tr1, Tr2 ), Tr1, Tr2 ];
    if( Tr1 <= Tr2 )
        U = U1( :, 1:Dbond );
        R0Gam = R0Gam1;
    else
        U = U2( :, 1:Dbond );
        R0Gam = R0Gam2;
    end
else
    U = U1;
    R0Gam = R0Gam1;
    TrunError = [ 0, 0, 0 ];
end

if( TensorFlag )
    U = reshape( U, Dra, Drb, size( U, 2 ) );
end

TrunError = [ TrunError, UnitaryError1, UnitaryError2 ];
end
    
    
% the end
    
    