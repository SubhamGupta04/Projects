# 🔁 Sequence Detector (1001) using Mealy FSM – Verilog HDL

## 📘 Project Overview
This project implements a **Mealy-type Finite State Machine (FSM)** to detect
the binary sequence **1001** in a serial input stream.
The design is written in **Verilog HDL** and is fully synthesizable for FPGA implementation.

The output is asserted **immediately when the sequence is detected**, making
this a **Mealy FSM**.

---

## ⚙️ Features
- Detects binary sequence **1001**
- Mealy FSM implementation
- Overlapping sequence detection supported
- Asynchronous reset
- FPGA synthesizable
- Clean and modular Verilog design

---

## 🧠 FSM Description

### 🔹 States
| State | Meaning |
|------|--------|
| `s0` | Initial state / No match |
| `s1` | Detected `1` |
| `s2` | Detected `10` |
| `s3` | Detected `100` |

---

### 🔹 State Transitions
- `s0` → `s1` on input `1`
- `s1` → `s2` on input `0`
- `s2` → `s3` on input `0`
- `s3` → Output `1` on input `1` (sequence detected)

Overlapping detection is supported by transitioning back to `s1`.

## 📊 Simulation Waveform

The waveform below shows the detection of the sequence **1001**.
The output `out` goes HIGH when the final `1` is received.

![Sequence Detector 1001 Waveform](Waveform.png)


---

## 🧪 Module Description

### 🔹 `Sequence_1001.v`

**Inputs**
- `clk`   : Clock signal
- `reset` : Asynchronous reset (active high)
- `x`     : Serial input bit stream

**Output**
- `out`   : Goes HIGH when sequence `1001` is detected

---

## ▶️ Timing Behavior
- Output `out` is asserted **during the same clock cycle** as the final `1`
- Reset forces the FSM to the initial state `s0`

---

## 🧪 Tools Used
- Verilog HDL
- Vivado Design Suite
- Artix-7 FPGA (or any FPGA supporting Verilog)

---

## ▶️ How to Simulate
1. Open **Vivado**
2. Create a new RTL project
3. Add `Sequence_1001.v`
4. Write a testbench to apply serial input
5. Run behavioral simulation

---

## 📌 Author
**Subham Gupta**

---

## 📄 License
This project is intended for **educational and learning purposes**.






