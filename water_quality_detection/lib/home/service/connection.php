<?php

try{
$connection =new PDO('mysql:DB Host=localhost,dbname=id19260894_phsensor','id19260894_root','Bigman,252525');
$connection->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
echo "Connected well";
}
catch(PDOException $exc){
echo $exc -> getMessage();
die("Connection failed");
}

?>
