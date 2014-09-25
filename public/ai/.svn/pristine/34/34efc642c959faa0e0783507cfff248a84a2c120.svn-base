<?php
/*
* THIS FILE IS USED TO CREATE TRIGGERS ON THE FLY FOR THE PROVIDED LIST
OF TABLES AND ALSO CREATE AUDIT TABLES
*/

//correct these paramerts as per the requirement
$server = '192.168.13.89';
$user = 'root';
$pass = 'Q3tech123';
$dbase = 'mysql';

$conn = mysql_connect($server,$user,$pass);

$selectDb = mysql_select_db('Lisa_somaarth');

$tablesArr = array(
'classification_non_residential',
'dwellingunit','family_tree','household','household_birth_registration',
'household_death_registration','household_domestic_animals',
'household_furnishing','household_furniture','household_head_change',
'household_health_facilities','household_house_details','household_income',
'household_land_activity','household_land_owenership','household_land_sell_purchase',
'household_marital_status_change','household_modern_equipments',
'household_other_details','household_person','household_person_alcohol',
'household_person_details','household_person_disability',
'household_person_other_details','household_person_substance',
'household_person_tobacco','household_pregnancy_registration',
'household_social_status','household_vehicle','household_visitors',
'in_migration','migration','out_migration'
);

$sql = '';
foreach ($tablesArr as $table) {
	$auditTable = $table.'_audit';
	
	//drop audit table if exist
	$query = 'DROP TABLE IF EXISTS '.$auditTable.PHP_EOL;
	mysql_query($query);
	$sql .= $query;

	//create audit tables
	$query = 'CREATE TABLE '.$auditTable.' SELECT * FROM '.$table.PHP_EOL;
	mysql_query($query);
	$sql .= $query;

	//truncate audit table
	$query = 'TRUNCATE TABLE '.$auditTable.PHP_EOL;
	mysql_query($query);
	$sql .= $query;
	
	$triggerName = 'before_'.$table.'_update';
	
	//drop trigger
	$query = 'DROP TRIGGER IF EXISTS '.$triggerName.PHP_EOL;
	mysql_query($query);
	$sql .= $query;

	//get primary key name of the table
	$query  = 'SHOW KEYS FROM '.$table.' WHERE Key_name = "PRIMARY"';
	$result = mysql_fetch_array(mysql_query($query));
	$pkId   = $result['Column_name'];

	//create trigger
    $query  = 'CREATE TRIGGER '.$triggerName.PHP_EOL;
    $query .=  'BEFORE UPDATE ON '.$table.PHP_EOL;
    $query .=  'FOR EACH ROW '.PHP_EOL;
    $query .=   'BEGIN'.PHP_EOL;
    $query .=   'INSERT INTO '.$auditTable.' 
                 SELECT * FROM '.$table.PHP_EOL;
    $query .=   ' WHERE '.$pkId.'= OLD.'.$pkId.';'.PHP_EOL;
    $query .= 'END '.PHP_EOL;
    mysql_query($query) or die(mysql_error());
    $sql .= $query;

    echo 'Audit table and trigger created for '.$table.'<br/>';

}
?>