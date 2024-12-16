`` Università degli Studi di Milano - `` `` Corso di Editoria Digitale`` 
`` Anno Accademico 2022/2023`` 

# Report e analisi degli ascolti mensili di un utente utilizzando le API di Last.fm e Spotify



## Introduzione

Last.fm è un social network che permette di tener traccia dei propri ascolti su Spotify/Apple Music/Youtube Music. Il sistema costruisce un profilo per ogni utente e include i suoi artisti e canzoni preferite in un sub-sito personalizzabile. Le canzoni  ascoltate vi compaiono dopo averle ascoltate con l'apposita radio oppure tramite un plugin installato nel proprio player.[^1]

Lo scopo del mio progetto sarà la creazione di un report mensile con informazioni riguardo le canzoni, gli album e le tracce più ascoltate dall'utente con insight sulle caratteristiche delle tracce ascoltate dall'utente (forniti dalle API Spotify)

XML, XSLT e EPUB hanno permesso la realizzazione di questo progetto, essendo in grado di trasformare contenuto non fruibile da tutti gli utenti, in una esperienza gradevole sotto tutti i punti di vista.

## Obiettivi 

L'obiettivo principale è incuriosire gli utenti (interessati a statistiche sui propri ascolti e non) ad una analisi più profonda basata su dati generati dai propri ascolti e abitudini di ascolto in generale. Questo progetto è destinato anche a persone in cerca di ispirazione, se, ad esempio, sono in cerca di nuovi artisti da ascoltare. 

E' possibile, quindi, definire il progetto come una estensione della funzione Spotify Wrapped a ogni mese dell'anno, con l'aggiunta di informazioni mirate e specifiche fornite da Last.fm.

## Processo di produzione

### Studio e analisi tema

- **Identificazione delle fonti:** la piattaforma Last.fm fornisce già all'utente registrato informazioni e statistiche inerenti a tracce, album e artisti più ascoltati. E' possibile estrarre queste informazioni tramite le apposite API. Le percentuali sulle caratteristiche delle tracce sono state estratte grazie alle API di Spotify.
- **Definizione del target**: il target è composto dalle persone che fanno uso di Last.fm, senza di esso non si avrebbero le informazioni necessarie per una descrizione accurata degli ascolti, ma solo quelle generiche che forniscono le API di Spotify. Se un utente fa uso di Last.fm, è indifferente aver collegato ad esso un account Spotify/Apple Music/Youtube Music.
- **Studio competitor/tools già esistenti:** le applicazioni online tendenzialmente gestiscono informazioni esclusivamente di una delle due piattaforme, mai delle due contemporaneamente. I dati derivati dalle API di entrambe le piattaforme possono essere manipolate in infiniti modi.
- **Diritti legali**: i dati degli utenti registrati su Last.fm sono tendenzialmente pubblici, è possibile, quindi, accedere ad essi in ogni momento. I dati di Spotify, invece, non sono legati in nessun modo all'utente.

## Bibliografia e sitografia

[^1]: https://it.wikipedia.org/wiki/Last.fm
[^2]: https://developer.spotify.com/documentation/general/guides/authorization/
[^3]: https://www.last.fm/api
[^4]: https://developer.spotify.com/documentation/web-api/libraries/
[^5]: https://developer.spotify.com/console/
