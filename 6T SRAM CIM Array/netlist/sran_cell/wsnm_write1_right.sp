.title 6T SRAM WSNM Write1 Right VTC

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
* Write 1 condition
* Q  <-> BLB = VDD
* QB <-> BL  = 0
************************************************************************
VWL  WL  0 'VDDVAL'
VBL  BL  0 0
VBLB BLB 0 'VDDVAL'

************************************************************************
* Right inverter VTC
* Sweep QI and observe QB
************************************************************************
VQI  QI  0 DC 0

* Tie the other broken-loop input to avoid floating node
VQBI QBI 0 0

************************************************************************
* SRAM cell instance
* Port order:
* .SUBCKT BF_TEST BL BLB GND Q QB QBI QI VDD WL
************************************************************************
XBF BL BLB GND Q QB QBI QI VDD WL BF_TEST

************************************************************************
* DC sweep
************************************************************************
.dc VQI 0 'VDDVAL' 0.001

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

* Access NMOS
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
