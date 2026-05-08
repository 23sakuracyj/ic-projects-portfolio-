.title
.option post
.temp 85
.lib "/home/SLIC02/Cadence_cyj/SPICE_Model/HL18G-SL3.7/HSPICE/HL18G-S3.7S.lib" tt_tn
VVDD1 VDD 0 0.535V
VGND1 GND 0 0
VRST1 RST 0 0.535V
************************************************************************
* auCdl Netlist:
* 
* Library Name:  experiments
* Top Cell Name: add_tree1
* View Name:     schematic
* Netlisted on:  Jun 15 21:41:28 2025
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
* Library Name: experiments
* Cell Name:    nand_2
* View Name:    schematic
************************************************************************

.SUBCKT nand_2 A B GND VDD Y
*.PININFO A:B B:B GND:B VDD:B Y:B
MPM1 Y B VDD VDD pch_tn W=1.56u L=180n m=1
MPM0 Y A VDD VDD pch_tn W=1.56u L=180n m=1
MNM1 net17 B GND GND nch_tn W=780n L=180n m=1
MNM0 Y A net17 GND nch_tn W=780n L=180n m=1
.ENDS

************************************************************************
* Library Name: experiments
* Cell Name:    inv
* View Name:    schematic
************************************************************************

.SUBCKT inv A GND VDD Y
*.PININFO A:B GND:B VDD:B Y:B
MNM0 Y A GND GND nch_tn W=390n L=180n m=1
MPM0 Y A VDD VDD pch_tn W=1.56u L=180n m=1
.ENDS

************************************************************************
* Library Name: experiments
* Cell Name:    xnor_v2
* View Name:    schematic
************************************************************************

.SUBCKT xnor_v2 A B GND VDD Y
*.PININFO A:B B:B GND:B VDD:B Y:B
XI1 B GND VDD net14 / inv
XI0 A GND VDD net1 / inv
MNM3 net16 net14 GND GND nch_tn W=780n L=180n m=1
MNM2 Y net1 net16 GND nch_tn W=780n L=180n m=1
MNM1 net17 B GND GND nch_tn W=780n L=180n m=1
MNM0 Y A net17 GND nch_tn W=780n L=180n m=1
MPM3 Y net14 net7 VDD pch_tn W=3.12u L=180n m=1
MPM2 net7 B VDD VDD pch_tn W=3.12u L=180n m=1
MPM1 Y net1 net7 VDD pch_tn W=3.12u L=180n m=1
MPM0 net7 A VDD VDD pch_tn W=3.12u L=180n m=1
.ENDS

************************************************************************
* Library Name: experiments
* Cell Name:    nor_2
* View Name:    schematic
************************************************************************

.SUBCKT nor_2 A B GND VDD Y
*.PININFO A:B B:B GND:B VDD:B Y:B
MNM1 Y B GND GND nch_tn W=390n L=180n m=1
MNM0 Y A GND GND nch_tn W=390n L=180n m=1
MPM1 net12 B VDD VDD pch_tn W=3.12u L=180n m=1
MPM0 Y A net12 VDD pch_tn W=3.12u L=180n m=1
.ENDS

************************************************************************
* Library Name: experiments
* Cell Name:    PG_generate
* View Name:    schematic
************************************************************************

.SUBCKT PG_generate GFJI GKI GKJ GND PFJI PKI PKJ VDD
*.PININFO GFJI:B GKI:B GKJ:B GND:B PFJI:B PKI:B PKJ:B VDD:B
XI1 PFJI PKJ GND VDD net24 / nand_2
XI0 PKJ GFJI GND VDD net25 / nand_2
XI5 net23 GND VDD GKI / inv
XI3 net24 GND VDD PKI / inv
XI2 net25 GND VDD net26 / inv
XI4 net26 GKJ GND VDD net23 / nor_2
.ENDS

************************************************************************
* Library Name: experiments
* Cell Name:    G_generate
* View Name:    schematic
************************************************************************

.SUBCKT G_generate GFJI GKI GKJ GND PKJ VDD
*.PININFO GFJI:B GKI:B GKJ:B GND:B PKJ:B VDD:B
XI0 net11 GKJ GND VDD net16 / nor_2
XI2 net17 GND VDD net11 / inv
XI1 net16 GND VDD GKI / inv
XI3 GFJI PKJ GND VDD net17 / nand_2
.ENDS

************************************************************************
* Library Name: experiments
* Cell Name:    inv_2d
* View Name:    schematic
************************************************************************

.SUBCKT inv_2d A GND VDD Y
*.PININFO A:B GND:B VDD:B Y:B
MNM0 Y A GND GND nch_tn W=780n L=180n m=1
MPM0 Y A VDD VDD pch_tn W=3.12u L=180n m=1
.ENDS

************************************************************************
* Library Name: experiments
* Cell Name:    inv_H
* View Name:    schematic
************************************************************************

.SUBCKT inv_H A GND VDD Y
*.PININFO A:B GND:B VDD:B Y:B
MNM0 Y A GND GND nch_tn W=490n L=180n m=1
MPM0 Y A VDD VDD pch_tn W=1.96u L=180n m=1
.ENDS

