function [ U, Lam, T, Tsize, TrunError ] = DirHOSVD( T, Trs, Pls, CoreFlag, CutFlag, CmpEps )
% partial HOSVD by directional SVD, slower but somewhat more accurate
% Pls is a vector, which specifies the directions in which the HOSVD is performed
% input: T(i1,i2,i3,i4,i5,i6), Pls=[2,4,6]
% output: U{2/4/6} is unitary, Lam{2/4/6} is vector, T(i1,i2,i3,i4,i5,i6) is the core tensor (if CoreFlag=1)
% Suitable for complex, understanding is same as real number
% Modified on 2019.05.15, Tao Qing @ RUC

% 1. Prepare information
if( numel( Trs ) == 1 )
    Trank = Trs;
    Tsize = GetTensorSize( T, Trs );
else
    Trank = numel( Trs );
    Tsize = Trs;
end
Nele = prod( Tsize );

if( nargin < 6 )
    CmpEps = eps;
end
if( nargin < 5 )
    CutFlag = 0;
end
if( nargin < 4 )
    CoreFlag = 0;
end

% 2. Do directional independently
d = numel( Pls );
U = cell( d, 1 );
Lam = cell( d, 1 );
for iterNo = 1 : d
    Id = Pls( iterNo );
    BefOrder = [ Id, 1:Id-1, Id+1:Trank ];
    BefSize = [ Tsize( Id ), round( Nele / Tsize( Id ) ) ];
    temp = reshape( permute( T, BefOrder ), BefSize );
    
%     % old method
%     [ U{ iterNo }, Gam, ~, ~, TrunError( iterNo ) ] = SmartSVD( temp, CutFlag, CmpEps );      % T(2,13456)=U2*Lam*T(13456,2)
%     Lam{ iterNo } = diag( Gam );
    
%     % new method
    temp = temp * temp';
    [ U{ iterNo }, Gam, ~, TrunError( iterNo ) ] = SmartEVD( temp, CutFlag, CmpEps, 1 );
    Lam{ iterNo } = sqrt( abs( Gam ) );    
end

TrunError = max( TrunError );

% 3. Get Core Matrix
if( CoreFlag )
    for iterNo = 1 : d
        [ T, Tsize ] = TensorPosAct( T, conj( U{iterNo} ), Pls( iterNo ), Tsize );
    end
else
    T = [];
end
    
    
% the end
    
    