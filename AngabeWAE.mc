<!--
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML
Content-encoding="UTF-8"><HEAD><TITLE>Übung Web Application Engineering &amp; Content Management</TITLE>
</HEAD>
<BODY>
-->
<H1>Praktische Aufgabe zu Web Application Engineering &amp; Content Management WS 23/24</H1>
<B>Hinweis: Erarbeiten Sie dieses Beispiel in der Gruppe, zu der Sie sich unter <A href="http://wae.ztschranz.at/wae/anmeldung.pl">angemeldet</a> haben.</B>
<P>Der &Uuml;bungsteil zu Web Application Engineering befasst sich mit der serverseitigen
Umsetzung von komplexen Web Services auf Basis eines exemplarischen Web Application Servers.
Zum Einsatz kommt dabei der open source Application Server <A
href="http://search.cpan.org/~jswartz/Mason-2.24/lib/Mason.pm">Mason</A> und die Anwendungsdom&auml;ne des Web Content Managements.
Die Aufgabe ist in Gruppen zu 2-3 Studenten zu l&ouml;sen, d.h. jede Gruppe hat die
kurzen Programme als Team zu erstellen und abzugeben. Beim kurzen Abgabegespr&auml;ch
werden die Mason-Komponenten &uuml;bergeben, diskutiert und bewertet.
<H3>In K&uuml;rze die gestellte Aufgabe:</H3>
Auf Basis einer (oder wenn n&ouml;tig mehrerer) einfachen Datenbanktabelle(n) sollen zumindest Dokument-ID, Inhalt, Titel und Erstellungdatum von Web-Dokumenten erfasst werden k&ouml;nnen. Durch den Einsatz eines Open Source WYSIWIG Editors hat der Content Manager die Freiheit, Texte mit Bildern und Hyperlinks zu kombinieren.
Seiten sollen angelegt, gespeichert und gel&ouml;scht werden k&ouml;nnen, eine zu entwicklende Preview-Semantik erlaubt einen Blick auf das soeben Erstellte.
Mittels hierarchischer Strukturierung &uuml;ber die Ids ist ein Dokumentenbaum zu erstellen und als Menu (etwa analog zur Darstellung in Typo3, siehe Vorlesung 5) zu visualisieren.
Letztlich soll ein Template f&uuml;r eine individuelles Erscheinungsbild der Site sorgen.

<p>Die Aufgabe wird gel&ouml;st, indem mehrere Mason-Komponenten
eingesetzt werden, die einige Features dieses Web Application Servers
demonstrieren:
<OL>
  <LI><B>Bearbeitungskomponente (Content Management Component)</B><BR>In einem Formular soll ein Dokument erfasst bzw. editiert werden k&ouml;nnen. Analog zum Workflow von aktuellenCMS sollen hier Daten und Metadaten von Web-Dokumenten erfasst werden.
Als Hilfsmittel steht der WYSIWYG-Editor CKeditor zur Verf&uuml;gung, ein einfaches Code-Beispiel zur Integration finden Sie <a href="editor">hier</a>.
<br>Die Dokumente sollen per Mason-Komponente in die Datenbank  hinzugef&uuml;gt werden k&ouml;nnen bzw. die bestehenden Dokumente gel&ouml;scht werden k&ouml;nnen.
Die entsprechenden Formularkomponenten sollen dem Template mitteilen k&ouml;nnen, dass sie in unterschiedlichem Layout erscheinen sollen. Es sind dazu objekt-orientierte Konzepte von Mason anzuwenden, n&auml;mlich die Komponenten mit Attributen zu versehen.
  <LI><B>Eine Menu Komponente</B>
