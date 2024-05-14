<?php

class BDMusisys {
  /**Variável da classe que permite guardar a ligação à base de dados.*/
  var $conn;

  /**Função para ligar à BD da Musisys
   @return Um valor indicando qual o resultado da ligação à base de dados.*/
   function ligarBD() {
      $this->conn = mysqli_connect("localhost", "root", "", "musisys_3");
	  if(!$this->conn){
		return -1;
	  }
	}
 
 /**Executa um determinado comando SQL, retornando o seu resultado.  
 @param sql_command Comando SQL a ser executado pela função
 @return O resultado do comando SQL.*/
  function executarSQL($sql_command) {
    $resultado = mysqli_query( $this->conn, $sql_command);
    return $resultado;
 }
 
 /**Devolve o número de registos de uma determinada tabela numa base de dados
 @param tabela O nome da tabela onde se deseja verificar o numero de registos.
 @return O numero de registos da tabela.*/
 function numero_tuplos($tabela) {
     $tuplos=0;
	 $rs=$this->executarSQL("SELECT * FROM $tabela");
	 return mysqli_num_rows($rs);  
 }
 
 /**Fecha a ligação à base de dados*/
 function fecharBD() {
 mysqli_close($this->conn);
 }

}


/**Esta classe implementa a gestão de edições na base de dados da Musisys. Permite
efectuar toda uma série de operações sobre a tabela de edições.*/

class Edicao extends BDMusisys {
 /**Esta variável da classe é responsável pelas operações directas na Base de dados.*/
 var $db_musisys;
 /**Inicializa as edições da Musisys, e as variáveis da classe.*/
 
 function Edicao() {
    $this->db_musisys = new BDMusisys;
	$this->db_musisys->ligarBD(); 
 }
 
 /**Permite a introdução de uma nova edição na base de dados.*/
 
 function novaEdicao($codigo, $nome, $localidade, $local_e, $inicio, $fim, $lotacao) {
    $sql = "INSERT INTO edicao (numero,nome, localidade,local_e,data_inicio,data_fim,lotacao) VALUES ($codigo, '$nome','$localidade', '$local_e', '$inicio', '$fim', $lotacao)";
    $this->db_musisys->executarSQL($sql);
 }
 

  /**Lista todas as edições da base de dados*/
  function listarEdicoes() {
	  echo "<table border=1 cellpadding=0 cellspacing=0>\n";
	  $result_set = $this->db_musisys->executarSQL("SELECT e.numero, e.nome, e.nr_participantes FROM edicao e");
	  $tuplos = mysqli_num_rows($result_set);  // old: $this->db_musisys->numero_tuplos("produto");
	  if ($tuplos > 0) {
		  for($registo=0; $registo < $tuplos; $registo++) {
			  echo "<tr>\n";
			  $row = mysqli_fetch_assoc($result_set);
			  $this->escreveEdicaol($row["numero"], $row["nome"], $row["nr_participantes"]);
			  echo "</tr>\n";    
		  }
	   echo "</table>\n";
	  }
	  else {
		  echo "N&atilde;o foram encontradas edições";
	  }
  }

  function escreveEdicaol($numero,$nome,$nr_participantes){

printf("<td>$numero</td><td>$nome</td><td>$nr_participantes</td><form action=\"listarParticipantes.php\" method=post><td><input type=hidden name=edicao value=$numero><input type=submit value=Listar Participantes></td></form>\n");



  }

	  
  /**Escreve os detalhes de uma determinada edição
  */
  function escreveEdicao($codigo, $nome, $localidade, $local, $inicio, $fim, $lotacao) {
  printf("<td>$codigo</td><td>$nome</td><td>$localidade</td><td>$local</td><td>$inicio</td><td>$fim</td><td>$lotacao<td>\n");
  }

  

  
  /**Corta a ligação à base de dados*/
  function fecharBDMusisys() {
  $this->db_musisys->fecharBD();
  }
}


class ArtistasMusisys extends BDMusisys {
 /**Esta variável da classe é responsável pelas operações directas na Base de dados.*/
 var $db_musisys;
 /**Inicializa os Participantes da Musisys, e as variáveis da classe.*/
 
 function ArtistasMusisys() {
    $this->db_musisys = new BDMusisys;
	$this->db_musisys->ligarBD(); 
 }
 
 /**Permite a introdução de um novo artista na base de dados.
*/
 