************************************************************************
* Library Name: experiments
* Cell Name:    D_flipflop1
* View Name:    schematic
************************************************************************

.SUBCKT D_flipflop1 CLK D GND Q Q_B RST VDD
*.PININFO CLK:B D:B GND:B Q:B Q_B:B RST:B VDD:B
MPM4 net05 CLK_B net07 VDD pch_tn W=390n L=180n m=1
MPM2 net5 CLK_B net8 VDD pch_tn W=390n L=180n m=1
MPM0 net13 CLK net8 VDD pch_tn W=390n L=180n m=1
MPM5 net027 CLK net07 VDD pch_tn W=390n L=180n m=1
XI7 D RST GND VDD net13 / nand_2
MNM4 net05 CLK net07 GND nch_tn W=390n L=180n m=1
MNM0 net13 CLK_B net8 GND nch_tn W=390n L=180n m=1
MNM5 net027 CLK_B net07 GND nch_tn W=390n L=180n m=1
MNM1 net5 CLK net8 GND nch_tn W=390n L=180n m=1
XI13 net07 GND VDD Q_B / inv
XI12 net028 GND VDD Q / inv
XI9 net05 GND VDD net5 / inv
XI11 net028 GND VDD net027 / inv
XI4 CLK GND VDD CLK_B / inv
XI8 net8 GND VDD net05 / inv_H
XI10 net07 GND VDD net028 / inv_H
.ENDS

************************************************************************
* Library Name: experiments
* Cell Name:    D_flipflop_inv
* View Name:    schematic
************************************************************************

.SUBCKT D_flipflop_inv CLK_B D GND Q Q_B RST VDD
*.PININFO CLK_B:B D:B GND:B Q:B Q_B:B RST:B VDD:B
XI15 CLK_B GND VDD net3 / inv
XI14 net3 D GND Q Q_B RST VDD / D_flipflop1
.ENDS

************************************************************************
* Library Name: experiments
* Cell Name:    add_tree1
* View Name:    schematic
************************************************************************

