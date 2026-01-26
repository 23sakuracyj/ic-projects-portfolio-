# IC Design Project Portfolio

This repository is a technical portfolio documenting a set of
**independent integrated circuit and digital system design projects**
completed during my undergraduate studies in **Electronic Information Engineering**.

All projects were developed individually and focus on **integrated circuit
design at transistor, RTL, and system levels**, including memory circuits,
compute-in-memory (CIM) architectures, full-custom CMOS design, and FPGA-based
system integration.

Rather than a software-oriented repository, this project is organized as an
**engineering archive**, preserving design files, simulation results, physical
verification artifacts, and documented design evolution.

---

## Repository Structure

Each project is maintained in a dedicated folder and typically includes:

- `src/` – circuit netlists, RTL, or schematic-related files  
- `sim/` – simulation waveforms, logs, and test results  
- `archive/early_version/` – deprecated or exploratory design iterations  
- `README.md` – detailed technical documentation  
- supplementary figures, layouts, and verification evidence  

A lightweight web-based overview (`index.html`) is also provided for
high-level navigation and presentation.

---

## Project Overview

### **Project 01 – 6T SRAM Compute-in-Memory Array**  
🔗 **[View Project →](./6T%20SRAM%20CIM%20Array/)**

- SRAM-based Compute-in-Memory (CIM) architecture targeting low-voltage operation  
- Event-driven adaptive write-back control with write failure sensing (WFSC)  
- Conditional negative bitline (NBL) write-assist mechanism  
- Transistor-level simulation using HSPICE  
- Static Noise Margin (SNM) analysis and array-level verification  
- Design evolution documented through archived early implementations  

This project forms the core of my bachelor thesis and focuses on
**write reliability, energy efficiency, and control convergence in SRAM CIM systems**.

---

### **Project 02 – 8-bit Brent–Kung Prefix Adder (Full-Custom CMOS)**  
🔗 **[View Project →](./8-bit%20Brent–Kung%20Prefix%20Adder/)**

- Full-custom CMOS implementation of an 8-bit prefix adder  
- Brent–Kung tree structure for parallel carry computation  
- Transistor-level gate design and characterization  
- Manual layout using Cadence Virtuoso  
- DRC / LVS / PEX verification with Calibre  
- Pre-layout and post-layout timing and power analysis  

This project demonstrates **full-custom digital IC design capability** from
schematic to post-layout verification.

---

### **Project 03 – AXI-Lite SPI Virtual EEPROM Controller**  
🔗 **[View Project →](./AXI-Lite%20SPI%20Virtual%20EEPROM%20Controller/)**

- AXI-Lite–controlled SPI master with virtual EEPROM device  
- FIFO-based continuous read/write without AXI burst transactions  
- Custom AXI register interface and control FSM  
- Pure Verilog implementation (except PLL / ROM IPs)  
- Pre-synthesis simulation and FPGA on-board verification  
- Archived standalone master/slave test versions for design traceability  

This project highlights **digital system integration, protocol design,
and SoC-oriented control logic**.

---

### **Project 04 – Two-Stage CMOS Operational Amplifier**  
🔗 **[View Project →](./Two-Stage%20CMOS%20Operational%20Amplifier/)**

- Classical two-stage CMOS operational amplifier design  
- Differential input stage with current-mirror load  
- Miller compensation for closed-loop stability  
- Schematic-driven design and simulation using Cadence Spectre  
- Full-custom layout with DRC / LVS verification  
- AC, transient, CMRR, and PSRR analysis  

This project demonstrates **analog IC design methodology and physical
implementation discipline**.

---

## Notes on Authenticity and Design Methodology

This repository reflects **realistic IC design workflows**:

- Projects were not developed using incremental git-based software flows  
- Multiple design iterations, including failed or deprecated versions,
  are preserved to document design evolution  
- Simulation waveforms, layout screenshots, and verification results
  serve as primary evidence of design validity  

The emphasis is placed on **design reasoning, verification rigor,
and architecture-level decision-making**, rather than on code volume
or automation.

---

## Author

Independent undergraduate project portfolio  
All projects were **designed, implemented, and verified individually**.
