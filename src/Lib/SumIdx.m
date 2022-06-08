function [ Treduced, Tsize ] = SumIdx( T, Cid, idflag, Trank, Sqflag )
% sum{ T(1,2,3,4,5,6,7,8 )}_{278} = Treduced(1,3,4,5,6)
% Cid is the contracted id with the same value, is a vector
% idflag = 'i': independent sum, over all possible value of 2/7/8
% idflag = 'd': dependent sum, over all diagonal value, i.e., 2=7=8
% Sqflag means squeezeflag, if = 1, then need to negelect the summed dimensions.
% Modified on 2019.05.15, Tao Qing @ RUC

% 0. Preparation
if( nargin < 5 )
    Sqflag = 0;
end

Tsize = GetTensorSize( T, Trank );

% 1. transform to a matrix form with Cid as a single row index

d = numel( Cid );
Cshape = Tsize( Cid );                                                                       % Contracted Shape
ElseId = setdiff( 1:Trank, Cid, 'stable' );                                          % Other id
ElseShape = Tsize( ElseId );
OrderPrepared = [ Cid, ElseId ];                                                       % (27813456)
MatrixShape = [ prod( Cshape ), prod( ElseShape ) ];
T = reshape( permute( T, OrderPrepared ), MatrixShape );             % (278,13456)

% 2. do summation over the Cid
if( strcmp( idflag, 'i' ) )                                                                      % independent summation
    Treduced = sum( T );                                                                     % (13456)
elseif( strcmp( idflag, 'd' ) )                                                               % dependent summation
    Dbond = Cshape(1);                                                                % Cshape = [Dbond, Dbond, Dbond, ...]
    if( Maxdiff( Cshape, Dbond, 'c' ) ~= 0 )
        error( 'In SumIdx: Dependent summation can be performed only when their dimension are equal!' );
    end
    
    IdRow = zeros( 1, Dbond );    
    for iterNo = 1 : Dbond
        Idvecr = iterNo * ones( 1, d );                                                            % (iterNo1, iterNo2, iterNo3, ...., iterNod)
        [ IdRow( iterNo ), ~ ] = Vector2Scalar( Idvecr, Cshape, 'cd', 0 );
    end
    Treduced = sum( T( IdRow, : ) );
end

% 3. reshape to the orginal tensor shape
if( Sqflag == 1 )
    Treduced = reshape( Treduced, ElseShape );
    Tsize = ElseShape;
elseif( Sqflag == 0 )
    Tsize( Cid ) = 1;    
    Treduced = reshape( Treduced, Tsize );
end
end
        
% the end
    
    
