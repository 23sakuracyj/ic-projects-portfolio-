.title
.option post
.temp 85
.lib "/home/IC/CYJ2025/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn
************************************************************************
* auCdl Netlist:
* 
* Library Name:  Test
* Top Cell Name: SRAM_WE
* View Name:     schematic
* Netlisted on:  Apr 16 11:58:34 2025
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
* Cell Name:    nor_2
* View Name:    schematic
************************************************************************

.SUBCKT nor_2 A B GND VDD Vout
*.PININFO A:B B:B GND:B VDD:B Vout:B
MPM1 Vout B net12 VDD pch_tn W=1u L=180n M=1.0
MPM0 net12 A VDD VDD pch_tn W=1u L=180n M=1.0
MNM1 Vout B GND GND nch_tn W=250n L=180n M=1.0
MNM0 Vout A GND GND nch_tn W=250n L=180n M=1.0
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
* Cell Name:    three_state_gate
* View Name:    schematic
************************************************************************

.SUBCKT three_state_gate A EN GND VDD Y
*.PININFO A:B EN:B GND:B VDD:B Y:B
XI2 GND VDD EN net11 / inv_1
XI3 net11 A GND VDD net17 / nor_2
XI4 EN A GND VDD net16 / nand_2
MNM0 Y net17 GND GND nch_tn W=300n L=180n M=1.0
MPM0 Y net16 VDD VDD pch_tn W=500n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: SRAM1
* Cell Name:    SRAM_6T
* View Name:    schematic
************************************************************************

.SUBCKT SRAM_6T A0 B Bbar GND VDD
*.PININFO A0:B B:B Bbar:B GND:B VDD:B
MNM3 B A0 net12 GND nch_tn W=675n L=180n M=1.0
MNM2 Bbar A0 net03 GND nch_tn W=675n L=180n M=1.0
MNM1 net03 net12 GND GND nch_tn W=1.48u L=180n M=1.0
MNM0 net12 net03 GND GND nch_tn W=1.48u L=180n M=1.0
MPM1 net03 net12 VDD VDD pch_tn W=450n L=180n M=1.0
MPM0 net12 net03 VDD VDD pch_tn W=450n L=180n M=1.0
.ENDS

************************************************************************
* Library Name: Test
* Cell Name:    SRAM_WE
* View Name:    schematic
************************************************************************

.SUBCKT SRAM_WE A GND VDD WE clk data rst
*.PININFO A:B GND:B VDD:B WE:B clk:B data:B rst:B
XI1 WE GND net12 VDD clk rst / D_flip_flop
XI2 data net12 GND VDD net13 / three_state_gate
XI15 GND VDD net13 net07 / inv_1
XI0 A net13 net07 GND VDD / SRAM_6T
.ENDS
* 定义电源及输入信号
VDD VDD 0 1.8 
VCLK clk 0 PULSE(0 1.8 0.1n 0.1n 0.1n 10n 20n)              
               
VCS cs 0 1.8
.vec 'SRAM_WE_inputvector.vec'

* 产生脉冲信号（参数可根据需要调整）
VWE WE vin[0]   
VA A vin[1]  
VDATA data vin[2]

* 实例化顶层模块 SRAM_WE
XSRAM_WE A GND VDD WE clk data cs SRAM_WE

* 瞬态仿真：仿真步长为0.1ns，总时间50ns
.TRAN 1n 600n
.probe V(A) V(WE) V(clk) V(cs) V(data) V(B) V(Bbar)
.END
