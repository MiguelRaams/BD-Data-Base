<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>BD Musisys - Listar</title></head>
<body background=#ffffff>
<p><h3>Pesquisar Artistas</h3></p>
<?php
require('bdMusisys.php');

$artistas = new ArtistasMusisys;
$artistas->ArtistasMusisys();
$artistas->pesquisarArtistasCodigo($_POST["codigo"]);
$artistas->fecharBDArtistas();
?>
<br>
<a href="menuMusisys.html">voltar ao menu</a>
</body>
</html>