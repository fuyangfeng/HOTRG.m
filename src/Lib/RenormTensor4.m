function [ Ta, Coef ] = RenormTensor4( Ta, Tb, LGauge, RGauge, Dra, Drb, Dcol, Dcom, Dbond, Coef )
% HOTRG tensor update step:
% Ta(lrud:Dra,Dra,Dcol,Dcom), Tb(lrud:Drb,Drb,Dcom,Dcol), LGauge/RGauge(Dra,Drb,Dbond)
% Ta(1234), Tb(5647), L(15x), R(26y); output Ta is T
% Coef can be empty or omitted: then use the dominant element in T
% Modified on 2019.05.15, Tao Qing @ RUC

% 1. L(15x)Ta(1234)=>L(5x,1)Ta(1,234)=>T(5x,234)=>T(x23,54)
Ta = TensorContractFast( LGauge, Ta, 3, 4, [ 2, 3, 1 ], [], [ Drb*Dbond, Dra ], [ Dra, Dra*Dcol*Dcom ], ...
    [ Drb, Dbond, Dra, Dcol, Dcom ], [ 2, 3, 4, 1, 5 ], [ Dbond*Dra*Dcol, Drb*Dcom ] );

% 2. T(x23,54)Tb(5647)=>T(x23,54)Tb(54,67)=>T(x2367)=>T(x37,26)
Ta = TensorContractFast( Ta, Tb, 2, 4, [], [ 1, 3, 2, 4 ], [], [ Drb*Dcom, Drb*Dcol ], ...
    [ Dbond, Dra, Dcol, Drb, Dcol ], [ 1, 3, 5, 2, 4 ], [ Dbond*Dcol*Dcol, Dra*Drb ] );

% 3. T(x37,26)R(26y)=>T(x37,26)R(26,y)=>T(x37y)=>T(xy37)
Ta = TensorContractFast( Ta, RGauge, 2, 3, [], [], [], [ Dra*Drb, Dbond ], [ Dbond, Dcol, Dcol, Dbond ], [ 1, 4, 2, 3 ], [] );

if( nargin < 10 )   
%     Coef = Maxdiff( Ta, 0, 'c' );
    Coef = abs( trace( SumIdx( Ta, [ 3, 4 ], 'd', 4, 1 ) ) );
end

Ta = Ta / Coef;
end
    
    
% the end
    
    
