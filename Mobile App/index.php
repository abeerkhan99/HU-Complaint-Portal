<?php

    require "controller.php";

    // echo 'Welcomeeeeee';

    header("Access-Control-Allow-Origin: *");
    $uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
    $uri = explode( '/', $uri );

    // all of our endpoints start with /hucp
    // everything else results in a 404 Not Found
    if ((isset($uri[2]) && $uri[2] != 'hucp') || !isset($uri[3])) {
        header("HTTP/1.1 404 Not Found");
        exit();
    }


    // echo $uri[2];
    // echo $uri[3];

    // $requestMethod = $_SERVER["REQUEST_METHOD"];

    // pass the request method and user ID to the PersonController and process the HTTP request:
    $controller = new HUCPController($uri[3]);
    $controller->processRequest();


?>