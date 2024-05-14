<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>BD Musisys - Alterar</title>
</head>
<body bgcolor="#FFFFFF">

<?php
require('bdMusisys.php');
$produtos = new ArtistasMusisys;
$produtos->ArtistasMusisys();
$produtos->alterarPalcoArtista($_POST["codigo"], $_POST["palco"]);
$produtos->fecharBDArtistas();
?>
<br>
<p>Alteração efetuada com sucesso!</p>
<br>
<br>
<a href="listarEdicoes.php">voltar</a> | <a href="menuMusisys.html">voltar ao menu</a>

</body>
</html>
