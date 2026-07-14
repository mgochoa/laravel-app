<?php

if (! function_exists('commit_hash')) {
    function commit_hash(): ?string
    {
        $path = storage_path('app/commit.txt');

        if (! file_exists($path)) {
            return null;
        }

        $hash = trim(file_get_contents($path));

        return strlen($hash) === 40 ? substr($hash, 0, 7) : null;
    }
}
