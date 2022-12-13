# Cyber Help
Unicam Flutter app against cyberbullism

<img align="right" width="190" height="190" src="https://github.com/Glydric22/cyberbullism_bully/blob/master/assets/Logo.png?raw=true">

## Contesto
CyberHelp è un’applicazione mobile con l’intento di essere di aiuto a ragazzi vittme di cyber-bullismo, sia in una forma di “incubazione” sia in forma grave.

L'utente target dell'applicazione infatti saranno ragazzi di scuole medie e superiori, poiché questi ricadono nella fascia d'età più "fertile" per questo tipo di fenomeno. Essi avranno la possibilità duque di "chattare" gratuitamente con veri e propri psicologi qualificati; ogni psicologo può avere una o più conversazioni con multipli utenti. Dunque ci saranno due macro-tipi di utenti:

- User
- Psicologo, un particolare tipo di User, con PEC in corso di validità.

Ogni utente può inviare una segnalazione, inserendo una gravità, che verrà poi presa in carico una tantum da uno dei tanti psicologi che si troverà a leggerla, e se deciderà di prenderla in carico prima o poi.

## Metodologie

Per lo sviluppo front-end è stato utilizzato il frameWork Flutter del linguaggio di programmazione DART, grazie alla sua natura multipiattaforma.

Per il lato backend dell'applicazione è stato sfruttato l'ambiente runtime NodeJS per via della sua natura event-driven e non bloccante. La sua scalabilità, rapidità e flessibilità lato backend e flessibilità per il networking lo ha reso un ottima scelta per gestire l'interazione tra l'interfaccia del software ed il database server. 1 DB utilizzato è quello integrato in Altervista in cui è in esecuzione parte del backend, gestito tramite il tool phpMyAdmin.

Sicurezza a livello dataBase? È presente sia un controllo sul SQL Injection, sia sul crypting dei dati personali (password e email) immessi dagli utenti (metodo BCrypt).

## Funzionalità

- Avere una chat tra psicologo e utente che faccia vergere il carico della connessione lato server. I| webSocket infatti fa si che ogni frazione di secondo venga riaggiornato lo stato di una variabile sentinella, abile di intercettare l'arrivo di un messaggio. Se questo succedesse verrebbe istantaneamente inviata tutta la sequenza di messaggi lato client. Questo risulta come una normale chat che si aggiorna praticamente ad una velocità non percepibile ad occchio.
- Login e registrazione-> utente/psicologo
- Sessione persistente dopo una la chiusura dell'applicazione per un tempo limitato.
- Chat privata con lo stesso psicologo, che viene indissolubilmente legata tra i due utenti.

## GitHub

È stato utilizzato GitHub per gestire la comunicazione e tramite esso è stata anche applicata una tecnica di Cl che consente di eseguire i test in automatico ad ogni push tramite GitHub actions

Studenti
</br>
~ Leonardo Migliorelli ([Glydric22](https://github.com/Glydric22)) **MAT. 113920**
</br>
~ Loris E. Minetti ([LorisMinetti](https://github.com/LorisMinetti)) **MAT. 115346**  


