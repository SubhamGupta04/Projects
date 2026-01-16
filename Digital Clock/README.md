# ⏰ Digital Clock Implementation on Artix-7 FPGA

## 📘 Project Overview
This project implements a **Digital Clock (HH:MM:SS)** using **Verilog HDL**
on an **Artix-7 FPGA board (50 MHz system clock)**.  
The clock displays **hours, minutes, and seconds** on a **multiplexed 7-segment display**.

A **clock divider** is used to generate a **1 Hz clock** for time counting and a
higher-frequency clock for **7-segment display refreshing**.

---

## ⚙️ Features
- Real-time digital clock (HH:MM:SS)
- 24-hour format
- 1 Hz accurate time base
- Time-multiplexed 7-segment display
- Reset support
- Modular and synthesizable Verilog design
- Artix-7 FPGA compatible

---

## 🧠 Module Description

### 🔹 `top.v`
Top-level module that connects all submodules.

**Inputs**
- `clk` : 50 MHz FPGA clock
- `rst` : Active-high reset

**Outputs**
- `seg [7:0]` : 7-segment data lines
- `an [3:0]`  : Digit enable (anode/cathode control)

---

### 🔹 `clock_divider.v`
Divides the 50 MHz system clock to generate:
- `clk_1hz`    → Used for second counting
- `clk_refresh` → Used for display multiplexing

---

### 🔹 `time_counter.v`
Maintains time values:
- Seconds (0–59)
- Minutes (0–59)
- Hours (0–23)

Handles rollover logic correctly.

---

### 🔹 `seven_seg_driver.v`
- Converts BCD digits to 7-segment codes
- Handles display multiplexing
- Ensures flicker-free display

---

## 🧩 Block Diagram (Conceptual)

