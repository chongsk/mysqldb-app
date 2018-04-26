<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once('/opt/conn.inc.php');

$sql = "insert into parameters( param_code, param_value) select now(), LEFT(UUID(), 8)  from dual";

$conn->exec($sql);



$sql = "SELECT distinct param_code, param_value FROM parameters";

$stmt = $conn->prepare($sql);

$stmt->execute();

$result = $stmt->fetchAll();


foreach( $result as $row )
{
    echo ("<div>" . $row['param_code'] ."=". $row['param_value'] . "</div>");
}



?>
