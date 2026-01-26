.title
.option post
.temp 85
.lib "/home/IC/CYJ2025/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn
************************************************************************
* auCdl Netlist:
* 
* Library Name:  Test
* Top Cell Name: SRAM_4x4_v2
* View Name:     schematic
* Netlisted on:  May 16 15:50:35 2025
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
* Library Name: SRAM2
* Cell Name:    nor2
* View Name:    schematic
************************************************************************

.SUBCKT nor2 A B GND VDD Vout
*.PININFO A:B B:B GND:B VDD:B Vout:B
MPM1 Vout B net12 VDD pch_tn W=1u L=180n M=1.0
MPM0 net12 A VDD VDD pch_tn W=1u L=180n M=1.0
MNM1 Vout B GND GND nch_tn W=250n L=180n M=1.0
MNM0 Vout A GND GND nch_tn W=250n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: SRAM2
* Cell Name:    inv
* View Name:    schematic
************************************************************************

.SUBCKT inv GND VDD Vin Vout
*.PININFO GND:B VDD:B Vin:B Vout:B
MNM0 Vout Vin GND GND nch_tn W=220n L=180n M=1.0
MPM0 Vout Vin VDD VDD pch_tn W=500n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: SRAM2
* Cell Name:    guan
* View Name:    schematic
************************************************************************

.SUBCKT guan BL BLq GND VDD Vin
*.PININFO BL:B BLq:B GND:B VDD:B Vin:B
MNM75 BLq Vin BL GND nch_tn W=220n L=180n M=1.0
MNM76 BL net34 GND GND nch_tn W=220n L=180n M=1.0
MPM5 BL net34 BLq VDD pch_tn W=220n L=180n M=1.0
XI78 GND VDD Vin net34 / inv
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    Decoder2_4
* View Name:    schematic
************************************************************************

.SUBCKT Decoder2_4 A B BL0 BL1 BL2 BL3 BLq0 BLq1 BLq2 BLq3 GND VDD
*.PININFO A:B B:B BL0:B BL1:B BL2:B BL3:B BLq0:B BLq1:B BLq2:B BLq3:B GND:B 
*.PININFO VDD:B
XI4 net4 net5 GND VDD B3 / nor2
XI3 net4 B GND VDD B2 / nor2
XI2 A net5 GND VDD B1 / nor2
XI1 A B GND VDD B0 / nor2
XI83 BL0 BLq0 GND VDD B0 / guan
XI84 BL1 BLq1 GND VDD B1 / guan
XI85 BL2 BLq2 GND VDD B2 / guan
XI86 BL3 BLq3 GND VDD B3 / guan
XI0 GND VDD A net4 / inv
XI7 GND VDD B net5 / inv
.ENDS

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
* Cell Name:    write_data
* View Name:    schematic
************************************************************************

.SUBCKT write_data B Bbar GND VDD W_E data
*.PININFO B:B Bbar:B GND:B VDD:B W_E:B data:B
XI0 B data GND VDD W_E / MUX_B
XI1 Bbar data GND VDD W_E / MUX_Bbar
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
* Cell Name:    nand_2
* View Name:    schematic
************************************************************************

.SUBCKT nand_2 A B GND VDD Vout
*.PININFO A:B B:B GND:B VDD:B Vout:B
MNM1 Vout A net17 GND nch_tn W=220n L=180n M=1.0
MNM0 net17 B GND GND nch_tn W=500n L=180n M=1.0
MPM1 Vout B VDD VDD pch_tn W=500n L=180n M=1.0
MPM0 Vout A VDD VDD pch_tn W=500n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    inv_schematic
* View Name:    schematic
************************************************************************

.SUBCKT inv_schematic GND VDD Vin Vout
*.PININFO GND:B VDD:B Vin:B Vout:B
MNM0 Vout Vin GND GND nch_tn W=220n L=180n M=1.0
MPM0 Vout Vin VDD VDD pch_tn W=500n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    and2
* View Name:    schematic
************************************************************************

.SUBCKT and2 A B GND VDD Vout
*.PININFO A:B B:B GND:B VDD:B Vout:B
XI0 A B GND VDD net8 / nand_2
XI1 GND VDD net8 Vout / inv_schematic
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    SRAM_4x4_v2
* View Name:    schematic
************************************************************************

