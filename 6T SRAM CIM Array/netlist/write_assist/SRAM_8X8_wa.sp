.title
.option post
.temp 85
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn
************************************************************************
* auCdl Netlist:
* 
* Library Name:  Test
* Top Cell Name: SRAM_8X8_wa
* View Name:     schematic
* Netlisted on:  Mar 13 09:19:50 2026
************************************************************************

*.BIPOLAR
*.RESI = 2000 
*.RESVAL
*.CAPVAL
*.DIOPERI
*.DIOAREA
*.EQUATION
*.SCALE METER
*.MEGA
.PARAM



************************************************************************
* Library Name: Test
* Cell Name:    inv_1
* View Name:    schematic
************************************************************************

.SUBCKT inv_1 GND VDD Vin Vout
*.PININFO GND:B VDD:B Vin:B Vout:B
MNM0 Vout Vin GND GND nch_tn W=300n L=180n M=1.0
MPM0 Vout Vin VDD VDD pch_tn W=500n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    precharge
* View Name:    schematic
************************************************************************

.SUBCKT precharge B Bbar GND VDD charge_en
*.PININFO B:B Bbar:B GND:B VDD:B charge_en:B
MPM3 Bbar charge_en B VDD pch_tn W=1.4u L=180n M=1.0
MPM2 B charge_en Bbar VDD pch_tn W=1.4u L=180n M=1.0
MPM1 B charge_en VDD VDD pch_tn W=1.4u L=180n M=1.0
MPM0 Bbar charge_en VDD VDD pch_tn W=1.4u L=180n M=1.0
XI0 GND VDD charge_en charge_enb / inv_1
MNM1 Bbar charge_enb B GND nch_tn W=1.4u L=180n M=1.0
MNM0 B charge_enb Bbar GND nch_tn W=1.4u L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    MUX_B
* View Name:    schematic
************************************************************************

.SUBCKT MUX_B B D7 GND VDD W_E
*.PININFO B:B D7:B GND:B VDD:B W_E:B
MNM3 net06 D7 GND GND nch_tn W=450n L=180n M=1.0
MNM0 net74 W_E GND GND nch_tn W=450n L=180n M=1.0
MNM2 net71 W_E GND GND nch_tn W=1.215u L=180n M=1.0
MNM1 B net06 net71 net71 nch_tn W=1.215u L=180n M=1.0
MPM3 net06 D7 VDD VDD pch_tn W=1.35u L=180n M=1.0
MPM2 B net06 net72 net72 pch_tn W=2.115u L=180n M=1.0
MPM1 net72 net74 VDD VDD pch_tn W=2.115u L=180n M=1.0
MPM0 net74 W_E VDD VDD pch_tn W=1.35u L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    MUX_Bbar
* View Name:    schematic
************************************************************************

.SUBCKT MUX_Bbar Bbar D7 GND VDD W_E
*.PININFO Bbar:B D7:B GND:B VDD:B W_E:B
MNM2 net11 W_E GND GND nch_tn W=12.15u L=180n M=1.0
MNM1 Bbar D7 net11 net11 nch_tn W=12.15u L=180n M=1.0
MNM0 net8 W_E GND GND nch_tn W=450n L=180n M=1.0
MPM2 Bbar D7 net13 net13 pch_tn W=2.115u L=180n M=1.0
MPM1 net13 net8 VDD VDD pch_tn W=2.115u L=180n M=1.0
MPM0 net8 W_E VDD VDD pch_tn W=1.35u L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    inv
* View Name:    schematic
************************************************************************

.SUBCKT inv GND VDD Vin Vout
*.PININFO GND:B VDD:B Vin:B Vout:B
MNM0 Vout Vin GND GND nch_tn W=220n L=180n M=1.0
MPM0 Vout Vin VDD VDD pch_tn W=500n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    guan
* View Name:    schematic
************************************************************************

