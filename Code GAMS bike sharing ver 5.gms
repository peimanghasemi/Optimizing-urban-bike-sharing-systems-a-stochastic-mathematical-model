SETS
N/N1*N4/
A/1*2/
O(N)/N1*N2/
D(N)/N3*N4/
S/1*5/
T/1*5/
K/1*2/
;
ALIAS(N,I,J),(S,SS);


PARAMETERS
CA(I)
C0/5/
CAB(I,J)
KK/1000/
QMAX/3/
H(S)
M/1000/
TH(O,D,T,S)
ZALPHA /0.95/
;

CA(I)=17;
H(S)=14;
H(S)=H(S)/SUM(SS,H(SS));
TH(O,D,T,S)=UNIFORMINT(2,3);


DISPLAY CA,H,TH;


TABLE U(I,J)
         N3 N4
N1       1  0
N2       0  1
;
TABLE CAB(I,J)
         N1 N2  N3  N4
N1       11 60  41  19
N2       50 70  15  23
N3       13 41  50  17
N4       10 20  18  70
;

TABLE AI(I,J)
         N1 N2 N3 N4
N1       0  0  1  1
N2       0  0  1  2
N3       1  1  0  1
N4       1  2  1  0
;
TABLE KW(O,D)
         N3 N4
N1       1  0
N2       0  2
;
TABLE W(K,O,D)
         N1.N3 N2.N4
1        1     1
2        0     2
;

TABLE BIJ(I,J,K,O,D)
         1.N1.N3 1.N2.N4 2.N2.N4
N1.N3    1
N2.N3                    1
N2.N4            1
N3.N4                    1
;

TABLE BETA(O,D,K)
          1   2
N1.N3     1   0
N2.N4     .4  .6
;

TABLE LINK(I,J)
         N1 N2 N3 N4
N1       0  0  1  1
N2       0  0  1  1
N3       1  1  0  1
N4       1  1  1  0
;

VARIABLE
Z
;

BINARY VARIABLE
F(I)
G(I,J)
DELTA(O,D,K)
SIGMA(O,D,K)
;

INTEGER VARIABLE
ZA(I)
R(I,J,T,S)
;

EQUATION
OBJ
E2
E3
E4
E5
E6
E7
E8
E14
E16
E17
E20
E21
;

OBJ..Z=E=SUM((S,O,D,T),H(S)*R(O,D,T,S));
E2(I,J)$LINK(I,J)..F(I)=G=G(I,J);
E3(I,J)$LINK(I,J)..F(J)=G=G(I,J);
E4(I)..ZA(I)=L=QMAX*F(I);
E5(O,D,K)$(ORD(K)<=KW(O,D))..SUM((I,J)$LINK(I,J),BIJ(I,J,K,O,D)*G(I,J))-W(K,O,D) =G=M*(DELTA(O,D,K)-1);
E6(O,D,K)$(ORD(K)<=KW(O,D))..SUM((I,J)$LINK(I,J),BIJ(I,J,K,O,D)*G(I,J))-W(K,O,D)+0.001 =L=M*DELTA(O,D,K);
E7(O,D,K)$(ORD(K)<=KW(O,D))..DELTA(O,D,K)=L=SUM((I,J)$LINK(I,J),BIJ(I,J,K,O,D)*G(I,J))/W(K,O,D) ;
E8..SUM(I,CA(I)*F(I))+SUM((I,J),CAB(I,J)*G(I,J))+C0*SUM(I,ZA(I))=L=KK;
E14(O,D,T,S)..R(O,D,T,S)=L=ZALPHA*SQR(TH(O,D,T,S));
E16(I,T,S)..SUM((D)$U(I,D),R(I,D,T,S))=L=SUM((O)$U(O,I),R(O,I,T-1,S))+ZA(I);
E17(I,T,S)..SUM((D)$U(I,D),R(I,D,T,S))+ZA(I)=G=SUM((O)$U(O,I),R(O,I,T-1,S));
E20(O,D,K,T,S)$(ORD(K)<=KW(O,D))..R(O,D,T,S)=L=BETA(O,D,K)*TH(O,D,T,S)*DELTA(O,D,K)+M*(1-SIGMA(O,D,K));
E21(O,D)$U(O,D)..SUM(K$(ORD(K)<=KW(O,D)),SIGMA(O,D,K))=E=1;

MODEL FINAL/ALL/
OPTION OPTCR=0,MIP=CPLEX;
SOLVE FINAL USING MIP MAX Z;
