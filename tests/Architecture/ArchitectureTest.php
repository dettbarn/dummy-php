<?php

declare(strict_types=1);

namespace Tests\Test\DummyPhp\Architecture;

use PHPat\Selector\Selector;
use PHPat\Test\Builder\Rule;
use PHPat\Test\PHPat;
use Test\DummyPhp\Dependency1A;
use Test\DummyPhp\Dependency1B;
use Test\DummyPhp\Dependency1;
use Test\DummyPhp\Dependency2;
use Test\DummyPhp\Root;

final class ArchitectureTest
{
    public function testLayeredArchitecture(): Rule
    {
        return PHPat::rule()
        ->classes(
            Selector::classname(Dependency1A::class),
            Selector::classname(Dependency1B::class)
        )
        ->shouldNotDependOn()
        ->classes(
            Selector::classname(Root::class),
            Selector::classname(Dependency1::class),
            Selector::classname(Dependency2::class)
        )
        ->because('this would break the simplistic layered architecture');
    }

    public function testTestsAreNotUsedByProd(): Rule
    {
        return PHPat::rule()
        ->classes(
            Selector::inNamespace('Test\DummyPhp')
        )
        ->shouldNotDependOn()
        ->classes(
            Selector::inNamespace('Tests')
        )
        ->because('obviously the application code should not depend on the tests');
    }
}
