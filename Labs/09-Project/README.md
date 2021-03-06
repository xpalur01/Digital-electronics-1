# Projekt ALU
## Teoretický úvod
ALU neboli aritmetická a logická jednotka "Arithmetic & Logic Unit". Bez jeho implementace se v dnešní době neobejde žádný mikroprocesor. Je to fundament moderních počítačů, takový matematický mozek. Vnitřní stavba je ze dvou "sub-bloků", jeden se stará o aritmetické operace a druhý se stará o operace logické.

Aritmetické operace jsou např.: sčítání, odčítání, +1 = increment, -1 = decrement, převod kladného na záporné, 'pass through', některé provedou i násobení a dělení, apod. 

Logické operace jsou např.: NOT, AND, OR, XOR, clear operation, apod.

## Obrázky & Schémata 
<img src="Images/ALU.png" alt="ALU-sign" height="300"/>

###### Obrázek 1 Schéma Aritmetickologické jednotky (popis pod obrázkem)
Tady můžeme na obrázku 1 vidět schématickou značku. Nahoře se nachází dva vstupy označené Operand 1 & 2. Jedná se o N bitové vstupy dvou čísel. Dále je na spodu jeden N bitový výstup. Po stranách je vstup OPCODE. Tento vstup je kritický, protože díky jeho hodnotě se volí jaká operace se provede s operandy na vstupech. V některých implementacích má M+1 bitů, kdy "+1" je MSB a rozhoduje, zda zbylé M bity svou hodnotou budou odpovídat "knihovně" s aritmetickými operacemi nebo logickými např. '0100' odpovída aritmetické operaci pro sčítání obou operand & '1100' odpovídá logické operaci XOR. To jakou operaci to provede záleží čistě na nastavení čipu popřípadě programu.
Také vidíme jeden status výstup. Ten v různých případech plní různé funkce. Může se v něm nacházet výstup carry_out, popřípadě signalizace na led při záporném výsledku, overflow flag nebo nulový výstup.

<img src="Images/csc1401-lecture03-computer-arithmetic-arithmetic-and-logic-unit-alu-5-638.jpg" alt="ALU_colored" height="300"/>

###### Obrázek 2 Schéma Aritmetickologické jednotky (popisek je pod obrázkem)
Tady je vidět jiná obrazová intepretace, ale ve výsledku je to to samé. Vidíme vstup, výstup, flagy neboli status výstup a control signal.

<img src="Images/ALU%2074181.png" alt="ALU-74181" height="300"/>

###### Obrázek 3 IC Aritmetickologické jednotky 74181 (popisek je pod obrázkem)
Příklad ALU 74181, blokové schéma je uvedeno na obrázku 3, vykonává se dvěma čtyřbitovými operandy A a B 16 aritmetických operací a 16 logických operací ve dvojkové soustavě. Obvod provádí např. aritmetické operace: sčítání, odčítání, přičtení jedničky, dvojkový doplněk, posuv o 1 místo vlevo, porovnání obou čísel a další. Dále obvod vykonává logické operace: logický součet, logický součin, dále funkce NAND, NOR, NOT, ekvivalenci a nonekvivalencí a další. Výběr operací je prováděn pomocí řídicích vstupů S0 až S3. Bit M určuje typ prováděné operace. Pro M = 1 provádí obvod logické operace a pro M = 0 provádí aritmetické operace. Kromě toho je druh operace závislý na hodnotě přenosu z nižšího řádu Cn. Je-li třeba zpracovávat data s více než 4 bity, mohou se obvody ALU 74181 řadit do série. Aby se přitom nezpomaloval výpočet v důsledku zpoždění šíření přenosu aritmetickými jednotkami, používá se speciální integrovaný obvod pro zrychlení šíření přenosu s označením 74182. Zapojení čtyř ALU jednotek pro délku operandů 16 bitů se zapojením obvodu pro zrychlení přenosu je znázorněno na dalším obrázku 4. Označení CLA značí "Carry Look-Ahead".

