<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>BD Loja - Listar</title></head>
<body background=#ffffff>
<p><h3>Listagem de Edições</h3></p>
<?php
require('bdMusisys.php');

$produtos = new Edicao;
$produtos->Edicao();
$produtos->listarEdicoes();
$produtos->fecharBDMusisys();
?>
<br>
<a href="menuMusisys.html">voltar ao menu</a>
</body>
</html>