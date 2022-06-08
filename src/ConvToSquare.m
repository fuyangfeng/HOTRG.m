function [ T, Te, Tm, Coef ] = ConvToSquare( T, Te, Tm )
% index: from left-up, then clock-wise rotation
% equivalent: from vertical, then clock-wise rotation

% reshape rank-6 tensor to rank-3 tensor
T = reshape( T, [ 4, 4, 4 ] );
Te = reshape( Te, [ 4, 4, 4 ] );
Tm = reshape( Tm, [ 4, 4, 4 ] );

% Do HOSVD of T
[ U, Gam, S ] = DirHOSVD( T, [ 4, 4, 4 ], [ 1, 2, 3 ], 1 );

% Combine three U into a single tensor: from vertical, then clock-wise rotation 
[ U3 ] = SimNetworkContract( { reshape( U{1}, [ 2, 2, 4 ] ), reshape( U{2}, [ 2, 2, 4 ] ), reshape( U{3}, [ 2, 2, 4 ] ) }, { '12a', '31c', '23b' } );

% Convert to square lattice: left-right-up-down index
T = TensorContract( U3, S, 'acb', 'a32', 'c3b2' );

% Construct the impurity tensor
Te = TensorPosActs( Te, U, [ 1, 2, 3 ], [ 4, 4, 4 ] );
Te = TensorContract( U3, Te, 'acb', 'a32', 'c3b2' );

Tm = TensorPosActs( Tm, U, [ 1, 2, 3 ], [ 4, 4, 4 ] );
Tm = TensorContract( U3, Tm, 'acb', 'a32', 'c3b2' );

% Normalization
% Coef = Maxdiff( T, 0, 'c' );
Coef = abs( trace( SumIdx( T, [ 3, 4 ], 'd', 4, 1 ) ) );
T = T / Coef;
Te = Te / Coef;
Tm = Tm / Coef;
end