<BR>Diese Komponente stellt eine selbstst&auml;ndige Mason-Komponente dar, die aus den Titeln der in der Datenbank befindlichen Dokumente eine hierarchische Auflistung in Form eines Menus darstellt. Durch die Auswahl eines Eintrages soll ein entsprechendes Dokument aufgerufen werden k&ouml;nnen. Musterbeispiele, wie dies in der Wirtschaftspraxis umgesetzt ist, finden sich in
<a href="/static/images/image001.png">Screenshot1</a>,
<a href="/static/images/image005.png">Screenshot2</a>
und
<a href="/static/images/image003.png">Screenshot3</a>.
<p>Das Menu baut aufgrund der hierarchischen Beziehung zwischen den Dokument-IDs einen entsprechenden Menubaum (h&ouml;chstens 3 Ebenen) auf. Das Menu, die Anzeige des Dokumentinhaltes und eventuelle Header/Footer/Hintergrundbilder werden dann vom Template (siehe n&auml;chste Komponente) integriert.
  <LI><B>Eine Template Komponente</B><BR>Diese Komponente stellt eine HTML-Vorlage
  dar und soll, abh&auml;ngig von der Funktionalit&auml;t der im weiteren aufgerufenen
  Komponenten verschiedene Layouts erzeugen bzw. erweitern k&ouml;nnen. Je nachdem, ob es sich um
  eine Produktbearbeitung (Eingabe, L&ouml;schen) oder um die Produktanzeige zur
  Bestellung handelt, soll sichtbar ein anderes Design erzeugt werden. Es steht
  jeder Gruppe frei, ein ansprechendes Layout daf&uuml;r zu definieren. <BR>Die
  template Komponente kann den Namen "Base.mc" tragen, denn der Mason Server
  f&uuml;r den Praxisteil ist auf diese Bezeichnung konfiguriert. Ihr template kann
  zur unterschiedlichen Darstellung gerne objektorientierte Elemente aus Mason
  einsetzen (Attribute, Methoden, etc.)
  <LI><B>Datenbank-Access-Komponente</B><BR>Es ist empfohlen, eine eigene
  (interne oder pure-perl) Komponente (oder mehrere) zu entwerfen, die sich um die Datenbankzugriffe
  k&uuml;mmert/n. So kann in den Formularkomponenten das Hauptaugenmerk auf der
  Formularerstellung bleiben und die Datenbankanbindung mit den zu liefernden
  Datenbankergebnissen als Subkomponenten eingebunden werden. Wie eine
  Komponente aus einer anderen aufgerufen bzw. eingebunden wird, erkl&auml;ren die
  Beispiele im Anhang und <A
  href="http://search.cpan.org/~jswartz/Mason-2.24/lib/Mason.pm">CPAN</A>.

  </LI></OL>
Sie ben&ouml;tigen zur L&ouml;sung dieser Aufgabe eine Account am
Mason Webserver (<A href="http://wae.ztschranz.at:8020/">wae.ztschranz.at Port 8020</A>), wo Sie in
Ihrem Verzeichnis (z.B.: wae01) die Komponenten erstellen und testen k&ouml;nnen, ebenso wie einige
Hinweise zur Komponentenerstellung und Datenbankanbindung. Pro Gruppe gibt es
zus&auml;tzlich auch einen Account f&uuml;r das Rechnernetze Lab, das Sie zur Arbeit
nutzen k&ouml;nnen. Die Datenbank k&ouml;nnen Sie mit dem Kommandozeiletool "mysql" bedienen (naeheres auch unter http://www.mysql.com).
<P>Hinweise zur Erstellung von Mason-Komponenten finden Sie unter <A
href="http://search.cpan.org/~jswartz/Mason-2.24/lib/Mason.pm">CPAN</A>
und einige weitere zu Mason und dessen Anwendung unter <A href="MasonCodeTipps">hier</A>.

<P>Viel Erfolg bei der Bearbeitung w&uuml;nscht
<br>Markus Schranz </P>
<!-- </BODY></HTML>
-->
<%init>
  $.title('Übung Web Application Engineering &amp; Content Management');
</%init>