.SUBCKT add_tree1 A1 A2 A3 A4 A5 A6 A7 A8 B1 B2 B3 B4 B5 B6 B7 B8 C0 C9 C9Q 
+ C9QB CLK CLKB_1 CLKB_2 CLKB_3 CLKB_4 G1 G2 G3 G3_2 G4 G5 G5_4 G6 G7 G7_4 
+ G7_6 G8 GND P1 P2 P3 P3_2 P4 P5 P5_4 P6 P7 P7_4 P7_6 P8 RST S1 S1Q S1QB S2 
+ S2Q S2QB S3 S3Q S3QB S4 S4Q S4QB S5 S5Q S5QB S6 S6Q S6QB S7 S7Q S7QB S8 S8Q 
+ S8QB VDD
*.PININFO A1:B A2:B A3:B A4:B A5:B A6:B A7:B A8:B B1:B B2:B B3:B B4:B B5:B 
*.PININFO B6:B B7:B B8:B C0:B C9:B C9Q:B C9QB:B CLK:B CLKB_1:B CLKB_2:B 
*.PININFO CLKB_3:B CLKB_4:B G1:B G2:B G3:B G3_2:B G4:B G5:B G5_4:B G6:B G7:B 
*.PININFO G7_4:B G7_6:B G8:B GND:B P1:B P2:B P3:B P3_2:B P4:B P5:B P5_4:B P6:B 
*.PININFO P7:B P7_4:B P7_6:B P8:B RST:B S1:B S1Q:B S1QB:B S2:B S2Q:B S2QB:B 
*.PININFO S3:B S3Q:B S3QB:B S4:B S4Q:B S4QB:B S5:B S5Q:B S5QB:B S6:B S6Q:B 
*.PININFO S6QB:B S7:B S7Q:B S7QB:B S8:B S8Q:B S8QB:B VDD:B
XI62 B8 A8 GND VDD net065 / nand_2
XI7 B7 A7 GND VDD net19 / nand_2
XI6 B6 A6 GND VDD net20 / nand_2
XI5 B5 A5 GND VDD net21 / nand_2
XI4 B4 A4 GND VDD net22 / nand_2
XI3 B3 A3 GND VDD net23 / nand_2
XI2 B2 A2 GND VDD net24 / nand_2
XI1 B1 A1 GND VDD net25 / nand_2
XI63 net065 GND VDD G8 / inv
XI14 net19 GND VDD G7 / inv
XI13 net20 GND VDD G6 / inv
XI12 net21 GND VDD G5 / inv
XI11 net22 GND VDD G4 / inv
XI10 net23 GND VDD G3 / inv
XI9 net24 GND VDD G2 / inv
XI8 net25 GND VDD G1 / inv
XI65 C8 P8 GND VDD S8 / xnor_v2
XI64 B8 A8 GND VDD P8 / xnor_v2
XI45 C0 P1 GND VDD S1 / xnor_v2
XI44 C2 P2 GND VDD S2 / xnor_v2
XI43 C3 P3 GND VDD S3 / xnor_v2
XI38 C7 P7 GND VDD S7 / xnor_v2
XI40 C6 P6 GND VDD S6 / xnor_v2
XI42 C4 P4 GND VDD S4 / xnor_v2
XI41 C5 P5 GND VDD S5 / xnor_v2
XI21 B7 A7 GND VDD P7 / xnor_v2
XI20 B6 A6 GND VDD P6 / xnor_v2
XI19 B5 A5 GND VDD P5 / xnor_v2
XI18 B4 A4 GND VDD P4 / xnor_v2
XI17 B3 A3 GND VDD P3 / xnor_v2
XI16 B2 A2 GND VDD P2 / xnor_v2
XI15 B1 A1 GND VDD P1 / xnor_v2
XI25 G5_4 G7_4 G7_6 GND P5_4 P7_4 P7_6 VDD / PG_generate
XI24 G2 G3_2 G3 GND P2 P3_2 P3 VDD / PG_generate
XI23 G4 G5_4 G5 GND P4 P5_4 P5 VDD / PG_generate
XI22 G6 G7_6 G7 GND P6 P7_6 P7 VDD / PG_generate
XI61 C8 C9 G8 GND P8 VDD / G_generate
XI51 C6 C7 G6 GND P6 VDD / G_generate
XI49 C4 C5 G4 GND P4 VDD / G_generate
XI50 C4 C6 G5_4 GND P5_4 VDD / G_generate
XI46 C2 C3 G2 GND P2 VDD / G_generate
XI36 C2 C4 G3_2 GND P3_2 VDD / G_generate
XI35 C0 C2 G1 GND P1 VDD / G_generate
XI37 C4 C8 G7_4 GND P7_4 VDD / G_generate
XI70 CLK GND VDD CLKB_2 / inv_2d
XI71 CLK GND VDD CLKB_3 / inv_2d
XI72 CLK GND VDD CLKB_4 / inv_2d
XI66 CLK GND VDD CLKB_1 / inv_2d
XI60 CLKB_4 C9 GND C9Q C9QB RST VDD / D_flipflop_inv
XI59 CLKB_4 S8 GND S8Q S8QB RST VDD / D_flipflop_inv
XI58 CLKB_1 S7 GND S7Q S7QB RST VDD / D_flipflop_inv
XI57 CLKB_1 S6 GND S6Q S6QB RST VDD / D_flipflop_inv
XI56 CLKB_3 S5 GND S5Q S5QB RST VDD / D_flipflop_inv
XI55 CLKB_3 S4 GND S4Q S4QB RST VDD / D_flipflop_inv
XI54 CLKB_2 S3 GND S3Q S3QB RST VDD / D_flipflop_inv
XI53 CLKB_4 S2 GND S2Q S2QB RST VDD / D_flipflop_inv
XI52 CLKB_2 S1 GND S1Q S1QB RST VDD / D_flipflop_inv
.ENDS
.vec "add_A.vec"
VA1 A1 vina[0]
VA2 A2 vina[1]
VA3 A3 vina[2]
VA4 A4 vina[3]
VA5 A5 vina[4]
VA6 A6 vina[5]
VA7 A7 vina[6]
VA8 A8 vina[7]
VC0 C0 vina[8]
.vec "add_B.vec"
VB1 B1 vinb[0]
VB2 B2 vinb[1]
VB3 B3 vinb[2]
VB4 B4 vinb[3]
VB5 B5 vinb[4]
VB6 B6 vinb[5]
VB7 B7 vinb[6]
VB8 B8 vinb[7]
VCLK CLK 0 pwl(0ns 0 44ns 0 44.1ns 0.54 88ns 0.54 88.1ns 0 r)
Xadd_tree1 A1 A2 A3 A4 A5 A6 A7 A8 B1 B2 B3 B4 B5 B6 B7 B8 C0 C9 C9Q 
+ C9QB CLK CLKB_1 CLKB_2 CLKB_3 CLKB_4 G1 G2 G3 G3_2 G4 G5 G5_4 G6 G7 G7_4 
+ G7_6 G8 GND P1 P2 P3 P3_2 P4 P5 P5_4 P6 P7 P7_4 P7_6 P8 RST S1 S1Q S1QB S2 
+ S2Q S2QB S3 S3Q S3QB S4 S4Q S4QB S5 S5Q S5QB S6 S6Q S6QB S7 S7Q S7QB S8 S8Q 
+ S8QB VDD add_tree1
.tran 1ps 2500ns 
.MEASURE TRAN t_7 \
  TRIG V(A8) VAL='0.6V' FALL=1  \
  TARG V(S7) VAL='0.6V' FALL=1
.MEASURE TRAN t_8 \
  TRIG V(A8) VAL='0.6V' RISE=1 \
  TARG V(S8) VAL='0.6V' RISE=1
.MEASURE TRAN Pavg_rise AVG power from=600.11ns to=600.70ns
.MEASURE TRAN Pavg_down AVG power from=200.12ns to=200.32ns
.end
