.title 6T SRAM Write1 Vmin with Write Assist PVT Sweep

.option post=2
.option accurate
.option nomod

************************************************************************
* PVT default case:
* mt0 = SS_25
************************************************************************
.temp 25
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" ss_tn

.param VDDVAL = 1.8
.param TCHECK = 12n

************************************************************************
* Library Name: Test
* Cell Name:    inv
************************************************************************
.SUBCKT inv GND VDD Vin Vout
MNM0 Vout Vin GND GND nch_tn W=220n L=180n M=1.0
MPM0 Vout Vin VDD VDD pch_tn W=500n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    write_min_assist
************************************************************************
.SUBCKT write_min_assist B Bbar GND Q_B VDD W0 write_assist

MNM5 VSS_AST net026 GND GND nch_tn W=1.6u L=180n M=1.0

MNM3 B    W0 Q   VSS_AST nch_tn W=700n L=180n M=1.0
MNM2 Bbar W0 Q_B VSS_AST nch_tn W=700n L=180n M=1.0

MNM1 Q_B Q   VSS_AST VSS_AST nch_tn W=1.5u L=180n M=1.0
MNM0 Q   Q_B VSS_AST VSS_AST nch_tn W=1.5u L=180n M=1.0

MPM1 Q_B Q   VDD VDD pch_tn W=450n L=180n M=1.0
MPM0 Q   Q_B VDD VDD pch_tn W=450n L=180n M=1.0

XI11 GND VDD write_assist net026 inv

CI10 VSS_AST write_assist 10f

.ENDS

************************************************************************
* Testbench
************************************************************************
VVDD VDD 0 'VDDVAL'

* Pins: B Bbar GND Q_B VDD W0 write_assist
XSRAM B Bbar 0 QB VDD WL WA write_min_assist

************************************************************************
* Initial condition for write1:
* Q = 0, Q_B = 1
************************************************************************
.ic V(XSRAM.Q)=0 V(QB)='VDDVAL' V(XSRAM.VSS_AST)=0
************************************************************************
* Write0 timing:
*
* 与普通 6T SRAM 保持一致：
*   B/Bbar 切换时间：1.05 ns
*   WL 打开时间    ：1.05 ns ~ 8.05 ns
*   B/Bbar 恢复时间：8.05 ns
*   测量时间       ：10.00 ns
*
* 仅额外增加 write_assist：
*   WA 打开：6.20 ns
*   WA 关闭：8.00 ns
************************************************************************

************************************************************************
* Write0:
*   B    = 0
*   Bbar = VDD
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

VWA WA 0 PWL(
+ 0n      0
+ 2n   0
+ 2.05n   'VDDVAL'
+ 10n   'VDDVAL'
+ 10.05n   0
+ 12n      0
+ )

************************************************************************
* VDD sweep
************************************************************************
.tran 1p 12n UIC SWEEP VDDVAL LIN 151 0.30 1.80

************************************************************************
* Measurements
************************************************************************
.measure tran Q_FINAL  FIND V(XSRAM.Q) AT=TCHECK
.measure tran QB_FINAL FIND V(QB)      AT=TCHECK
.measure tran VDD_HALF PARAM='0.5*VDDVAL'
.measure tran VDD_LOW  PARAM='0.1*VDDVAL'
.measure tran VDD_HIGH PARAM='0.9*VDDVAL'

************************************************************************
* PVT alters
************************************************************************

.alter SS_85
.temp 85
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" ss_tn

.alter SS_125
.temp 125
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" ss_tn

.alter TT_25
.temp 25
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn

.alter TT_85
.temp 85
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn

.alter TT_125
.temp 125
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn

.end
