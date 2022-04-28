close all
clear all
clc

% Add DeepLearnToolbox to path
addpath(genpath('DeepLearningToolbox'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  UWAGA  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pokazanie = 0; % 1 -- prezentacja działania już nauczonej sieci(bez uczenia), sieci przechowywane są w pliku "savedAgents")
               % 0 -- nauka sieci od początku

nazwa_sieci = "siec(300sesji)"; % (przykład) jeśli wybrana została wyżej opcja 1;  % TUTAJ WPISUJEMY NAZWĘ NAZWĘ GOTOWEJ SIECI np. 'matlab1'              
               
% Parametry wahadła (wartości te zostały zidentyfikowane na
% podstawie prawdziwego modelu, można je modyfikować)

tau1 = 0.036;                    % moment siły pojedyńczej akcji (maksymalny moment naszego rzeczywistego silnika wynosi 0.267)
                                 % dla tau1 = 0 wahadło nie będzie miało żadnego pobudzenia 
                                 %(można testować zachowanie się wachadła tylko dla zadanych warnunków początkowych) 
                                 
tau2 = 0;                        % zakłócenie wahadła (moment siły) % stała wartość lepiej robić to w simulinku blokiem jakiejś funkcji
L1 = 0.05;                       % długość ramienia od osi silnika
L2 = 0.1;                        % długość wahadła
l1 = 0.022;                      % długość punktów mas ramienia 1 od środka osi silnika (miejsce położenia łożysk, jest to większość masy ramienia 1)
l2 = L2/2;                       % odległość środka masy ramienia 2 od jego osi obrotu 
m1 = 0.045;                      % masa środków masy ramienia 1
m2 = 0.015;                      % masa ramienia 2
J1 = 2*m1*l1^2;                  % moment bezwładności ramienia 1 (dwa łożyska składające symetrycznie w tej samej odległości od osi obrotu silnika się) nie zmieniać
J2 = 1/3*m2*L2^2;                % moment bezwładności ramienia 2 nie zmieniać
b1 = -5*10^(-3);                 % tłumienie obrotu ramienia 1
b2 = -5*10^(-5);                 % tłumienie obrotu ramienia 2
g = 9.81;                        % przyśpieszenie ziemskie
J1_dash = J1;            
J2_dash = J2;
J0_dash = J1_dash + m2*L1^2;

pend = [tau1 tau2 L1 L2 l1 l2 m1 m2 b1 b2 g J1_dash J2_dash J0_dash];  % wektor parametrów przesyłany do simulinka

% parametry symulacji
opts.simulation_step = 0.025;        % czas próbkowania sygnałów (sec)
opts.simulation_time = 25;           % czas symulacji (sec)
opts.t_delay = 0;                    % opóźnienie transportowe
sessions = 400;                      % maksymalna ilość sesji uczących 
points_treshold = -150;              % kryterium zakończenia treningu

% Parametry trenigowe Agenta:
opts.p = 0.9995;                      % zanik epsilona co każdy krok symulacji( e = p * e)
opts.discount_factor = 0.9;          % gamma
opts.learning_rate = 0.001;          % stała tempo uczenia
opts.numepochs = 10;                 % ilość epok
opts.minibatch_size = 64;            % wielkość minibatcha (minipartii)
opts.batch_size = 6000;              % wielkość batcha (partii) w ilości próbek
opts.memory_size = 6000;             % wielkość pamięci doświadczeń w ilości próbek
opts.poss_action = [-2,0,2];         % możliwe do podjęcia przez nas akcje (ujemny moment, 0 momentu, dodatni moment) nie zmieniać!
outputs = length(opts.poss_action);
opts.layers=[48 96 outputs];         % warstwy sieci  (można zmieniać program obsługuje dwie warstwyy ukryte)
opts.inputs = 4;                     % ilośc wejść sieci neuronowej, nie zmieniać!
opts.points_divide = 10;             % dzielnik punktów dodając do experience replay
opts.scale_velocity = 25;            % dzielnik składowej prędkości w nagrodzie(dopasowanie kary za prędkość obrotową ramienia 2)
opts.target_smooth_factor = 0.4;     % wpsółczynnik wygładzający (intensywność aktualizacji sieci celu)

open('wahadlo.slx');
a = NNAgent_1(opts);
a.interakcja(sessions, pend, pokazanie, nazwa_sieci, points_treshold);
