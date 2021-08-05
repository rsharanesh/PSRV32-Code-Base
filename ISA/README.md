# RISCV 32I ISA
# Instruction Set
## Instruction Types
### R-Type:

#### Encoding:

### I-Type:

#### Encoding:


## Formats
![Istrs](https://user-images.githubusercontent.com/64090140/128318173-e354d16f-8bcb-4891-849f-ed9240e2be84.png)
[Reference](https://passlab.github.io/CSCE513/notes/lecture04_RISCV_ISA.pdf)
* R-type: register-register        
* I-type: short immediates and loads            
* S-type: stores           
* B-type: conditional branches, a variation of S-type            
* U-type: long immediates          
* J-type: unconditional jumps, a variation of U-type        
#### Notes
- RV32I (consisting of 32 Registers) has X0 Register hardwired to constant 0 and X1-X31 General Purpose Registers. All Registers are 32 bits wide.
- RV32I is a load-store architecture. This means that only load and store instructions access memory; arithmetic operations use only the registers. 

