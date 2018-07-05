# IFG-Ticker

[English below](#english)

Wir verlinken auf unserem Twitter-Account [@IFG_IFG_IFG](https://twitter.com/IFG_IFG_IFG) automatisiert Nachrichten, die sich auf
[Informationsfreiheits](https://de.wikipedia.org/wiki/Informationsfreiheitsgesetz)- bzw. Tranzparenzgesetze beziehen.

Das US-amerikanische Vorbild ist [FOIA Feed](https://twitter.com/FOIAFeed) der [Feedom of Press Foundation](https://freedom.press/). Diese stellt den Code als [TrackTheNews](https://github.com/freedomofpress/trackthenews) Open Source bereit.

## Neue Nachrichtenquellen hinzufügen

Um Daten einlesen zu können, braucht die Webseite einen [RSS-Feed](<https://de.wikipedia.org/wiki/RSS_(Web-Feed)>). Im ersten Schritt muss also die URL des Feed gefunden werden. Meistens gibt eine Extra-Seite auf der alle vorhandenen RSS-Feeds aufgelistet werden.

Wenn verfügbar, nehmen wir einen Feed, der alle Nachrichten der Webseite beinhaltet. Falls dies nicht möglich ist, muss man für die Webseite mehrer Feeds hinzufügen. Meisten reichen die Kategorien wie Nachrichten oder Politik. Wenn man Lust hat, kann man auch einfach alle hinzufügen. Je mehr desto besser.

Danach müssen die Feeds im folgendem Format in [rssfeeds.json](ttnconfig/rssfeeds.json) hinzugefügt werden (hier am Beispiel der TAZ):

```
  {
    "url": "http://www.taz.de/Nord/!p4650;rss/",
    "outlet": "TAZ",
    "delicateURLs": false,
    "redirectLinks": false
  },
```

Pull Requests sind gerne gesehen. Ansonsten kann man auch gerne ein neues [Issue](https://github.com/jfilter/ifg-ticker/issues/new) unter Angabe der Feed-Adressen eröffnen.

## English

<a name="english"/>

This is the German version of the [FOIA Feed](https://twitter.com/FOIAFeed) of the [Feedom of Press Foundation](https://freedom.press/). They released their code as Open Source: [TrackTheNews](https://github.com/freedomofpress/trackthenews). The German [FOIA](<https://en.wikipedia.org/wiki/Freedom_of_Information_Act_(United_States)>) is called [Informationsfreiheitsgesetz](https://de.wikipedia.org/wiki/Informationsfreiheitsgesetz) (IFG).

## License

Data: CC0

Code: MIT
