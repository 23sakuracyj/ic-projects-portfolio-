.title 6T SRAM Write1 Vmin PVT Sweep

.option post=2
.option accurate
.option nomod

************************************************************************
* Default run: TT, 85C
************************************************************************
.temp 85
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn

.param VDDVAL = 1.8
.param TSTART = 1n
.param TEND   = 4n
.param TCHECK = 12n

************************************************************************
* 6T SRAM Cell
************************************************************************
.SUBCKT write_min B Bbar GND Q_B VDD W0
*.PININFO B:B Bbar:B GND:B Q_B:B VDD:B W0:B
MNM3 B    W0 Q   GND nch_tn W=700n L=180n M=1.0
MNM2 Bbar W0 Q_B GND nch_tn W=700n L=180n M=1.0

MNM1 Q_B Q   GND GND nch_tn W=1.5u L=180n M=1.0
MNM0 Q   Q_B GND GND nch_tn W=1.5u L=180n M=1.0

MPM1 Q_B Q   VDD VDD pch_tn W=450n L=180n M=1.0
MPM0 Q   Q_B VDD VDD pch_tn W=450n L=180n M=1.0
.ENDS

************************************************************************
* Testbench: Write 1 to Q
************************************************************************
VVDD VDD 0 VDDVAL

* Instantiate SRAM
* Pins: B Bbar GND Q_B VDD W0
XSRAM B Bbar 0 QB VDD WL write_min

************************************************************************
* Initial condition
* Write 1 test:
* Initial state: Q=0, Q_B=1
************************************************************************
.ic V(XSRAM.Q)=0 V(QB)=VDDVAL

************************************************************************
* Bitline and wordline waveform
*
* Write 1:
* B    = VDD
* Bbar = 0
* WL   = VDD during write window
************************************************************************
VB B 0 PWL(
+ 0n      'VDDVAL'
+ 1n      'VDDVAL'
+ 1.05n   'VDDVAL'
+ 10n      'VDDVAL'
+ 10.05n   'VDDVAL'
+ 12n      'VDDVAL'
+ )

VBBAR Bbar 0 PWL(
+ 0n      'VDDVAL'
+ 1n      'VDDVAL'
+ 1.05n   '0'
+ 10n      '0'
+ 10.05n   'VDDVAL'
+ 12n      'VDDVAL'
+ )
VWL WL 0 PWL(
+ 0n      0
+ 1n      0
+ 1.05n   'VDDVAL'
+ 10n      'VDDVAL'
+ 10.05n   0
+ 12n      0
+ )

************************************************************************
* Transient with VDD sweep
************************************************************************
.tran 1p 12n UIC SWEEP VDDVAL LIN 151 0.30 1.80

************************************************************************
* Measurements
************************************************************************
.measure tran Q_FINAL  FIND V(XSRAM.Q) AT=TCHECK
.measure tran QB_FINAL FIND V(QB)      AT=TCHECK

* Basic criterion reference values
.measure tran VDD_HALF PARAM='0.5*VDDVAL'
.measure tran VDD_LOW  PARAM='0.1*VDDVAL'
.measure tran VDD_HIGH PARAM='0.9*VDDVAL'




************************************************************************
* PVT alters
************************************************************************

.alter TT_25
.temp 25
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn

.alter TT_125
.temp 125
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn

.alter SS_85
.temp 85
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" ss_tn

.alter SS_25
.temp 25
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" ss_tn

.alter SS_125
.temp 125
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" ss_tn
.end