<img src="Images/ALU%2074181_2.png" alt="ALU-74181" height="300"/>

###### Obrázek 4 IC Aritmetickologické jednotky 74181 (popisek je nad obrázkem)

### Teoretická příprava
Důležitou součástí vypracování projektu je teoretické usmyslení "co to vlastně udělám, jak to udělám...atd.". 
Proto by jsem si první měl odpovědět na několik otázek:

* Kolik bitů budou mít operandy A & B?
    -tady záleží čistě na potřebách, modernější implementace se mohou pohybovat na 32 bitech, jiné na 16 nebo osmi. Pro naše účely, kdy na CPLD boardu se nachází 8+8 switchů, použiji pro vstup 4 & 4 bity.
* Kolik bitů bude mít výstup?
    -nejčastěji se odvíjí od velikosti vstupních bitů. Teoreticky by šel navýšit klidně i o +1 za předpokladu že chceme mít carry out součástí čísla výstupu.
* Kolik bitů bude mít kontrolní signál?
    -odvíjí se od toho, kolik operací chceme provádět pro 2 bity máme možnost aplikovat 4 různé operace, pro 3 bity 8, pro 4 bity 16 operací. Já jsem se rozhodnul pro 4 bitový kontrolní vstup, jelikož bych rád ukázal na 16 možných operací mého výběru.
* Jaké dodatečné výstupy budu chtít?
    -mohu zobrazit hodnotu například na led na CPLD boardě. Carry out flag, zero flag, overflow flag nebo negative flag se dají aplikovat. Já se rozhodnul pro aplikování zero flag, carry out flag a negative flag.

### Operace
#### Před úpravou operací "Verze 1"
| Kód | Operace |     
|:---:|:-------:|
| 0000 |  A + B  |
| 0001 |  A - B  |
| 0010 |  B - A  |
| 0011 |  A + 1  |
| 0100 |  A - 1  |
| 0101 |  B + 1  |
| 0110 |  B - 1  |
| 0111 | A = B ? |

|  Kód |       Operace      |
|:----:|:------------------:|
| 1000 |        NOT A       |
| 1001 |        NOT B       |
| 1010 |       A AND B      |
| 1011 |       A OR B       |
| 1100 |       A XOR B      |
| 1101 |      A XNOR B      |
| 1110 | Dvojkový doplněk A |
| 1111 | Dvojkový doplněk B |

*Pozn. platí pro obrázky v sekci Kód & Operace č. 5 až 12*

#### Po úpravě operací "Verze 2"
| Kód | Operace |     
|:---:|:-------:|
| 0000 |  A + B  |
| 0001 |  A - B  |
| 0010 |  B - A  |
| 0011 |  A + 1  |
| 0100 |  A - 1  |
| 0101 |  **B >> 1** |
| 0110 |  **B << 1** |
| 0111 | A = B ? |

|  Kód |       Operace      |
|:----:|:------------------:|
| 1000 |        NOT A       |
| 1001 |**B Logický Posun Vlevo**|
| 1010 |       A AND B      |
| 1011 |       A OR B       |
| 1100 |       A XOR B      |
| 1101 |      A XNOR B      |
| 1110 | Dvojkový doplněk A |
| 1111 |**B'MSB <=> B'LSB** |

*Pozn. platí pro obrázky v sekci Kód & Operace č. 13*
Tučným písmem jsem zvýraznil upravené operace. Jedná se o rotaci vpravo, rotaci vlevo, logický posun vlevo a přehození nejvyššího a nejnižšího čtvrbytu

### Vstupy

|Název|Účel|Velikost|
|-|-|-|
|__A__, __B__|operandy|4-bit|
|__alu_select__|operace|4-bit|
|__clk_i__|clock|1 bit|
|__srst_n_i__|reset button|1 bit|
|__en_i__|enable|1 bit|

### Výstupy

