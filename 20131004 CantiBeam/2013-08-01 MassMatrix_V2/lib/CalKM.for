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
      mwPointer ds_p,N_p,dsy_p,D_p,K_p,M_p
      real *8 ds,D(6,6),dsy,K(24,24),M(24,24),N(8,8)

      if (nrhs.ne.4) then
          call mexErrMsgTxt('输入参数个数不正确')
      end if
      if (nlhs.ne.2) then
          call mexErrMsgTxt('输出参数个数不正确')
      end if

      plhs(1)=mxCreateDoubleMatrix(24,24,0)
      plhs(2)=mxCreateDoubleMatrix(24,24,0)
      ds_p=mxGetPr(prhs(1))
      dsy_p=mxGetPr(prhs(2))
      N_p=mxGetPr(prhs(3))
      D_p=mxGetPr(prhs(4))
      call mxCopyPtrToReal8(ds_p,ds,1)
      call mxCopyPtrToReal8(N_p,N,8*8)
      call mxCopyPtrToReal8(D_p,D,6*6)
      call mxCopyPtrToReal8(dsy_p,dsy,1)

      K_p = mxGetPr(plhs(1))
      M_p = mxGetPr(plhs(2))

      call CalKM(ds,N,D,dsy,K,M)

      call mxCopyReal8ToPtr(K,K_p,24*24)
      call mxCopyReal8ToPtr(M,M_p,24*24)

      return
      end subroutine


       subroutine CalKM(ds,N,D,dsy,K,M)   

       real *8 dsy
       real *8 dK(24,24),N(8,8),E_disX(8),E_disY(8),E_disZ(8),B(6,24)
       real *8 D(6,6),B2(24,6),tmp(24,6),K(24,24),dM(24,24),M(24,24)
       real *8 x,y,z,ds
       real *8 Vx(8),Vy(8),Vz(8),Ns(8),Ns2(8),Nn(3,24)
       real *8 f1,f2,f3
       integer i,j

!*********Stiffness Matrix*****************
       K=0
      do x=0.,100.,ds
        do y=-10.,10.,ds
            do z=0.,40.,ds

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
                K=K+dK*(ds**3)/8
            end do
        end do
      end do
      
!      do i=1,6
!         do j=1,6
!           K(i,j)=D(i,j)
!         end do
!      end do
!****************Mass Matrix*************************

      do x=0.,100.,ds
        do y=-10.,10.,ds
            do z=0.,40.,ds

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
                M=M+dM*dsy*(ds**3)/8
            end do
        end do
       end do

      end subroutine CalKM

