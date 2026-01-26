# IC Design Project Portfolio

This repository serves as a technical portfolio documenting a set of
**independent integrated circuit and digital system design projects**
completed during my undergraduate studies in **Electronic Information Engineering**.

All projects were developed individually and focus on **digital IC design,
memory circuits, compute-in-memory (CIM) architectures, and FPGA-based
system integration**.  
The repository is organized as an engineering archive rather than a
software package, preserving design files, simulation artifacts, and
design evolution records.

---

## Repository Structure

Each project is maintained in a dedicated folder and typically includes:

- `src/` – circuit netlists or RTL source files  
- `sim/` – simulation waveforms and logs  
- `archive/early_version/` – deprecated or exploratory design versions  
- `README.md` – technical description of the project  
- supplementary documentation and figures  

A lightweight web-based overview (`index.html`) is also provided for
high-level navigation and presentation.

---

## Project Overview

### **Project 01 – 6T SRAM Compute-in-Memory Array**  
🔗 **[View Project →](./6T%20SRAM%20CIM%20Array/)**

- SRAM-based Compute-in-Memory (CIM) architecture under low-voltage operation  
- Adaptive write-back control with write failure sensing and conditional write-assist  
- Transistor-level simulation using HSPICE  
- Static Noise Margin (SNM) analysis and array-level verification  
- Design evolution documented through archived early implementations  

This project forms the core of my bachelor thesis and focuses on
**write reliability and energy-aware control in SRAM CIM systems**.

---

### **Project 02 – Dual-UART Asynchronous Bridge**

- Multi-baud UART bridge (9600 / 115200) with FIFO buffering  
- Dynamic channel switching based on frame detection and timeout  
- Cross-clock-domain (CDC) handling  
- Pre-synthesis, post-synthesis, and FPGA on-board verification  

---

### **Project 03 – Reusable Digital IP Library**

- Parameterized Verilog IP cores for SoC development  
- Interfaces and modules including:
  - UART, SPI, I²C, AXI-Lite
  - HDMI timing generator
  - FIFO, decoders, edge detectors, LED controllers  
- Each module accompanied by simulation testbenches  

---

### **Project 04 – Full-Custom 8-bit Tree Adder**

- Full-custom CMOS implementation of an 8-bit tree-structured adder  
- Transistor-level gate characterization  
- Manual layout using Cadence Virtuoso  
- DRC / LVS / PEX verification with Calibre  
- Post-layout timing and power analysis under PVT corners  

---

## Notes on Authenticity and Design Methodology

This repository reflects **realistic IC design workflows**:

- Projects were not developed using incremental git-based flows  
- Multiple design iterations, including failed or deprecated versions,
  are preserved for traceability  
- Simulation waveforms, netlists, and logs are included as primary
  verification evidence  

The emphasis is placed on **design reasoning, verification, and
architecture-level decisions**, rather than on code polish or automation.

---

## Author

Independent undergraduate project portfolio  
All projects were designed, implemented, and verified individually.
