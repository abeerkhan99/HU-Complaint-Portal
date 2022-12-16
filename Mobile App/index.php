<?php

    require "controller.php";
    
    // $key = bin2hex(bytes(32));
    $key = "b5b4aa1bdcf20b6302f34d571c5b67d4c568acd57eb0588489ff3d538f7a7216";

    // echo 'Welcomeeeeee';

    header("Access-Control-Allow-Origin: *");
    
    $uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
    $uri = explode( '/', $uri );

    // all of our endpoints start with /hucp
    // everything else results in a 404 Not Found
    if ((isset($uri[2]) && $uri[2] != 'hucp') || !isset($uri[3])) {
        
        // header("HTTP/1.1 404 Not Found");
        exit();
        
    }

    // echo $uri[2];
    // echo $uri[3];

    // $requestMethod = $_SERVER["REQUEST_METHOD"];
    $controller = new HUCPController($uri[3]);
    $controller->processRequest();


    

?>