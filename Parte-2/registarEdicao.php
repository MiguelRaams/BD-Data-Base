<html>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<head><title>BD Musisys - Registar</title>
</head>
<body background=#ffffff>
<?php
require('bdMusisys.php');

$clientes = new Edicao;
$clientes->Edicao();
$clientes->novaEdicao($_POST["codigo"], $_POST["nome"],$_POST["localidade"], $_POST["local"],$_POST["inicio"], $_POST["fim"],$_POST["lotacao"]);
$clientes->fecharBDMusisys();
?>
<br>
<a href="menuMusisys.html">voltar ao menu</a>
</body>
</html>