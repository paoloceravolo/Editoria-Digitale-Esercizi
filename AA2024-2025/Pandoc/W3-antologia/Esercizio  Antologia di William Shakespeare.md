### Esercizio:  Antologia di William Shakespeare

#### **Scenario**

Un'azienda editoriale digitale desidera creare una Antologia di William Shakespeare utilizzando un processo automatizzato che riduca al minimo i costi di produzione. I dati iniziali sono raccolti da fonti aperte in formato **Markdown** (ad esempio da [questo repository](https://github.com/mlschmitt/classic-books-markdown/blob/main/William%20Shakespeare/King%20Lear.md)). I contenuti devono essere trasformati in diversi formati di destinazione per soddisfare i requisiti di vari canali di distribuzione, come il Web (HTML), gli e-book (EPUB), e i documenti stampabili (PDF). Durante queste trasformazioni:

1. **Metadati** in formato **YAML** verranno definiti per descrivere il contenuto (es. titolo, autore, data, licenza). Alcuni metadati possono essere estratti dalle pagine Wikipedia delle singole opere. Ad esempio: [Re Lear](https://it.wikipedia.org/wiki/Re_Lear).
2. Saranno generati ulteriori metadati per il supporto alla distribuzione, come file **ONIX** per l'industria editoriale e schemi **Schema.org** per il Web.
3. I contenuti e i metadati saranno archiviati e versionati tramite GitHub, permettendo collaborazione e revisione.