 function novoArtista($codigo, $nome) {
    $sql = "INSERT INTO participante VALUES ($codigo, '$nome')";
    $this->db_musisys->executarSQL($sql);
 }


 function pesquisarArtistasCodigo($filtro) {
  echo "<table border=1 cellpadding=0 cellspacing=0>\n";
  $result_set = $this->db_musisys->executarSQL("SELECT p.* FROM participante p WHERE p.codigo LIKE '%$filtro%'");
  $n_r =0;
  while($row = mysqli_fetch_assoc($result_set)){
  $n_r =1;
  echo "<tr>\n";
  $this->escreveArtistaP($row["codigo"], $row["nome"]);
  echo "</tr>\n";    
  }
  echo "</table>\n";
  if($n_r ==0)
    echo "N&atilde;o foram encontrados artistas";
  
}

function escreveArtistaP($codigo, $nome,) {
	printf("<td>$codigo</td><td>$nome</td>\n");
  }


function pesquisaAvan($filtro1, $filtro2){
  echo "<table border=1 cellpadding=0 cellspacing=0>\n";
  $result_set = $this->db_musisys->executarSQL("SELECT p.*, c.Palco_codigo FROM participante p, contrata c WHERE c.Palco_codigo LIKE $filtro1 AND c.Participante_codigo_ LIKE p.codigo HAVING (SELECT COUNT(*) FROM entrevista e WHERE e.Participante_codigo_ LIKE p.codigo)>=$filtro2");
  $n_r =0;
  while($row = mysqli_fetch_assoc($result_set)){
  $n_r =1;
  echo "<tr>\n";
  $this->escreveArtistaP($row["codigo"],$row["nome"]);
  echo "</tr>\n";    
  }
  echo "</table>\n";
  if($n_r ==0)
    echo "N&atilde;o foram encontrados artistas";
  
}



  /**Lista todos os participantes da base de dados*/
  function listarArtistas($edicao) {
	  echo "<table border=1 cellpadding=0 cellspacing=0>\n";
	  $result_set = $this->db_musisys->executarSQL("SELECT p.*, c.Palco_codigo, c.Palco_Edicao_numero FROM participante p , contrata c WHERE c.Edicao_numero_ LIKE '%$edicao%' AND c.Participante_codigo_ LIKE p.codigo");
	  $tuplos = mysqli_num_rows($result_set);  
	  if ($tuplos > 0) {
		  for($registo=0; $registo < $tuplos; $registo++) {
			  echo "<tr>\n";
			  $row = mysqli_fetch_assoc($result_set);
			  $this->escreveArtista($row["codigo"], $row["nome"], $row["Palco_codigo"]);
			  echo "</tr>\n";    
		  }
	  }
	  else {
		  echo "N&atilde;o foram encontrados artistas";
	  }
  }

  function apagarArtista($codigo){
    $sql = "DELETE FROM participante WHERE codigo = $codigo";
    $this->db_musisys->executarSQL($sql);


  }

  function alterarPalcoArtista($codigo, $palco){
    $sql = "UPDATE contrata SET Palco_codigo = $palco WHERE Participante_codigo_ LIKE '%$codigo%'";
    $this->db_musisys->executarSQL($sql);



  }
	  
  /**Escreve os detalhes de um determinado participante
 */
  function escreveArtista($codigo, $nome,$Palco_codigo) {
	printf("<td>$codigo</td><td>$nome</td><td>$Palco_codigo</td><form action=\"apagarArtistas.php\" method=post><td><input type=hidden name=codigo value=$codigo><input type=submit value=Apagar></td></form><form action=\"alterarPalcoArtista.php\" method=post><td><input type=hidden name=codigo value=$codigo><input type=submit value=Alterar></td></form>\n");
  }

  
  function devolvePalco($codigo) {
  $sql="SELECT Palco_codigo FROM contrata WHERE Participante_codigo_ LIKE '%$codigo%'";
  $result_set = $this->db_musisys->executarSQL($sql);
  $row = mysqli_fetch_assoc($result_set);
  return $row["Palco_codigo"];
  }

  function devolveNome($codigo){
    $sql="SELECT nome FROM participante WHERE codigo LIKE '%$codigo%'";
    $result_set = $this->db_musisys->executarSQL($sql);
    $row = mysqli_fetch_assoc($result_set);
    return $row["nome"];

  
  }

  
  /**Corta a ligação à base de dados*/
  function fecharBDArtistas() {
  $this->db_musisys->fecharBD();
  }
}

?>
