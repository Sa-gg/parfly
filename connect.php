<?php
$conn = mysqli_connect("localhost", "root", "", "parfly");

if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}