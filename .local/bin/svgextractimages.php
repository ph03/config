#!/usr/bin/env php
<?php

$svgs = glob('*.svg');

$existing = array();

foreach ($svgs as $svg){
    mkdir("./{$svg}.images");
    $lines = file($svg);
    $img = 0;
    foreach ($lines as $line){
        if (preg_match('%xlink:href="data:([a-z0-9-/]+);base64,([^"]+)"%i', $line, $regs)) {
            $type = $regs[1];
            $data = $regs[2];
            $md5 = md5($data);
            if (!in_array($md5, $existing)) {
                $data = str_replace(' ', "\r\n", $data);
                $data = base64_decode($data);
                $type = explode('/', $type);
                $save = "./{$svg}.images/{$img}.{$type[1]}";
                file_put_contents($save, $data);
                $img++;
                $existing[] = $md5;
            }
        } else {
            $result = "";
        }
    }
}

echo count($existing);
