<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>BD Musisys - Alterar</title>
</head>
<?php
require('bdMusisys.php');
$clientes = new ArtistasMusisys;
$clientes->ArtistasMusisys();
?>
<body bgcolor="#FFFFFF">
<p><h3>Alterar um artista:</h3></p>
<form method="post" action="efetua_alteracao.php">

  <label for="codigo">Código:<?php echo $_POST["codigo"]; ?></label>
  <input type=hidden name="codigo" value=<?php echo $_POST["codigo"]; ?>>
  <br/>
  <br/>
  
  <label for="nome">Nome:</label><br/>
  <input type="text" name="nome" size="50" maxlength="50" value="<?php echo $clientes->devolveNome($_POST["codigo"]); ?>">
  <br/>
  <br/>
  
  <label for="palco"> Palco: </label><br/>
  <input type="number" name="palco" size="50" maxlength="50" value="<?php echo $clientes->devolvePalco($_POST["codigo"]); ?>">
  <br/>
  <br/>
  
  
  <br/>
  <?php $clientes->fecharBDArtistas(); ?>
  <input type="submit" name="Submit" value="Alterar">
	<input type="reset" name="reset" value="Limpar">
</form>
</body>
</html>