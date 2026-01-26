.title
.option post
.temp 85
.lib "/home/IC/CYJ2025/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn
************************************************************************
* auCdl Netlist:
* 
* Library Name:  Test
* Top Cell Name: SRAM_RD
* View Name:     schematic
* Netlisted on:  Apr 16 19:56:32 2025
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
* Cell Name:    D_latch
* View Name:    schematic
************************************************************************

.SUBCKT D_latch D GND Q VCC clk
*.PININFO D:B GND:B Q:B VCC:B clk:B
MPM3 net02 clk VCC VCC pch_tn W=220n L=180n M=2.0
MPM1 Q net02 net11 net11 pch_tn W=220n L=180n M=2.0
MPM0 net11 D VCC VCC pch_tn W=220n L=180n M=2.0
MNM3 net02 clk GND GND nch_tn W=220n L=180n M=1.0
MNM1 net017 D GND GND nch_tn W=220n L=180n M=1.0
MNM0 Q clk net017 GND nch_tn W=220n L=180n M=1.0
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
* Cell Name:    nand2
* View Name:    schematic
************************************************************************

.SUBCKT nand2 A B GND VDD Vout
*.PININFO A:B B:B GND:B VDD:B Vout:B
MNM1 Vout A net17 GND nch_tn W=500n L=180n M=1.0
MNM0 net17 B GND GND nch_tn W=500n L=180n M=1.0
MPM1 Vout B VDD VDD pch_tn W=500n L=180n M=1.0
MPM0 Vout A VDD VDD pch_tn W=500n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: SRAM2
* Cell Name:    and2
* View Name:    schematic
************************************************************************

.SUBCKT and2 A B GND VDD Vout
*.PININFO A:B B:B GND:B VDD:B Vout:B
XI1 GND VDD net2 Vout / inv
XI0 A B GND VDD net2 / nand2
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    D_flip_flop
* View Name:    schematic
************************************************************************

.SUBCKT D_flip_flop D GND Q VDD clk rst
*.PININFO D:B GND:B Q:B VDD:B clk:B rst:B
XI12 net014 GND net75 VDD clk_b / D_latch
XI11 net70 GND net68 VDD clk / D_latch
XI17 net017 rst GND VDD Q / and2
MNM2 net70 clk net75 GND nch_tn W=220n L=180n M=1.0
MNM0 net63 clk_b net68 GND nch_tn W=220n L=180n M=1.0
MPM2 net75 clk_b net70 VDD pch_tn W=220n L=180n M=1.0
MPM0 net68 clk net63 VDD pch_tn W=220n L=180n M=1.0
XI9 GND VDD D net63 / inv
XI6 GND VDD net75 net014 / inv
XI2 GND VDD net68 net70 / inv
XI14 GND VDD net014 net017 / inv
XI3 GND VDD clk clk_b / inv
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    precharge
* View Name:    schematic
************************************************************************

.SUBCKT precharge B Bbar VDD enable
*.PININFO B:B Bbar:B VDD:B enable:B
MPM1 B enable VDD VDD pch_tn W=220n L=180n M=1.0
MPM0 Bbar enable VDD VDD pch_tn W=220n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: SRAM2
* Cell Name:    SRAM_6T
* View Name:    schematic
************************************************************************

.SUBCKT SRAM_6T A0 B Bbar GND VDD
*.PININFO A0:B B:B Bbar:B GND:B VDD:B
MNM3 B A0 net12 GND nch_tn W=700n L=180n M=1.0
MNM2 Bbar A0 net3 GND nch_tn W=700n L=180n M=1.0
MNM1 net3 net12 GND GND nch_tn W=1.5u L=180n M=1.0
MNM0 net12 net3 GND GND nch_tn W=1.5u L=180n M=1.0
MPM1 net3 net12 VDD VDD pch_tn W=450n L=180n M=1.0
MPM0 net12 net3 VDD VDD pch_tn W=450n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    sense_amplifier
* View Name:    schematic
************************************************************************

.SUBCKT sense_amplifier B Bbar GND ReadOut VDD sense
*.PININFO B:B Bbar:B GND:B ReadOut:B VDD:B sense:B
MPM3 ReadOut net011 VDD VDD pch_tn W=800n L=180n M=1.0
MPM2 net011 ReadOut VDD VDD pch_tn W=800n L=180n M=1.0
MPM1 net011 sense Bbar VDD pch_tn W=1.3u L=180n M=1.0
MPM0 ReadOut sense B VDD pch_tn W=1.3u L=180n M=1.0
MNM2 net8 VDD GND GND nch_tn W=900n L=180n M=1.0
MNM1 net011 ReadOut net8 GND nch_tn W=500n L=180n M=1.0
MNM0 ReadOut net011 net8 GND nch_tn W=500n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    SRAM_RD
* View Name:    schematic
************************************************************************

.SUBCKT SRAM_RD A0 CLK GND RD_EN RST Ready VDD data
*.PININFO A0:B CLK:B GND:B RD_EN:B RST:B Ready:B VDD:B data:B
XI0 Ready GND net4 VDD CLK RST / D_flip_flop
XI1 net6 net5 VDD net4 / precharge
XI2 A0 net6 net5 GND VDD / SRAM_6T
XI4 net6 net5 GND data VDD RD_EN / sense_amplifier
.ENDS
VDD VDD 0 1.8 
VCLK CLK 0 PULSE(0 1.8 2n 0.1n 0.1n 10n 20n)             
               
VRST RST 0 1.8
.vec 'SRAM_RD_inputvector.vec'
VREADY Ready vin[0]
VA0 A0 vin[1]   
VRD_EN RD_EN vin[2]

XSRAM_RD A0 CLK GND RD_EN RST Ready VDD data SRAM_RD 

.TRAN 1n 300n
.probe  V(CLK) V(RD_EN)
.END
