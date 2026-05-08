.title 6T SRAM WSNM Write SNM VTC

.option post=2
.option accurate
.option nomod
.temp 85

.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn

.param VDDVAL = 1.8

************************************************************************
* Power supply
************************************************************************
VVDD VDD 0 'VDDVAL'
VGND GND 0 0

************************************************************************
* Write SNM condition
* WL = VDD
*
************************************************************************
* Write Q = 1 condition:
*   BLB = VDD
*   BL  = 0
************************************************************************
VWL  WL  0 'VDDVAL'
VBL  BL  0 0
VBLB BLB 0 'VDDVAL'

************************************************************************
* Broken-loop input
* Sweep QBI and observe Q
************************************************************************
VQBI QBI 0 DC 0

* Tie QI to 0 to avoid floating node
VQI  QI  0 0

************************************************************************
* SRAM cell instance
* Port order:
* .SUBCKT BF_TEST BL BLB GND Q QB QBI QI VDD WL
************************************************************************
XBF BL BLB GND Q QB QBI QI VDD WL BF_TEST

************************************************************************
* DC sweep
************************************************************************
.dc VQBI 0 'VDDVAL' 0.001

************************************************************************
* Output data
* Columns:
* sweep voltage, V(QBI), V(Q), V(QI), V(QB)
************************************************************************
.print dc V(QBI) V(Q) V(QI) V(QB)
.probe dc V(QBI) V(Q) V(QI) V(QB)

************************************************************************
* Broken-loop 6T SRAM cell
************************************************************************
.SUBCKT BF_TEST BL BLB GND Q QB QBI QI VDD WL
*.PININFO BL:B BLB:B GND:B Q:B QB:B QBI:B QI:B VDD:B WL:B

* Access NMOS
* Q  is connected to BLB
* QB is connected to BL
MNM2 BLB WL Q  GND nch_tn W=700n L=180n M=1.0
MNM3 BL  WL QB GND nch_tn W=700n L=180n M=1.0

* Right inverter: input = QI, output = QB
MNM0 QB QI  GND GND nch_tn W=1.5u L=180n M=1.0
MPM0 QB QI  VDD VDD pch_tn W=450n L=180n M=1.0

* Left inverter: input = QBI, output = Q
MNM1 Q  QBI GND GND nch_tn W=1.5u L=180n M=1.0
MPM1 Q  QBI VDD VDD pch_tn W=450n L=180n M=1.0

.ENDS BF_TEST

.end
