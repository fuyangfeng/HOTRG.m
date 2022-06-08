function [ PermA, PermB, MatrixAsize, MatrixBsize, TensorSize, ABorder, NewSize, FinalIdx ] = DeterCinfo( ...
    Aidx, Bidx, Newidx, Asize, Bsize, IdxShape )

% Implicit version
% Collect necessary information used for tensor contraction. 
% aidx, bidx, Newidx are all strings, string can be number and letter or mixed; can also be vectors.
% IdxShape is the index shape, not the size shape
% If Newidx = []: no permutation is needed;
% If IdxShape = []: no reshape is needed.
% Modified on 2019.05.15, Tao Qing @ RUC

% 1. find contracted index Cidx: the place of Cidx in A is CinA, in B is CinB
% note: only Cidx might be changed, Aidx and Bidx will not be affected.
Arank = numel( Aidx );
Brank = numel( Bidx );
[ Cidx, CinA, CinB ] = intersect( Aidx, Bidx );
Crank = numel( Cidx );
CinA = CinA';                            % convert from column to a row vector
CinB = CinB';

if( isempty( Cidx ) )
    error( 'In DeterCinfo: No contraction is possible since there is no common index!' );
end

% 2. find the original index order
Oridx = [ GetOtherId( Aidx, Cidx ), GetOtherId( Bidx, Cidx ) ];
Trank = numel( Oridx );

% 3. find the permutation order to get the correct needed order
if( ~isempty( Newidx ) )
    ABorder = GetPermOrder( Oridx, Newidx );
    FinalIdx = Newidx;
else
    ABorder = 1 : Trank;
    FinalIdx = Oridx;
end

% 4. determine all the parameters that should be put into TensorContractFast
PermA = [ setdiff( 1 : Arank, CinA, 'stable' ), CinA ];
PermB = [ CinB, setdiff( 1 : Brank, CinB, 'stable' ) ];
Asize1 = Asize( PermA );
Bsize1 = Bsize( PermB );
MatrixAsize = [ prod( Asize1( 1 : (Arank-Crank) ) ), prod( Asize1( (Arank-Crank+1) : Arank ) ) ];
MatrixBsize = [ prod( Bsize1( 1 : Crank ) ), prod( Bsize1( (Crank+1) : Brank ) ) ];
TensorSize = [ Asize1( 1 : (Arank-Crank) ), Bsize1( (Crank+1) : Brank ) ];

% 5. if NewSize is needed
if( ~isempty( IdxShape ) )
    NewSize = GetDivDetail( TensorSize( ABorder ), IdxShape );
else
    NewSize = TensorSize( ABorder );
end
