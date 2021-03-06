program conversion

	integer, dimension(64) :: nombre
	integer, dimension(11) :: exposant
	integer, dimension(52) :: mantisse
	integer signe,exposantdec
	character*64 :: c1
	logical :: denormalise,positif
	integer :: i
	
	read(*,*) c1
	do i=1,64
		read(c1(i:i),'(i1)') nombre(i)
	enddo
	
	signe=nombre(1)
	
	if (nombre(1)==0) then
		positif= .true.
	else
		positif= .false.
	endif
	
	do i=2,12
		exposant(i-1)=nombre(i)
	enddo
	
	do i=13,64
		mantisse(i-12)=nombre(i)
	enddo
	
	print*, 'Nombre en écriture binaire : ',c1
	print*, ('')
	write (c1,'(i1)') signe
	write (*,*) "bit de signe : ",c1
	c1=""
	do i=1,11
		write(c1(i:i),'(i1)') exposant(i)
	enddo
	write(*,*) "bits d''exposants : ",c1
	do i=1,52
		write(c1(i:i),'(i1)') mantisse(i)
	enddo
	write(*,*) "bits de mantisses : ",c1
	print*, ('')
	denormalise=.true.
	do i=1,11
		if (exposant(i)/=0) then
			denormalise= .false.
		endif
	enddo
	
	if (positif) then
		if (denormalise) then
			print*, 'Le nombre est positif car le bit de signe est à 0 ; dénormalisé car les bits d''exposants sont tous égaux à 0'
		else
			print*, 'Le nombre est positif car le bit de signe est à 0 ; normalisé car les bits d''exposants sont différents de : 000..0'
		endif
	else
		if (denormalise) then
			print*, 'Le nombre est négatif car le bit de signe est à 1 ; dénormalisé car les bits d''exposants sont tous égaux à 0'
		else
			print*, 'Le nombre est négatif car le bit de signe est à 1 ; normalisé car les bits d''exposants sont différents de : 000..0'
		endif
	endif
	
	print*, ''
	c1=""
	exposantdec=0.d0
	print*, 'exposant biaisé = '
	do i=1,11
		if (exposant(i)==1) then
			write (*,'(A,I2,A)',advance='no') '2^(',11-i,')+'		
			exposantdec=exposantdec+2**(11-i)
		endif
	enddo
	
	write (*,'(A,I4)',advance='no') '0 = ',exposantdec
	print*, ''
	print*, ''
	
	write (*,'(A,I4,A,I4,A,I4)',advance='no') 'exposant réel = ',exposantdec,'-d = ',exposantdec,'-1023 = ',(exposantdec-1023)
	exposantdec=exposantdec-1023
	print*, ''
	print*, ''
	mantissedec=0.d0
	print*, 'mantisse = '
	do i=1,52
		if (mantisse(i)==1) then
			write (*,'(A,I2,A)',advance='no') '2^(-',i,') + '
		endif
	enddo
	
	print*,'0 =  A (à calculer sur https://www.dcode.fr/calcul-sommation par exemple)'
	print*, ''
	write (*,'(A,I1,A,I4,A)',advance='no') 'Valeur décimale exacte : ((-1)^',signe,')*(1+A)*(2^(',exposantdec,')) = B (wolfram alpha)'
	
end program conversion
	
		
	
	
			
			
	
	

