# Conwayjeva igra života u Common Lispu

Ovaj projekt implementira **Conwayjevu igru života** koristeći programski jezik **Common Lisp**. Projekt omogućuje interaktivno konzolno sučelje gdje korisnik može definirati dimenzije mreže, postaviti početne žive ćelije te pratiti razvoj generacija prema pravilima igre.

## Značajke
- Interaktivno konzolno sučelje.
- Prilagodljive dimenzije mreže.
- Mogućnost unosa početnih koordinata živih ćelija.
- Kontinuirana simulacija s opcijom zaustavljanja i ponovnog pokretanja igre.

## Zahtjevi
- **SBCL** (Steel Bank Common Lisp): Implementacija Lispa.
- **SLIME** (opcionalno): Okruženje za razvoj u Lispu u **Emacsu**.

## Kako koristiti
1. Klonirajte ovaj repozitorij ili preuzmite datoteku `game-of-life.lisp`.
   ```bash
   git clone https://github.com/Lkotorac20-foi/game-of-life.git
   cd game-of-life
# 2. Pokrenite SBCL i učitajte datoteku game-of-life.lisp: sbcl --load game-of-life.lisp
# 3. Pokrenite igru koristeći naredbu: (run-console-game)

4. Slijedite upute u konzoli:

    Unesite dimenzije mreže (npr. 5 5 za mrežu 5x5).
    Unesite početne ćelije kao koordinate (npr. 2,3 za ćeliju u drugom retku i trećem stupcu).
    Kada završite s unosom ćelija, upišite done.

Simulacija započinje i možete pratiti mrežu generaciju po generaciju:

    Pritisnite Enter za nastavak.
    Utipkajte q za zaustavljanje simulacije.

Nakon završetka, možete odlučiti želite li ponovno pokrenuti igru ili izaći.
# Pravila igre

    Živa ćelija s manje od 2 živa susjeda umire zbog samoće.
    Živa ćelija s 2 ili 3 susjeda ostaje živa.
    Živa ćelija s više od 3 susjeda umire zbog prenaseljenosti.
    Mrtva ćelija s točno 3 živa susjeda oživljava.

    
