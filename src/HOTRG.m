function HOTRG
% It seems that normalization with trace is very important to obtain a smooth Mag and Energy

[ Inface ] = UserInterface
[ Temp, Dbond, RGstep, Jxy, Jz, Field ] = GetFields( Inface, 'Temp', 'Dbond', 'RGstep', 'Jxy', 'Jz', 'Field' );

Ntem = numel( Temp );
for iterNo = 1 : Ntem
	tic
    Tem = Temp( iterNo );
    [ T, Te, Tm ] = InitTriTensor( Tem, Jxy, Jz, Field );
    [ T, Te, Tm, Coef ] = ConvToSquare( T, Te, Tm );
    [ Nfenergy, Nenergy, Mag( iterNo ), TrunError( iterNo, : ) ] = RealSpaceRG( T, Te, Tm, Tem, Dbond, RGstep );
    FEnergy( iterNo ) = Nfenergy - Tem * log( Coef ); 
    Energy( iterNo ) = 3 * Nenergy;
    fprintf( 'i-Tem-F-E-M-Tr: %d, %g, [ %g, %g, %g, ] %g, %g \n', iterNo, Tem, FEnergy( iterNo ), Energy( iterNo ), Mag( iterNo ), TrunError( iterNo, 1 ), TrunError( iterNo, 2 ) );
	toc
end

save 
