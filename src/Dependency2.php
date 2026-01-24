<?php

declare(strict_types=1);

namespace Test\DummyPhp;

use RuntimeException;

class Dependency2
{
    public function __construct()
    {
        throw new RuntimeException('test');
    }
}