|Název|Účel|Velikost|
|-|-|-|
|__carry_out__|Carry-Flag|1 bit|
|__negf__|Sign-Flag|1 bit|
|__zero__|Zero-Flag|1 bit|
|__y__|výsledek|4-bit|

## Kód & Testbench
Kód jsem prvně dostal do funkčního stavu bez vstupního clocku. S testbenchem, který jsem provedl jsem byl spokojený. Jak můžeme vidět na obrázku 5 až 8, vše vypadá v pořádku, zobrazuje se dobře. 

###### Obrázek 5 Součet bez clocku
<img src="Images/3%261.PNG" alt="ALU-3&1" />

###### Obrázek 6 Součet bez clocku
<img src="Images/3%2611.PNG" alt="ALU-3&11" />

###### Obrázek 7 Součet bez clocku
<img src="Images/15%264.PNG" alt="ALU-15&4" />

###### Obrázek 8 Součet bez clocku
<img src="Images/11%2611.PNG" alt="ALU-11&11" />

Proto jsem přešel na další upgrade. Zaimplementoval jsem tedy celý proces, aby záležel na clocku. To se mi také povedlo. Vše je vidět na obrázku 9 až 12.

###### Obrázek 9 Součet s implementovaným clockem
<img src="Images/C3%261.PNG" alt="ALU-3&1" />

###### Obrázek 10 Součet s implementovaným clockem
<img src="Images/C3%2611.PNG" alt="ALU-3&11" />

###### Obrázek 11 Součet s implementovaným clockem
<img src="Images/C15%264.PNG" alt="ALU-15&4" />

###### Obrázek 12 Součet s implementovaným clockem
<img src="Images/C11%2611.PNG" alt="ALU-11&11" />

Všechny operace jsem vyzkoušel pro více různých případů vstupních hodnot. Jakožto vstupní čísla jsem použil dvě různé, které jsou menší při součtu než 15 tj. "plný" výstup nenastane, dále také dvě, které jsou při součtu větší než "1111" a proto donutím carry out zapnout, v neposlední řadě jsem použil pro test dvě stejné čísla. Vše je vidět na obrázcích. 
Jak je viditelné z testbenche, oba se shodují a proto při implementaci clocku nedošlo k rozdílnostem ve funkčnosti. 

*Pozn. Tyto testy proběhly před úpravou některých operací, které jsem pozměnil. Tyto operace jsem popsal i v teoretické přípravě jakožto dvě resp. čtyři různé tabulky.*

V upravené verzi 2, jsem předělal 4 operace. Rotace vpravo, kdy se např. z číšla "1011" stane "1101" & vlevo, logický posun vlevo o 1 např. "1011" přejde na "10110" a tedy se zapne carry out a poslední operand, který nám přinesl novou operaci prohození MSB a LSB např. "1010" se přemění na "0011". K této verzi mě vedlo to, že jsem si uvědomil, že nekteré operace jako inkrementace o 1 tj. "A+1" stačí udělat jen pro jedno vstupní číslo. Proto jsem přemazal "B+1 & B-1" za jiné operace. Díky tomu jsem ve verzi 2 mohl ukázat a předvést další operace jako je rotace, logický posun a prohození MSB a LSB. Jelikož pokud by někdo chtěl můj kód použít pro další použití jako součást většího celku mohl by operovat s vícero příklady.

###### Obrázek 13 Zobrazené upravené operace s různými vstupy
<img src="Images/ALU_upgradeed.PNG" alt="ALUupgraded_operations" />

###### Obrázek 14 Schéma ALU jednotky v ISE
<img src="Images/scheamtic_alu.PNG" alt="ALUschematic" />

###### Obrázek 15 Vnitřní stavba ALU v ISE
<img src="Images/scheamtic_alu2.PNG" alt="ALUscheamtic2" />