.SUBCKT guan BL BLq GND VDD Vin
*.PININFO BL:B BLq:B GND:B VDD:B Vin:B
MNM75 BLq Vin BL GND nch_tn W=220n L=180n M=1.0
MNM76 BL net34 GND GND nch_tn W=220n L=180n M=1.0
XI78 GND VDD Vin net34 / inv
MPM5 BL net34 BLq VDD pch_tn W=220n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    nor3
* View Name:    schematic
************************************************************************

.SUBCKT nor3 A B C GND VDD Vout
*.PININFO A:B B:B C:B GND:B VDD:B Vout:B
MPM2 Vout C net012 VDD pch_tn W=1.5u L=180n M=1.0
MPM1 net012 B net12 VDD pch_tn W=1.5u L=180n M=1.0
MPM0 net12 A VDD VDD pch_tn W=1.5u L=180n M=1.0
MNM2 Vout C GND GND nch_tn W=250n L=180n M=1.0
MNM1 Vout B GND GND nch_tn W=250n L=180n M=1.0
MNM0 Vout A GND GND nch_tn W=250n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    Decoder3_8
* View Name:    schematic
************************************************************************

.SUBCKT Decoder3_8 A B BL0 BL1 BL2 BL3 BL4 BL5 BL6 BL7 BLq0 BLq1 BLq2 BLq3 
+ BLq4 BLq5 BLq6 BLq7 C GND VDD
*.PININFO A:B B:B BL0:B BL1:B BL2:B BL3:B BL4:B BL5:B BL6:B BL7:B BLq0:B 
*.PININFO BLq1:B BLq2:B BLq3:B BLq4:B BLq5:B BLq6:B BLq7:B C:B GND:B VDD:B
XI11 BL7 BLq7 GND VDD B7 / guan
XI12 BL6 BLq6 GND VDD B6 / guan
XI13 BL5 BLq5 GND VDD B5 / guan
XI14 BL4 BLq4 GND VDD B4 / guan
XI83 BL0 BLq0 GND VDD B0 / guan
XI84 BL1 BLq1 GND VDD B1 / guan
XI85 BL2 BLq2 GND VDD B2 / guan
XI86 BL3 BLq3 GND VDD B3 / guan
XI6 _A _B _C GND VDD B7 / nor3
XI8 _A B C GND VDD B4 / nor3
XI9 _A _B C GND VDD B6 / nor3
XI10 _A B _C GND VDD B5 / nor3
XI4 A _B _C GND VDD B3 / nor3
XI3 A _B C GND VDD B2 / nor3
XI2 A B _C GND VDD B1 / nor3
XI1 A B C GND VDD B0 / nor3
XI5 GND VDD C _C / inv
XI0 GND VDD A _A / inv
XI7 GND VDD B _B / inv
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    sense_amplifier
* View Name:    schematic
************************************************************************

.SUBCKT sense_amplifier B Bbar GND ReadOut ReadOutbar VDD sense
*.PININFO B:B Bbar:B GND:B ReadOut:B ReadOutbar:B VDD:B sense:B
MPM3 ReadOut ReadOutbar VDD VDD pch_tn W=810n L=180n M=1.0
MPM2 ReadOutbar ReadOut VDD VDD pch_tn W=810n L=180n M=1.0
MPM1 ReadOutbar sense Bbar VDD pch_tn W=1.305u L=180n M=1.0
MPM0 ReadOut sense B VDD pch_tn W=1.305u L=180n M=1.0
MNM2 net8 VDD GND GND nch_tn W=900n L=180n M=1.0
MNM1 ReadOutbar ReadOut net8 net8 nch_tn W=495n L=180n M=1.0
MNM0 ReadOut ReadOutbar net8 net8 nch_tn W=495n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    SRAM_6T
* View Name:    schematic
************************************************************************

