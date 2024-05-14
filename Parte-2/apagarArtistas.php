<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>BD Musisys - Apagar</title></head>
<body background=#ffffff>
<p><h3>Apagar Artista </h3></p>

<?php
require('bdMusisys.php');
$produtos = new ArtistasMusisys;
$produtos->ArtistasMusisys();
$produtos->apagarArtista($_POST["codigo"]);
$produtos->fecharBDArtistas();
?>
<br>
Artista removido com sucesso!
<br><br>
<a href="ListarEdicoes.php">voltar</a> | <a href="menuMusisys.html">voltar ao menu</a>
</body>
</html>
