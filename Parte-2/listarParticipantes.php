<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>BD Loja - Listar</title></head>
<body background=#ffffff>
<p><h3>Listagem de produtos</h3></p>
<?php
require('bdMusisys.php');

$produtos = new ArtistasMusisys;
$produtos->ArtistasMusisys();
$produtos->listarArtistas($_POST["edicao"]);
$produtos->fecharBDArtistas();
?>
<br>
<a href="menuMusisys.html">voltar ao menu</a>
</body>
</html>