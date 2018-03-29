<html>
<head>
  <title>What is my IP address - determine or retrieve my IP address</title>
 </head>
<body>
 <?php
     if (getenv(HTTP_X_FORWARDED_FOR)) {
        $pipaddress = getenv(HTTP_X_FORWARDED_FOR);
        $ipaddress = getenv(REMOTE_ADDR);
        echo "Your Proxy IP address is : ".$pipaddress. " (via $ipaddress) " ;
    } else {
        $ipaddress = getenv(REMOTE_ADDR);
        echo "Your IP address is : $ipaddress";
    }
    $country = getenv(GEOIP_COUNTRY_NAME);
    $country_code = getenv(GEOIP_COUNTRY_CODE);
    echo "<br/>Your country : $country ( $country_code ) ";
?>
</body>
</html>