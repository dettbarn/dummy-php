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

    public function get1(): Dependency1
    {
        return $this->dependency1;
    }

    public function get2(): Dependency2
    {
        return $this->dependency2;
    }
}