Tato jednotka se poskládala z jednotlivých sub segmentů, které každé plní svou funkci. Tak jak by se dala ALU poskládat z jednotlivých entit, kdy každá by plnila svou funkci. Tak je to vyřešené i v hardwaru. V procesoru se muže objevit například sekce tranzistorů, která plní jen funkci FULL ADDERU nebo jednoduché OR/AND atd.

## Top
Jako první jsem si celé rozvržení topu načrtnul na papír. Obrázek 16. Barevně jsem si rozlišil nejdůležitější věci jako clk_i, srst_n_i, a, b. Pak mi došly barvy, ale zároveň se jednalo o jediné rozvětvené rozvedené signály. Proto zvýraznění dalších nebylo potřeba.

###### Obrázek 16 Rozkreslení Topu
<img src="Images/IMG_20200417_154123_1.jpg" alt="ALUrozkreslení"  />

###### Obrázek 17 & 18 Top v ISE (horní a dolní díl)
<img src="Images/top_Top.PNG" alt="Top_ISE1"  />
<img src="Images/top_alu2cut.PNG" alt="Top_ISE2"  />

###### Obrázek 20 Top v ISE (vnější pohled)
<img src="Images/top_alu.PNG" alt="Top_ISE1"  />

Jak můžeme vidět na obrázcích 17 a 18 celý obvod používá 12 přepínačů, jedno resetovací tlačítko, synchronizační clock na vstupech. Na výstupech máme tři jedno bitové výstupy, které se na boardě připojí ke třem led, které budou signalizovat různé stavy. Na 4 ciferný segmentový display bude přiveden vstup a, b (zleva) pak bude jedna nevyužitá cifra, a nejvíce zprava se bude zobrazovat výstup z Alu jednotky y. Tím pádem budeme vědět jaké vstupní hodnoty jsme zadali a jaká je výstupní hodnota.
Teoreticky by se dal výstupní signál s_disp nasměrovat i na čtveřici led na rozšiřujícím "shieldu" pro lepší názornost logických operací.

###### Obrázek 21 Ukázka resetu 
<img src="Images/alu_reset.PNG" alt="Top_Reset"  />

## Zdroje
Prošel jsem si mnoho internetových zdrojů, hlavně ty, které popisují teorii funkčnosti Alu, protože jsem v první řadě potřeboval zjistit co a jak to funguje. Dále jsem nahlédl a různé zpracování kódu převážně v jazyce vhdl. Každý kód je něčím užitečný, díky tomu jsem si získal teoretický přehled, jak asi zpracovat toto téma a jak postupovat.
* https://www.youtube.com/watch?v=1I5ZMmrOfnA
* https://www.youtube.com/watch?v=UsK5KV1FPmA
* https://www.youtube.com/watch?v=r8xVQ3ThQK8
* https://www.youtube.com/watch?v=LAAdVA280fc
* https://www.youtube.com/watch?v=XbKB1Bu5bGg
* https://www.youtube.com/watch?v=RasZU3fr7hE
* https://www.youtube.com/watch?v=PKvJSXVfvps
* https://www.youtube.com/watch?v=pwIEqJan9mA
* https://portal.matematickabiologie.cz/index.php?pg=zaklady-informatiky-pro-biology--teoreticke-zaklady-informatiky--teorie-cisel--dvojkovy-doplnek
* https://cs.wikipedia.org/wiki/Dvojkov%C3%BD_dopln%C4%9Bk
* http://www.et-pocitacovesystemy.wz.cz/cislicova_technika/komb_log_obvody/aritm_log_jednotka/alu.html
* https://en.wikipedia.org/wiki/Arithmetic_logic_unit
* https://www.fpga4student.com/2017/06/vhdl-code-for-arithmetic-logic-unit-alu.html
* https://gist.github.com/pauljohanneskraft/b3e9d8f27b62200da705b258b63bdd60
* https://en.wikibooks.org/wiki/VHDL_for_FPGA_Design/4-Bit_ALU
* https://allaboutfpga.com/vhdl-code-for-4-bit-alu/
