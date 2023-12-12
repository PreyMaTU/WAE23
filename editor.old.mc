<%class>
  has 'docid';
  has 'title';
  has 'content' => (default => "<font face=Verdana>bitte hier den Text eingeben.\n</font>\n");
  has 'metatext';
  has 'Save';
  has 'insert' => (default => 0);
  has 'parentid';
</%class>

<%init>
  # TODO add name of article
  $.title('Editor');
</%init>

<h2>
% if (defined($.docid) && ($.insert==0)) {
Dokument <% $.docid %> editieren
% } else {
Neues Dokument anlegen
% }
</h2>
% if (length($msg)) {
<p style="color:red;font-size:10px;"><% $msg %></p>
% }
<form name="editform"
method="post" enctype="application/x-www-form-urlencoded">

<input type="hidden" name="docid" value="<% $.docid %>">
<input type="hidden" name="insert" value="<% $.insert %>">

<TABLE WIDTH="100%" CELLSPACING=1 CELLPADDING=4 BORDER=0>
<COLGROUP>
<COL ALIGN="right" VALIGN="top">
<COL ALIGN="left">
</COLGROUP>
<TR>
<TD>Titel:</TD>
<TD><input type="text" name="title" value="<% $.title %>" size="50" /></TD> <!-- Filter |h ?? -->
</TR>

<TR>
<TD>Parent-ID:</TD>
<TD>
<%doc>
<%  $cgi->popup_menu(-name      =>'parentid',
                       -values    => [ sort keys %docTitleAndIds ],
                       -default   => $.parentid,
                       -labels    => \%docTitleAndIds)
  %> aktuell: <% $docTitleAndIds{$.parentid} %>
</%doc>
  <input type="text" name="parentid" value="<% $.parentid %>" size="3" />

</TD>
</TR>
<TR>
<TD ALIGN=left COLSPAN=2>
  <textarea name="content" id="content"><% $.content %></textarea>
<script>
	// Replace the <textarea id="content"> with a CKEditor
	// instance, using default configuration.
	CKEDITOR.replace('content',{
		width   : '560px',
		height  : '400px'
	});
</script>
<BR>
</TD>
</TR>

<TR>
<TD COLSPAN=2 ALIGN=center>
<BR>
<input type="submit" value="&Auml;nderungen speichern" name="Save">
&nbsp;&nbsp;&nbsp;
<input type="reset" value="&Auml;nderungen verwerfen" name="Cancel"> <!-- onClick="window.close()" -->
<BR>
<BR>
</TD>
</TR>
</TABLE>

</form>

<%init>
use Data::Dumper;
use CGI;

my $dbh = Ws23::DBI->dbh();
my $cgi = new CGI;

my $msg = "Welcome to the WCM content editor.";
my %docTitleAndIds = ('0', 'top level document');

my $sth = $dbh->prepare("SELECT docid, title from schranz_cms");
$sth->execute();
while (my $res = $sth->fetchrow_hashref()) {
  $docTitleAndIds{$res->{docid}} = $res->{title};
}

if ($.Save) {
# Speichern wurde gedr�ckt...
  if ($.insert == 1) {
  # Datensatz aus Formularfeldern in Datenbank einf�gen
    my $sth = $dbh->prepare("INSERT INTO schranz_cms (docid,content,metatext,title,parent,created) values (?,?,?,?,?,NOW())");
    $sth->execute($.docid,$.content,$.metatext,$.title,(($.parentid > 0)?$.parentid:0));
    $msg = "Datensatz ". $.docid ." neu in DB aufgenommen.".$sth->rows();
#    $.insert(0);
  } else {
  # Datensatz in Datenbank �ndern
    my $sth = $dbh->prepare("UPDATE schranz_cms SET content = ?, title = ?, parent = ? WHERE docid = ?");
    $sth->execute($.content,$.title,$.parentid,$.docid);
    $msg = "Datensatz " . $.docid ." in DB ver&auml;ndert.".$sth->rows();
  }
} elsif ($.docid) {
# id erkannt, daten aus Datenbank lesen
  my $sth = $dbh->prepare("SELECT docid, title, content, created, parent, metatext from schranz_cms WHERE docid = ?");
  $sth->execute($.docid);
  my $res = $sth->fetchrow_hashref();
  $.content($res->{content} || $.content);
  $.title($res->{title});
  $.parentid($res->{parent});
  $msg = "Datensatz " . $.docid . " aus DB gelesen.".((defined($res) && scalar(keys(%$res)))?1:0);
} else {
# keine ID, neues Dokument erstellen
  my $sth = $dbh->prepare("SELECT max(docid) as maxdocid FROM schranz_cms");
  $sth->execute();
  my $res = $sth->fetchrow_hashref();
  $.docid($res->{maxdocid}+1);
  $.insert(1);
}
</%init>
