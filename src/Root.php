<?php

declare(strict_types=1);

namespace Test\DummyPhp;

class Root
{
    public function __construct(
        private readonly Dependency1 $dependency1,
        private readonly Dependency2 $dependency2
    ) {
    }
}
