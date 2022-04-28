
Otwieramy plik 'dzialanie_1.m'
Plik działanie_1 umożliwia pełną konfigurację parametrów uczenia, symulacji oraz modelu wahadła, chyba że w poszczególnych miejscach zaznaczone jest inaczej.
w linijce 10 mamy do wyboru:
albo stworzyć sieć od początku i nauczyć ją według zadanego kryterium punktowego
lub skorzystać z jednej z sieci zapisanej w formie pliku .mat przechowywancych w pliku o nazwie 'savedAgents'.

Kolejno w skrypcie definiowane sa parametry fizyczne wahadła oraz wartość momentu siły pojedyńczej akcji.
Momenty bezwładności ramion są wyliczane automatycznie na podstawie zdefiniowanych w skrypcie wzorów
W parametrach symulacji ważne jest ustalenie punktowego kryterium końca treningu (-150 powinien spełniać wymagania poprawnego sterowania, zawsze można dać więcej np. -120 w celu maksymalizacji osiągów)

program rozpoczynamy klikając'Run'.

Powinen otworzyc się Simulink wraz z oknem wizualizacji wahadła oraz z oknem oscyloskopu
Wyświeltany jest również okno z wykresami aktualnego postepu uczenia sieci 

Wizualizacjia pracuje w tempie czasie rzeczywistym, przez co wykresy jak i całe uczenie również wykonuje się w tempie czasu rzeczywistego.
jest to wygodne do monitorowania na bieżąco postępu działania wahadła.

Gdy zależy nam na szybkim nauczeniu sieci i rezultacie końcowym zamykamy okna wizualizacji i oscyloskopu. Wtedy uczenie trwa kilka, kilkanaście minut

Gdy tak przeprowadzone uczenie się zakończy chcąc zobaczyć efekt w wizualizacji musimy otworzyć blok 'VR Sink' znajdujący się schemacie blokowym Simuliunku.
Chcąc przeanalizować jednocześnie wykresy kątów i prędkości kątowych ramienia 2 , zakłócenia oraz wybrane akcje przez sterownik, klikamy dodatkowo blok 'Scope'
w prawym górnym rogu okna 'Scope' znajduje sie legenda i możemy poprez naciśniecie opisu w legendzie wyświetlać tylko te sygnały, które nas aktualnie interesują.

Klikamy nastepnie 'Run' w zakładce 'Simulation' w oknie Simulinka i obserwujemy działanie nauczonej sieci

Sieci przechowywane są w workspace wewątrz klasy Agenta (a), pod nazwą nn(sieć Q)  oraz nn_target(sieć celu). Zawierają one wartości współczynników nauczonych wag

W razie niedopowiedzenia czegoś komentarze zawarte w skrypci powinny większość wyjaśnić
