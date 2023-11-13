<H2>Einige wichtige Hinweise zum Codieren</H2>
<H3>Mason Programming</H3>Die wichtigsten Hinweise finden Sie unter <A
href="http://www.masonhq.com/">http://www.masonhq.com/</A> und bei den Dokumentationen zu Mason und POET.
Dort ist auch zu
ersehen, dass es bereits viele Mason-Versionen gegeben hat. Wir arbeiten zur
Zeit auf auf Mason 2.22.
<P>Als kurze Hinweise ganz allgemeiner Art dient folgendes: Jede
Mason-Komponente ist gleichzeitig Ausgabeobjekt und Server-seitiges Script
zugleich. Sie k&ouml;nnen damit Web Seiten oder Teile davon erzeugen bzw. ausgeben als
auch Formulareingaben &uuml;bernehmen und entsprechende Aktivit&auml;ten starten.
<P>Aus Konvention besteht eine Mason-Komponente aus invariablem Text vermengt
mit interpretierten Perl Anweisungen gefolgt von ganzen Bl&ouml;cken, die nur vom
Mason-Application Server interpretiert werden. Einige wichtige Abschnitte seien
hier kurz umrissen:
<DL>
  <DT>Der &lt;%init&gt;-Block
  <DD>dieser Teil wird rein vom Mason Application Server interpretiert und zwar
  vor allen anderen Elementen innerhalb dieser Komponente. Damit kann eventuell
  der gesamte auszugebende Inhalt erzeugt werden oder aber Teile des Ergebnisses
  vorbereitet werden, welche dann in den interpretierten Teilen im Ausgabeblock
  angegeben werden.
  <DT>Der &lt;%class&gt;-Block
  <DD>In diesem Bereich k&ouml;nnen CGI-Parameter als Perl-Variablen definiert werden,
  auf die dann im init Block oder in anderen interpretierten Bl&ouml;cken direkt
  zugegriffen werden kann. Es kann auch ein default-Wert &uuml;bergeben werden.
	Diese Variablen sind dann Klassenobjekte (auch Attribute) und innerhalb der ganzen Komponente verfügbar.
  <DT>Der Ausgabeteil
  <DD>steht in der Regel vor den reinen Mason-Bl&ouml;cken und definiert den HTML-Code
  bzw. die interpretierten Bl&ouml;cke, die der Web-Server als Ergebnis liefern soll.
  <DT>Weitere Bl&ouml;cke
  <DD>k&ouml;nnen zum Beispiel Methoden zur aktuellen Komponente
  definieren. Mehr dazu kann im masonhq nachgeschlagen werden. </DD></DL>Ein
kurzes Code-Beispiel zeigt eine einfache "Hello World"-Komponente <PRE><CODE>
Hello &lt;% $world %&gt;
&lt;%class&gt;
  has 'world' =&gt; (default => 'Mason World');
&lt;/%class&gt;
&lt;%init&gt;
  $m->session->{'hello'} = $.world;
  $.world = uc($m->session->{'hello'});
&lt;/%init&gt;
</CODE>
</PRE>Im Ausgabeteil k&ouml;nnen weitere Komponenten mittels &lt;&amp; compname, 'arg1' => 'val1', ...
&amp;&gt; eingebunden werden, wobei das assoziative Array $.args als das vom
System vorgegebene (mit ebendiesem Namen und allen Parametern, das schon diese
Komponente erhalten hat durchgereicht) auch neben eigenen Parametern verwendet werden kann.
<P>F&uuml;r die Anwendung der Objekt-Orientierten Features (Attribute) kann eine umfangreiche Studie der Dokumentation
zu Mason, Perl und Moose nicht schaden. Viel Wichtiges davon ist aber unter masonhq erreichbar.
<H3>Datenbankeinbindung</H3>Neben der globalen Session-Handling Variable $m->{'session'} steht
(nach Definition des &Uuml;bungsbetreuers) auch ein globaler Datenbankhandle auf eine
persistente Datenbankverbindung zur Verf&uuml;gung. Diese Verbindung ist &uuml;ber $dbh = Ws23::DBI->dbh();
verf&uuml;gbar und zeigt auf die Datenbank "tuv" am &Uuml;bungsserver, auf dem Tabellen
angelegt und ver&auml;ndert werden k&ouml;nnen. Momentan gibt es dabei zugriffsrechtlich keine
Einschr&auml;nkung, ich bitte Sie, diese Freiheit nicht ungebührlich auszunutzen und
zus&auml;tzliche Rechteeinschr&auml;nkungen notwendig zu machen.
<P>Das Perl-Modul DBI bietet einen komfortablen Zugang zur Datenbank.
Die folgenden Code-Beispiele zeigen ein typisches select bzw. insert-Statement. <PRE><CODE>
&lt;UL&gt;
 % foreach my $result (@results) {
 &lt;LI&gt; &lt;% $result %&gt;
 % }
&lt;/UL&gt;
&lt;%init&gt;
  my $sth = $dbh->prepare("select prod_id, prod_name, prod_price from produkte where prod_id = ?");
  $sth->execute($.args->{'prodId'});
  my @results;
  while (my $hr = $sth-&gt;fetchrow_hashref) {
    push(@results, "$hr-&gt;{'prod_name'}...$hr-&gt;{'prod_price'}");
  }
&lt;/%init&gt;
</CODE>
</PRE>Das Insert-Statement sieht analog aus: <PRE><CODE>
Insert &lt; $success?"done":"failed" &amp;&gt;

&lt;%init&gt;
 my $myprice = 24.9; # wird wahrscheinlich aus dem parameter gelesen werden...
 my $sth = $dbh-&gt;prepare("insert into produkte (prod_id, prod_name, prod_price) values (?,?,?)");
 $sth->execute('0', # auto_increment sorgt daf&uuml;r dass hier eine entsprechende Zahl eingef&uuml;gt wird
                'Produktname1', $myprice);
&lt;/%init&gt;
</CODE>
</PRE>Mehr Aufschluss &uuml;ber dieses Modul liefert der Aufruf "perldoc DBI"
direkt von der Command-Line oder in einer Online-Perl-Dokumentation.
<H3>HTML und Formularerstellung</H3>Wissenswertes zu HTML, den ben&ouml;tigten Tags, um
ein ansprechendes Layout zu gestalten bzw. um Formularfelder zu definieren
findet sich ausreichend am Web (z.B. www.selfhtml.com).

<%init>
	$.title('Mason Code Tipps');
</%init>
