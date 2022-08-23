<?php
 
$servername = "localhost";
$username = "id19260894_root";
$password = "Bigman,252525";
$dbname = "id19260894_phsensor";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
} 
 $sql = "SELECT id, phval, date, time FROM `ph_table`";

$result = $conn->query($sql);
$data =array();
if ($result->num_rows > 0) {
  // output data of each row
  while($row = $result->fetch_assoc()) {
   // echo "id: " . $row["id"]. "  phval: " . $row["phval"]. "date: " . $row["date"]. "time: " . $row["time"]. "<br>";
 $data = array(
        'id' => $row["id"],
        'phval' => $row["phval"],
        'date' => $row["date"],
        'time'=>$row["time"]
    );
  }
  $json_data = json_encode($data);
  echo $json_data;
} else {
  echo "0 results";
}
//echo json_encode($result);
$conn->close();
?>