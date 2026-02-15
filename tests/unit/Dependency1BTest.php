<?php

declare(strict_types=1);

namespace Tests\Test\DummyPhp\Unit;

use PHPUnit\Framework\TestCase;
use Test\DummyPhp\Dependency1B;

class Dependency1BTest extends TestCase
{
    public function testCanInitialize(): void
    {
        $this->assertInstanceOf(Dependency1B::class, new Dependency1B());
    }
}
