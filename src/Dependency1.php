<?php

declare(strict_types=1);

namespace Test\DummyPhp;

class Dependency1
{
    public function __construct(
        private readonly Dependency1A $dependency1A,
        private readonly Dependency1B $dependency1B
    ) {
    }
}
