function [ T, Te, Tm ] = InitTriTensor( Tem, Jxy, Jz, Field )
% H = -J*S1*S2;
% index: from left-up, then clock-wise rotation

BetaT = 1 / Tem;
[ Wxy, Exy, Mxy, iWxy ] = DecBolWeight( BetaT, Jxy, Field );
[ Wz, Ez, Mz, iWz ] = DecBolWeight( BetaT, Jz, Field );
Tsize = 2 * ones( 1, 7 );

T = MatrixProduct( { Wxy, Wxy, Wz, Wxy, Wxy, Wz }, 1, Tsize, 2 );

Te1 = MatrixProduct( { Exy * iWxy, Wxy, Wz, Wxy, Wxy, Wz }, 1, Tsize, 2 );
Te2 = MatrixProduct( { Wxy, Wxy, Ez * iWz, Wxy, Wxy, Wz }, 1, Tsize, 2 );
Te = Te1 + permute( Te1, [ 2, 1, 3, 4, 5, 6 ] ) + permute( Te1, [ 4, 2, 3, 1, 5, 6 ] ) + permute( Te1, [ 5, 2, 3, 4, 1, 6 ] ) + ...
    Te2 + permute( Te2, [ 1, 2, 6, 4, 5, 3 ] );
Te = Te / 6;

Tm1 = MatrixProduct( { Mxy * iWxy, Wxy, Wz, Wxy, Wxy, Wz }, 1, Tsize, 2 );
Tm2 = MatrixProduct( { Wxy, Wxy, Mz * iWz, Wxy, Wxy, Wz }, 1, Tsize, 2 );
Tm = Tm1 + permute( Tm1, [ 2, 1, 3, 4, 5, 6 ] ) + permute( Tm1, [ 4, 2, 3, 1, 5, 6 ] ) + permute( Tm1, [ 5, 2, 3, 4, 1, 6 ] ) + ...
    Tm2 + permute( Tm2, [ 1, 2, 6, 4, 5, 3 ] );
Tm = Tm / 6;

end

function [ W, E, M, iW ] = DecBolWeight( BetaT, J, Field )

Hmat = - J * [ 1, -1; -1, 1 ];
Mmat = [ 1, 0; 0, -1 ];
Hmat = Hmat - Field * Hmat;
BW = exp( - BetaT * Hmat );

% E = H_(ij) * exp[-BetaT  * H_(ij)]
% M = (Si+Sj)/2 *exp[-BetaT  * H_(ij)]
E = Hmat .* BW;
M = Mmat .* BW;

[ U, L, ~ ] = svd( BW );
W = U * sqrt( L ) * U';

% iW * W' = 1
iW = U * diag( 1./sqrt( diag( L ) ) ) * U';
% Maxdiff( W*W', BW ) / Maxdiff( BW, 0, 'c' )

end
