# RISCV 32I ISA
# Instruction Set
## Instruction Types
### R-Type:
![r](https://user-images.githubusercontent.com/64090140/128345216-d2e45938-e469-4e6f-a6e7-376a4aa1a532.png)
#### Encoding:
![ren](https://user-images.githubusercontent.com/64090140/128345231-674f0973-8c7a-4900-8c3a-3d5885acef31.png)
### I-Type:
![i ](https://user-images.githubusercontent.com/64090140/128345254-df5a5c25-5584-4c56-a8b4-bed605905746.png)
#### Encoding:
![ien](https://user-images.githubusercontent.com/64090140/128345269-3562415e-f6ba-4cb6-9c3e-5f07220530e7.png)
### Load & Store:
![ld](https://user-images.githubusercontent.com/64090140/128345289-110ec3d8-0d40-4338-bd2c-bbb762fd55fe.png)
![st](https://user-images.githubusercontent.com/64090140/128345304-ffcf225e-4dd8-4119-9d22-d6e8f1582dfa.png)
#### Encoding: 
![lsen](https://user-images.githubusercontent.com/64090140/128345324-600a2fee-cdf7-450a-aaf2-a7cf4fe2f7c6.png)



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

