function [ U, DiagC0, RankApp, TrunError ] = SmartEVD( A, CutFlag, CmpEps, SymFlag )
% Created on 2019.05.15, Tao Qing @ RUC

if( nargin < 4 )
    SymFlag = 0;
end
if( nargin < 3 )
    CmpEps = 1E-14;
end
if( nargin < 2 )
    CutFlag = 0;
end

[ U, DiagC0, CalError ] = SortEVD( A, 'abs', SymFlag );
Dold = length( A );

% Determine the rank of A to throw the negeligible by (1) comparing with eps (2) Dbond
if( CutFlag )    
    
    DiagC = DiagC0 / DiagC0( 1 );
    
    % determine the Dbond
    if( CmpEps < 1 )        
        RankApp = sum( DiagC > CmpEps );
    else
        RankApp = CmpEps;        % Here CmpEps is Dbond
    end
    
    if( RankApp < Dold )            % if truncation occurs
        U = U( :, 1 : RankApp );
        DiagC0 = DiagC0( 1 : RankApp );
        TrunError = 1 - sum( DiagC( 1 : RankApp ) ) / sum( DiagC );
    else                                         % if no truncation
        RankApp = Dold;
        TrunError = 0;
    end
    
else                                           % if no truncation is necessary   
    RankApp = Dold;
    TrunError = 0;
end
    
end
    
    
% the end
    
    