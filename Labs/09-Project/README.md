# Projekt ALU
ALU neboli aritmetická a logická jednotka "Arithmetic & Logic Unit". Bez jeho implementace se v dnešní době neobejde žádný mikroprocesor. Je to fundament moderních počítačů, takový matematický mozek. Vnitřní stavba je ze dvou "subbloků", jeden se stará o aritmetické operace a druhá se stará o operace logické.

Aritmetické operace jsou např.: sčítání, odčítání, +1 = increment, -1 = decrement, převod kladného na záporné, 'pass through', některé provedou i násobení a dělení, apod. 

Logické operace jsou např.: NOT, AND, OR, XOR, clear operation, apod.

## Obrázky
<img src="Images/ALU.png" alt="ALU-sign" height="300"/>
Tady můžeme vidět schématickou značku. Nahoře se nachází dva vstupy označené Operand 1 & 2. Jedná se o N bitové vstupy dvou čísel. Dále je na spodu jeden N bitový výstup. Po stranách je vstup OPCODE. Tento vstup je kritický, protože díky jeho hodnotě se volí jaká operace se provede s operandy na vstupech. V některých implementacích má M+1 bitů, kdy "+1" je MSB a rozhoduje, zda zbylé M bity svou hodnotou budou odpovídat "knihovně" s aritmetickými operacemi nebo logickými např. '0100' odpovída aritmetické operaci pro sčítání obou operand & '1100' odpovídá logické operaci XOR. 
<img src="Images/csc1401-lecture03-computer-arithmetic-arithmetic-and-logic-unit-alu-5-638.jpg" alt="ALU_colored" height="300"/>


### Hardware

* 
* 
* 

### Software

* ISE Design, ISE WebPACK Design Software, ver 14.7: [web page](https://www.xilinx.com/products/design-tools/ise-design-suite/ise-webpack.html), [installation](https://github.com/tomas-fryza/Digital-electronics-1/wiki)
* Linux Mint 18.2 "Sonya" - Xfce (64-bit): [web page](https://linuxmint.com/download_all.php)

<img src="Images/coolrunner_board.jpg" alt="CoolRunner-II board" height="300"/> <img src="Images/ise_synthesize_org.png" alt="ISE" height="300"/>

