<!doctype html>
<html lang="en">
<form name="form3" method="post">
  <input name="query" type="text" id="query" style="width: 340px;">
  <input type="submit" name="create" value="Create">
</form>
</html>

<?php 


define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', '');
define('DB_NAME', 'student details(mini project)');

$conn = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);



//session_start(); //To start the session

// $query=mysqli_query($con,your query); 
// //made query after establishing connection with database.

// Define $sqlstatement

//$sqlstatement = $_POST['sqlstatement']; 

// runs statement
//$sql = "$sqlstatement";

//$res = mysqli_query($conn,$sql);

//echo $sql;
// echo $result;

if(isset($_POST['create']))
{
$query=$_POST['query']; 
echo $query;
}

$res = mysqli_query($conn,$query);



//Print the column names as the headers of a table

echo "<table><tr>";

    $field_info = $res->fetch_fields();
    foreach($field_info as $var){
    echo "<th>".$var->name."</th>";}


// Print the data
while($row = mysqli_fetch_row($res)) {
    echo "<tr>";
    foreach($row as $_column) {
        echo "<td>{$_column}</td>";
    }
    echo "</tr>";
}

echo "</table>";


// <form name="form3" method="post" action="">
// <input name="sqlstatement" type="text" value="Test" style="width: 340px;">
// <input type="submit" name="create" value="Create">

?>



