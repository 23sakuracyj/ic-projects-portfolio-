.title
.option post
.temp 85
.lib "/home/IC/CYJ2025/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn
************************************************************************
* auCdl Netlist:
* 
* Library Name:  Test
* Top Cell Name: D_latch
* View Name:     schematic
* Netlisted on:  Mar 30 23:07:11 2025
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
VVCC VCC 0 1.8
VGND GND 0 0
VD D 0 PULSE(0 1.8 2n 0.1n 0.1n 10n 20n)
VCLK clk 0 PULSE(0 1.8 2n 0.1n 0.1n 15n 30n)

XD_latch D GND Q VCC clk D_latch
.TRAN 0.1n 50n
.probe V(D) V(clk) V(Q)
.END
