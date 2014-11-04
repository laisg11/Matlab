!  CalSMandMM.f90 
!
!  FUNCTIONS:
#include "fintrf.h"
!  MassMatrix - Entry point of console application.
!
#if 0
!  [SM,MM]=CalSMandMM(ds,E,v,dsy)
#endif 
      subroutine mexFunction(nlhs,plhs,nrhs,prhs)

      mwPointer plhs(*), prhs(*)
      integer nlhs, nrhs
      mwPointer mxGetPr
      mwPointer mxCreateDoubleMatrix
      mwPointer ds_p,E_p,v_p,dsy_p,K_p,M_p
      real *8 ds,E,v,dsy,K(24,24),M(24,24)

      if (nrhs.ne.4) then
          call mexErrMsgTxt('输入参数个数不正确')
      end if
      if (nlhs.ne.2) then
          call mexErrMsgTxt('输出参数个数不正确')
      end if

      plhs(1)=mxCreateDoubleMatrix(24,24,0)
      plhs(2)=mxCreateDoubleMatrix(24,24,0)
      ds_p=mxGetPr(prhs(1))
      E_p=mxGetPr(prhs(2))
      v_p=mxGetPr(prhs(3))
      dsy_p=mxGetPr(prhs(4))
      call mxCopyPtrToReal8(ds_p,ds,1)
      call mxCopyPtrToReal8(E_p,E,1)
      call mxCopyPtrToReal8(v_p,v,1)
      call mxCopyPtrToReal8(dsy_p,dsy,1)

      K_p = mxGetPr(plhs(1))
      M_p = mxGetPr(plhs(2))

      call CalSMandMM(ds,E,v,dsy,K,M)

      call mxCopyReal8ToPtr(K,K_p,24*24)
      call mxCopyReal8ToPtr(M,M_p,24*24)

      return
      end subroutine


       subroutine CalSMandMM(ds,E,v,dsy,K,M)   

       real *8 E,v,dsy
       real *8 dK(24,24),N(8,8),E_disX(8),E_disY(8),E_disZ(8),B(6,24)
       real *8 D(6,6),B2(24,6),tmp(24,6),K(24,24),dM(24,24),M(24,24)
       real *8 x,y,z,ds
       real *8 Vx(8),Vy(8),Vz(8),Ns(8),Ns2(8),Nn(3,24)
       real *8 f1,f2,f3
       integer i,j

!       v=0.21
!       E=11e3
!       dsy=1.87324E-009
       K=0
       f1=E*(1-v)/(1+v)/(1-2*v)
       f2=f1*(1-2*v)/2/(1-v)
       f3=E*v/(1+v)/(1-2*v)

      D(1,1)=f1
      D(1,2)=f3
      D(1,3)=f3
      	D(2,1)=f3
      D(2,2)=f1
      D(2,3)=f3
	D(3,1)=f3
      D(3,2)=f3
      D(3,3)=f1
	D(4,4)=f2
      D(5,5)=f2
      D(6,6)=f2
    

      N=0
      N(4,1)=5e-3
      N(6,1)=-6.3654e-5
      N(7,1)=-2e-5
      N(8,1)=2.5461e-7

      N(4,2)=5e-3
      N(6,2)=6.3654e-5
      N(7,2)=-2e-5
      N(8,2)=-2.5461e-7

      N(7,3)=2e-5
      N(8,3)=3.8241e-7

      N(7,4)=2e-5
      N(8,4)=-3.8241e-7

      N(1,5)=0.5
      N(2,5)=-2.e-3
      N(3,5)=-6.4e-3
      N(4,5)=-5e-3
      N(5,5)=2.5461e-5
      N(6,5)=6.3654e-5
      N(7,5)=2e-5
      N(8,5)=-2.5461e-7

      N(1,6)=0.5
      N(2,6)=-2e-3
      N(3,6)=6.4e-3
      N(4,6)=-5e-3
      N(5,6)=-2.5461e-5
      N(6,6)=-6.3654e-5
      N(7,6)=2.000e-5
      N(8,6)=2.5461e-7

      N(2,7)=2e-3
      N(5,7)=3.8241e-5
      N(7,7)=-2e-5
      N(8,7)=-3.8241e-7

      N(2,8)=2e-3
      N(5,8)=-3.8241e-5
      N(7,8)=-2e-5
      N(8,8)=3.8241e-7

!*********Stiffness Matrix*****************

      do x=0,249.7,ds
        do y=(-157.1/2+0.2103*ds),(157.1/2-0.2103*ds),ds
            do z=0,100,ds

                Vx=0
                Vy=0
                Vz=0

                Vx(2)=1
                Vx(5)=y
                Vx(7)=z
                Vx(8)=y*z

                Vy(3)=1
                Vy(5)=x
                Vy(6)=z
                Vy(8)=x*z

                Vz(4)=1
                Vz(6)=y
                Vz(7)=x
                Vz(8)=y*z

                do i=1,8
                 E_disX(i)=dot_product(Vx,N(:,i))
                 E_disY(i)=dot_product(Vy,N(:,i))
                 E_disZ(i)=dot_product(Vz,N(:,i))
                end do

                do i=1,8
	
	             B(1,i*3-2)=E_disX(i)
	             B(2,i*3-1)=E_disY(i)
	             B(3,i*3+0)=E_disZ(i)
	             B(4,i*3-2)=E_disY(i)
	             B(4,i*3-1)=E_disX(i)
	             B(5,i*3-1)=E_disZ(i)
	             B(5,i*3+0)=E_disY(i)
	             B(6,i*3-2)=E_disZ(i)
	             B(6,i*3+0)=E_disX(i)
	
                end do
                dK=matmul(matmul(transpose(B),D),B)
                K=K+dK*(ds**3)
            end do
        end do
      end do

!      open(10,file='Stiffness Matrix.dat')
!      write(10,*) K
      print *,'Stiffness Matrix was successfully written to file'

!****************Mass Matrix*************************

      do x=0,249.7,ds
        do y=(-157.1/2+0.2103*ds),(157.1/2-0.2103*ds),ds
            do z=0,100,ds

                Ns(1)=1
                Ns(2)=x
                Ns(3)=y
                Ns(4)=z
                Ns(5)=x*y
                Ns(6)=y*z
                Ns(7)=x*z
                Ns(8)=x*y*z


                do i=1,8
                 Ns2(i)=dot_product(Ns,N(:,i))
                end do

                do i=1,8
	
	             Nn(1,i*3-2)=Ns2(i)
	             Nn(2,i*3-1)=Ns2(i)
	             Nn(3,i*3+0)=Ns2(i)
	          
                end do
                dM=matmul(transpose(Nn),Nn)
                M=M+dM*dsy*(ds**3)
            end do
        end do
       end do

  !    open(20,file='Mass Matrix.dat')
  !    write(20,*) M
  !    write (*,*) 'Mass Matrix was successfully written to file'

      end subroutine CalSMandMM

