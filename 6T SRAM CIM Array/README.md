# 6T SRAM Compute-in-Memory Array with Event-Driven Adaptive Write-Back Control
 
## 1. Introduction
Compute-in-Memory (CIM) architectures based on SRAM have attracted significant attention for alleviating the memory wall and improving energy efficiency in data-intensive applications. However, under low-voltage operation, conventional 6T SRAM cells often suffer from write failure, caused by reduced write margin, insufficient bitline swing, and weakened cell flipping capability. These issues become more pronounced in CIM scenarios, where frequent write-back operations are required after in-memory computation.
This project proposes an event-driven adaptive write-back CIM architecture based on standard 6T SRAM cells. By integrating write failure sensing, conditional write-assist, and result monitoring mechanisms into the SRAM array, the proposed design enables reliable write-back under low-voltage conditions without introducing complex global timing control. The architecture allows the system to converge from write failure to reliable write-back in a controlled and energy-efficient manner.

## 2. Overall Architecture
The proposed architecture is centered on a 6T SRAM array and its peripheral circuits, as shown in Fig. 1. The design augments a conventional SRAM-based CIM structure with adaptive control and monitoring logic.
The main functional components include:
6T SRAM cell array
Wordline decoder and bitline precharge circuits
Sense amplifiers (SA) for read operations
Write Failure Sense Circuit (WFSC)
Normal write driver and Negative Bitline (NBL) write-assist path
Comparator logic, OR-gate array, latches, and counters
CIM computation modules integrated at the array level
These modules cooperate to detect potential write failures, adaptively select write paths, and generate explicit write-back success or failure indications.

## 3. SRAM Cell and Array Design
The design is based on a conventional 6T SRAM cell, implemented and verified at the transistor level using a 180 nm CMOS process. The basic storage, read, and write mechanisms of the cell are analyzed under reduced supply voltage conditions.
To evaluate cell reliability, Static Noise Margin (SNM) analysis is performed, including:
Hold SNM
Read SNM
Write SNM
Butterfly curves are generated to quantitatively assess cell stability and write capability in the near-threshold voltage region. The results confirm that the designed cell maintains acceptable read and write reliability under low-voltage operation.
Based on the validated cell, an SRAM array is constructed together with its peripheral circuits, including wordline decoding, bitline precharge and equalization, and read/write control logic, enabling stable access during both memory and CIM operations.

## 4. Write Failure Sense Circuit (WFSC)
Under low-voltage conditions, the effective write window of SRAM cells is significantly reduced, and conventional write drivers may fail to induce a successful state transition.
To address this issue, a Write Failure Sense Circuit (WFSC) is introduced. The WFSC monitors the bitline voltage evolution and temporal response during the write phase. By exploiting both voltage-level characteristics and timing behavior, the WFSC performs an early-stage judgment on whether the current write operation is likely to succeed.
This early detection mechanism allows the system to identify potential write failures before the write cycle completes, avoiding unnecessary delay and redundant energy consumption.

## 5. Adaptive Write-Assist with Negative Bitline (NBL)
When the WFSC indicates that a normal write operation is insufficient, the control logic adaptively activates a Negative Bitline (NBL) write-assist path.
The NBL mechanism enhances write ability by introducing a negative voltage swing on the bitline, thereby increasing the internal voltage differential of the cross-coupled inverters and strengthening the flipping capability of the SRAM cell.
Importantly, the write-assist path is conditionally enabled. Under normal operating conditions, the system relies on the conventional write driver to minimize power consumption. Write assistance is only applied when a write failure event is detected, achieving a dynamic trade-off between write reliability and energy efficiency.

## 6. Write-Back Verification and Failure Monitoring
To ensure the correctness of CIM write-back results, a post-write consistency verification mechanism is employed.
After each write operation:
The stored value is read out through the standard read path.
The read data is compared with the expected write value.
A write success or failure decision is generated.
In this architecture, the normal write driver and the NBL-assisted write path operate within the same write cycle. Therefore, a detected write failure indicates that, under the current supply voltage and timing window, the SRAM cell cannot be reliably flipped even with write assistance.
To avoid repeated ineffective write attempts, the control logic generates a CIM write failure flag and records failure events using latches and counters. These explicit indicators can be used by higher-level strategies such as voltage scaling, frequency throttling, memory remapping, or fault-tolerant computation.

## 7. Simulation and Verification
The proposed architecture is verified through transistor-level simulations using HSPICE. The verification flow includes:
SRAM read/write functional simulation
SNM butterfly curve extraction
Bitline voltage waveform analysis
Write failure detection timing validation
Adaptive write-assist activation behavior
Simulation results demonstrate that the proposed event-driven mechanism effectively improves write robustness under low-voltage conditions, while limiting write-assist activation to failure-critical cases.

## 8. Key Contributions
An event-driven adaptive write-back CIM architecture based on standard 6T SRAM cells
Integration of write failure sensing (WFSC) at the array level
Conditional activation of negative bitline write-assist without complex global timing control
Explicit write-back verification and failure signaling for CIM operations
A scalable framework suitable for voltage-aware and energy-efficient memory-centric computing systems

## 9. Applicability and Extension
The proposed architecture is compatible with standard CMOS SRAM design flows and can be extended to:
Larger array sizes
Advanced CMOS technology nodes
Variation- and aging-aware write reliability analysis
System-level voltage and frequency adaptation policies

### Author and Contribution
This project was completed as an independent undergraduate research project.
All architecture design, circuit implementation, control logic, and transistor-level simulations were carried out individually.
