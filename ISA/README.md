# RISCV 32I ISA
# Instruction Set
[Cheatsheet](https://metalcode.eu/2019-12-06-rv32i.html)
## Instruction Types
## R-Type:
<img src="https://user-images.githubusercontent.com/64090140/128345216-d2e45938-e469-4e6f-a6e7-376a4aa1a532.png" width="600" height="400">
## Encoding:
<img src="https://user-images.githubusercontent.com/64090140/128345231-674f0973-8c7a-4900-8c3a-3d5885acef31.png" width="600" height="400">
## I-Type:
<img src="https://user-images.githubusercontent.com/64090140/128345254-df5a5c25-5584-4c56-a8b4-bed605905746.png" width="600" height="400">
## Encoding:
<img src="https://user-images.githubusercontent.com/64090140/128345269-3562415e-f6ba-4cb6-9c3e-5f07220530e7.png" width="600" height="400">
## Load & Store:
<img src="https://user-images.githubusercontent.com/64090140/128345557-94bd2f50-e3ed-41a2-81c9-232951544eb1.png" width="600" height="400">
<img src="https://user-images.githubusercontent.com/64090140/128345289-110ec3d8-0d40-4338-bd2c-bbb762fd55fe.png" width="600" height="400">
<img src="https://user-images.githubusercontent.com/64090140/128345304-ffcf225e-4dd8-4119-9d22-d6e8f1582dfa.png" width="600" height="400">
## Encoding: 
<img src="https://user-images.githubusercontent.com/64090140/128345324-600a2fee-cdf7-450a-aaf2-a7cf4fe2f7c6.png" width="600" height="400">
## Branch Instructions:
<img src="https://user-images.githubusercontent.com/64090140/128346224-39f39311-ce13-4fe6-a677-1a404024d9d9.png" width="600" height="400">
<img src="https://user-images.githubusercontent.com/64090140/128346243-8b88da4f-0e81-45e3-8375-8b899192a229.png" width="600" height="400">
<img src="https://user-images.githubusercontent.com/64090140/128346251-f438027c-b899-4d9b-9e6a-b638327d2abe.png" width="600" height="400">
# Register Usage Convention
<img src="https://user-images.githubusercontent.com/64090140/128346296-49414bf1-84cb-4406-8b57-fa3e98bbb179.png" width="600" height="400">

[Source](http://users.ece.cmu.edu/~jhoe/course/ece447/S18handouts/L02.pdf)
## Summary
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