.SUBCKT SRAM_4x4_v2 GND PREN_0 PREN_1 PREN_2 PREN_3 REN_0 REN_1 REN_2 REN_3 
+ VDD WEN_0 WEN_1 WEN_2 WEN_3 X0enable X1enable X2enable X3enable Xi_0 Xi_1 
+ Y0enable Y1enable Y2enable Y3enable Yi_0 Yi_1 data_0 data_1 data_2 data_3 
+ data_out_0 data_out_0_b data_out_1 data_out_1_b data_out_2 data_out_2_b 
+ data_out_3 data_out_3_b
*.PININFO GND:B PREN_0:B PREN_1:B PREN_2:B PREN_3:B REN_0:B REN_1:B REN_2:B 
*.PININFO REN_3:B VDD:B WEN_0:B WEN_1:B WEN_2:B WEN_3:B X0enable:B X1enable:B 
*.PININFO X2enable:B X3enable:B Xi_0:B Xi_1:B Y0enable:B Y1enable:B Y2enable:B 
*.PININFO Y3enable:B Yi_0:B Yi_1:B data_0:B data_1:B data_2:B data_3:B 
*.PININFO data_out_0:B data_out_0_b:B data_out_1:B data_out_1_b:B data_out_2:B 
*.PININFO data_out_2_b:B data_out_3:B data_out_3_b:B
XI15 B0 Bbar0 GND VDD W3_0 / SRAM_6T
XI14 B1 Bbar1 GND VDD W3_1 / SRAM_6T
XI13 B2 Bbar2 GND VDD W3_2 / SRAM_6T
XI12 B3 Bbar3 GND VDD W3_3 / SRAM_6T
XI11 B0 Bbar0 GND VDD W2_0 / SRAM_6T
XI10 B1 Bbar1 GND VDD W2_1 / SRAM_6T
XI9 B2 Bbar2 GND VDD W2_2 / SRAM_6T
XI8 B3 Bbar3 GND VDD W2_3 / SRAM_6T
XI7 B0 Bbar0 GND VDD W1_0 / SRAM_6T
XI6 B1 Bbar1 GND VDD W1_1 / SRAM_6T
XI5 B2 Bbar2 GND VDD W1_2 / SRAM_6T
XI4 B3 Bbar3 GND VDD W1_3 / SRAM_6T
XI3 B0 Bbar0 GND VDD W0_0 / SRAM_6T
XI2 B1 Bbar1 GND VDD W0_1 / SRAM_6T
XI1 B2 Bbar2 GND VDD W0_2 / SRAM_6T
XI0 B3 Bbar3 GND VDD W0_3 / SRAM_6T
XI17 Yi_0 Yi_1 y0 y1 y2 y3 Y0enable Y1enable Y2enable Y3enable GND VDD / 
+ Decoder2_4
XI16 Xi_0 Xi_1 x0 x1 x2 x3 X0enable X1enable X2enable X3enable GND VDD / 
+ Decoder2_4
XI41 B0 Bbar0 GND VDD PREN_0 / precharge
XI39 B1 Bbar1 GND VDD PREN_1 / precharge
XI37 B2 Bbar2 GND VDD PREN_2 / precharge
XI35 B3 Bbar3 GND VDD PREN_3 / precharge
XI42 B0 Bbar0 GND VDD WEN_0 data_0 / write_data
XI40 B1 Bbar1 GND VDD WEN_1 data_1 / write_data
XI38 B2 Bbar2 GND VDD WEN_2 data_2 / write_data
XI36 B3 Bbar3 GND VDD WEN_3 data_3 / write_data
XI46 B0 Bbar0 GND data_out_0 data_out_0_b VDD REN_0 / sense_amplifier
XI45 B1 Bbar1 GND data_out_1 data_out_1_b VDD REN_1 / sense_amplifier
XI44 B2 Bbar2 GND data_out_2 data_out_2_b VDD REN_2 / sense_amplifier
XI43 B3 Bbar3 GND data_out_3 data_out_3_b VDD REN_3 / sense_amplifier
XI51 x0 y2 GND VDD W0_2 / and2
XI50 x3 y3 GND VDD W3_3 / and2
XI49 x2 y3 GND VDD W2_3 / and2
XI48 x1 y3 GND VDD W1_3 / and2
XI52 x1 y2 GND VDD W1_2 / and2
XI53 x2 y2 GND VDD W2_2 / and2
XI54 x3 y2 GND VDD W3_2 / and2
XI55 x3 y1 GND VDD W3_1 / and2
XI59 x0 y1 GND VDD W0_1 / and2
XI58 x0 y0 GND VDD W0_0 / and2
XI57 x1 y0 GND VDD W1_0 / and2
XI56 x2 y0 GND VDD W2_0 / and2
XI60 x1 y1 GND VDD W1_1 / and2
XI61 x2 y1 GND VDD W2_1 / and2
XI62 x3 y0 GND VDD W3_0 / and2
XI47 x0 y3 GND VDD W0_3 / and2
.ENDS
VVDD VDD 0 1.8
VGND GND 0 0
.vec 'SRAM_4x4_x.vec'
.vec 'SRAM_4x4_y.vec'
.vec 'SRAM_4x4_w_inputvector.vec'
.vec 'SRAM_4x4_R_inputvector.vec'
VXI_0 Xi_0 vinx[0]
VX1 Xi_1 vinx[1]
VX0ENABLE X0enable vinx[2]
VX1ENABLE X1enable vinx[3]
VX2ENABLE X2enable vinx[4]
VX3ENABLE X3enable vinx[5]
**
VY0 Yi_0 viny[0]
VY1 Yi_1 viny[1]
VY0ENABLE Y0enable viny[2]
VY1ENABLE Y1enable viny[3]
VY2ENABLE Y2enable viny[4]
VY3ENABLE Y3enable viny[5]
**
VWEN_3 WEN_3 vinw[0]
VWEN_2 WEN_2 vinw[1]
VWEN_1 WEN_1 vinw[2]
VWEN_0 WEN_0 vinw[3]
VDATA_3 data_3 vinw[4]
VDATA_2 data_2 vinw[5]
VDATA_1 data_1 vinw[6]
VDATA_0 data_0 vinw[7]
**
VPREN_3 PREN_3 vinr[0]
VPREN_2 PREN_2 vinr[1]
VPREN_1 PREN_1 vinr[2]
VPREN_0 PREN_0 vinr[3]
VREN_3 VREN_3 vinr[4]
VREN_2 VREN_2 vinr[5]
VREN_1 VREN_1 vinr[6]
VREN_0 VREN_0 vinr[7]

XSRAM_4x4_v2 GND PREN_0 PREN_1 PREN_2 PREN_3 REN_0 REN_1 REN_2 REN_3 
+ VDD WEN_0 WEN_1 WEN_2 WEN_3 X0enable X1enable X2enable X3enable Xi_0 Xi_1 
+ Y0enable Y1enable Y2enable Y3enable Yi_0 Yi_1 data_0 data_1 data_2 data_3 
+ data_out_0 data_out_0_b data_out_1 data_out_1_b data_out_2 data_out_2_b 
+ data_out_3 data_out_3_b SRAM_4x4_v2
.TRAN 1n 1000n
.probe
.END