.SUBCKT SRAM_6T B Bbar GND VDD W0
*.PININFO B:B Bbar:B GND:B VDD:B W0:B
MNM3 B W0 net12 GND nch_tn W=700n L=180n M=1.0
MNM2 Bbar W0 net3 GND nch_tn W=700n L=180n M=1.0
MNM1 net3 net12 GND GND nch_tn W=1.5u L=180n M=1.0
MNM0 net12 net3 GND GND nch_tn W=1.5u L=180n M=1.0
MPM1 net3 net12 VDD VDD pch_tn W=450n L=180n M=1.0
MPM0 net12 net3 VDD VDD pch_tn W=450n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    SRAM_8X8_wa
* View Name:    schematic
************************************************************************

.SUBCKT SRAM_8X8_wa BE GND PRE ReadOut0 ReadOut1 ReadOut2 ReadOut3 ReadOut4 
+ ReadOut5 ReadOut6 ReadOut7 ReadOutbar0 ReadOutbar1 ReadOutbar2 ReadOutbar3 
+ ReadOutbar4 ReadOutbar5 ReadOutbar6 ReadOutbar7 S VDD W0_en W1_en W2_en 
+ W3_en W4_en W5_en W6_en W7_en WN0 WN1 WN2 data0 data1 data2 data3 data4 
+ data5 data6 data7 write_assist
*.PININFO BE:B GND:B PRE:B ReadOut0:B ReadOut1:B ReadOut2:B ReadOut3:B 
*.PININFO ReadOut4:B ReadOut5:B ReadOut6:B ReadOut7:B ReadOutbar0:B 
*.PININFO ReadOutbar1:B ReadOutbar2:B ReadOutbar3:B ReadOutbar4:B 
*.PININFO ReadOutbar5:B ReadOutbar6:B ReadOutbar7:B S:B VDD:B W0_en:B W1_en:B 
*.PININFO W2_en:B W3_en:B W4_en:B W5_en:B W6_en:B W7_en:B WN0:B WN1:B WN2:B 
*.PININFO data0:B data1:B data2:B data3:B data4:B data5:B data6:B data7:B 
*.PININFO write_assist:B
XI76 B5 Bbar5 GND VDD PRE / precharge
XI75 B4 Bbar4 GND VDD PRE / precharge
XI77 B6 Bbar6 GND VDD PRE / precharge
XI78 B7 Bbar7 GND VDD PRE / precharge
XI43 B3 Bbar3 GND VDD PRE / precharge
XI41 B2 Bbar2 GND VDD PRE / precharge
XI39 B1 Bbar1 GND VDD PRE / precharge
XI8 B0 Bbar0 GND VDD PRE / precharge
XI118 B4 data4 GND VDD BE / MUX_B
XI116 B6 data6 GND VDD BE / MUX_B
XI114 B7 data7 GND VDD BE / MUX_B
XI112 B5 data5 GND VDD BE / MUX_B
XI36 B2 data2 GND VDD BE / MUX_B
XI33 B3 data3 GND VDD BE / MUX_B
XI30 B1 data1 GND VDD BE / MUX_B
XI6 B0 data0 GND VDD BE / MUX_B
XI117 Bbar4 data4 GND VDD BE / MUX_Bbar
XI115 Bbar6 data6 GND VDD BE / MUX_Bbar
XI113 Bbar7 data7 GND VDD BE / MUX_Bbar
XI111 Bbar5 data5 GND VDD BE / MUX_Bbar
XI35 Bbar2 data2 GND VDD BE / MUX_Bbar
XI32 Bbar3 data3 GND VDD BE / MUX_Bbar
XI29 Bbar1 data1 GND VDD BE / MUX_Bbar
XI7 Bbar0 data0 GND VDD BE / MUX_Bbar
XI5 WN0 WN1 W0 W1 W2 W3 W4 W5 W6 W7 W0_en W1_en W2_en W3_en W4_en W5_en W6_en 
+ W7_en WN2 GND VDD / Decoder3_8
XI74 B6 Bbar6 GND ReadOut6 ReadOutbar6 VDD S / sense_amplifier
XI73 B4 Bbar4 GND ReadOut4 ReadOutbar4 VDD S / sense_amplifier
XI71 B5 Bbar5 GND ReadOut5 ReadOutbar5 VDD S / sense_amplifier
XI72 B7 Bbar7 GND ReadOut7 ReadOutbar7 VDD S / sense_amplifier
XI26 B3 Bbar3 GND ReadOut3 ReadOutbar3 VDD S / sense_amplifier
XI25 B2 Bbar2 GND ReadOut2 ReadOutbar2 VDD S / sense_amplifier
XI24 B1 Bbar1 GND ReadOut1 ReadOutbar1 VDD S / sense_amplifier
XI4 B0 Bbar0 GND ReadOut0 ReadOutbar0 VDD S / sense_amplifier
XI110 B2 Bbar2 VSS_AST VDD W6 / SRAM_6T
XI109 B1 Bbar1 VSS_AST VDD W6 / SRAM_6T
XI108 B0 Bbar0 VSS_AST VDD W6 / SRAM_6T
XI107 B3 Bbar3 VSS_AST VDD W7 / SRAM_6T
XI106 B2 Bbar2 VSS_AST VDD W7 / SRAM_6T
XI105 B1 Bbar1 VSS_AST VDD W7 / SRAM_6T
XI104 B0 Bbar0 VSS_AST VDD W7 / SRAM_6T
XI103 B3 Bbar3 VSS_AST VDD W6 / SRAM_6T
XI102 B4 Bbar4 VSS_AST VDD W7 / SRAM_6T
XI101 B4 Bbar4 VSS_AST VDD W5 / SRAM_6T
XI100 B6 Bbar6 VSS_AST VDD W5 / SRAM_6T
XI99 B4 Bbar4 VSS_AST VDD W4 / SRAM_6T
XI98 B5 Bbar5 VSS_AST VDD W5 / SRAM_6T
XI97 B7 Bbar7 VSS_AST VDD W5 / SRAM_6T
XI96 B6 Bbar6 VSS_AST VDD W7 / SRAM_6T
XI95 B5 Bbar5 VSS_AST VDD W7 / SRAM_6T
XI94 B7 Bbar7 VSS_AST VDD W6 / SRAM_6T
XI93 B6 Bbar6 VSS_AST VDD W6 / SRAM_6T
XI92 B5 Bbar5 VSS_AST VDD W6 / SRAM_6T
XI91 B4 Bbar4 VSS_AST VDD W6 / SRAM_6T
XI90 B5 Bbar5 VSS_AST VDD W4 / SRAM_6T
XI89 B6 Bbar6 VSS_AST VDD W4 / SRAM_6T
XI88 B7 Bbar7 VSS_AST VDD W4 / SRAM_6T
XI87 B3 Bbar3 VSS_AST VDD W4 / SRAM_6T
XI86 B3 Bbar3 VSS_AST VDD W5 / SRAM_6T
XI85 B2 Bbar2 VSS_AST VDD W5 / SRAM_6T
XI55 B4 Bbar4 VSS_AST VDD W3 / SRAM_6T
XI63 B4 Bbar4 VSS_AST VDD W1 / SRAM_6T
XI65 B6 Bbar6 VSS_AST VDD W1 / SRAM_6T
XI67 B4 Bbar4 VSS_AST VDD W0 / SRAM_6T
XI64 B5 Bbar5 VSS_AST VDD W1 / SRAM_6T
XI66 B7 Bbar7 VSS_AST VDD W1 / SRAM_6T
XI84 B2 Bbar2 VSS_AST VDD W4 / SRAM_6T
XI57 B6 Bbar6 VSS_AST VDD W3 / SRAM_6T
XI56 B5 Bbar5 VSS_AST VDD W3 / SRAM_6T
XI80 B0 Bbar0 VSS_AST VDD W5 / SRAM_6T
XI79 B0 Bbar0 VSS_AST VDD W4 / SRAM_6T
XI81 B7 Bbar7 VSS_AST VDD W7 / SRAM_6T
XI82 B1 Bbar1 VSS_AST VDD W5 / SRAM_6T
XI83 B1 Bbar1 VSS_AST VDD W4 / SRAM_6T
XI62 B7 Bbar7 VSS_AST VDD W2 / SRAM_6T
XI61 B6 Bbar6 VSS_AST VDD W2 / SRAM_6T
XI60 B5 Bbar5 VSS_AST VDD W2 / SRAM_6T
XI59 B4 Bbar4 VSS_AST VDD W2 / SRAM_6T
XI68 B5 Bbar5 VSS_AST VDD W0 / SRAM_6T
XI69 B6 Bbar6 VSS_AST VDD W0 / SRAM_6T
XI70 B7 Bbar7 VSS_AST VDD W0 / SRAM_6T
XI23 B3 Bbar3 VSS_AST VDD W0 / SRAM_6T
XI22 B3 Bbar3 VSS_AST VDD W1 / SRAM_6T
XI21 B3 Bbar3 VSS_AST VDD W2 / SRAM_6T
XI20 B3 Bbar3 VSS_AST VDD W3 / SRAM_6T
XI19 B2 Bbar2 VSS_AST VDD W3 / SRAM_6T
XI18 B2 Bbar2 VSS_AST VDD W2 / SRAM_6T
XI17 B2 Bbar2 VSS_AST VDD W1 / SRAM_6T
XI16 B2 Bbar2 VSS_AST VDD W0 / SRAM_6T
XI15 B1 Bbar1 VSS_AST VDD W0 / SRAM_6T
XI14 B1 Bbar1 VSS_AST VDD W1 / SRAM_6T
XI13 B1 Bbar1 VSS_AST VDD W2 / SRAM_6T
XI12 B1 Bbar1 VSS_AST VDD W3 / SRAM_6T
XI58 B7 Bbar7 VSS_AST VDD W3 / SRAM_6T
XI3 B0 Bbar0 VSS_AST VDD W3 / SRAM_6T
XI2 B0 Bbar0 VSS_AST VDD W2 / SRAM_6T
XI1 B0 Bbar0 VSS_AST VDD W1 / SRAM_6T
XI0 B0 Bbar0 VSS_AST VDD W0 / SRAM_6T
MNM0 VSS_AST net22 GND GND nch_tn W=1.6u L=180n M=1.0
XI11 GND VDD write_assist net22 / inv
CI10 VSS_AST write_assist 10f $[CP]
.ENDS
XSRAM_8X8_wa BE GND PRE ReadOut0 ReadOut1 ReadOut2 ReadOut3 ReadOut4 
+ ReadOut5 ReadOut6 ReadOut7 ReadOutbar0 ReadOutbar1 ReadOutbar2 ReadOutbar3 
+ ReadOutbar4 ReadOutbar5 ReadOutbar6 ReadOutbar7 S VDD W0_en W1_en W2_en 
+ W3_en W4_en W5_en W6_en W7_en WN0 WN1 WN2 data0 data1 data2 data3 data4 
+ data5 data6 data7 write_assist SRAM_8X8_wa
VVDD VDD 0 0.75
VGND GND 0 0
VW0_en W0_en W_EN[0]
VW1_en W1_en W_EN[1]
VW2_en W2_en W_EN[2]
VW3_en W3_en W_EN[3]
VW4_en W4_en W_EN[4]
VW5_en W5_en W_EN[5]
VW6_en W6_en W_EN[6]
VW7_en W7_en W_EN[7]
VWN0 WN0 WN[0]
VWN1 WN1 WN[1]
VWN2 WN2 WN[2]
Vdata0 data0 DATA[0]
Vdata1 data1 DATA[1]
Vdata2 data2 DATA[2]
Vdata3 data3 DATA[3]
Vdata4 data4 DATA[4]
Vdata5 data5 DATA[5]
Vdata6 data6 DATA[6]
Vdata7 data7 DATA[7]
.vec 'SRAM8X8_wa.vec'
.tran 1ns 250ns
.end
